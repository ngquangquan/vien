import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'app_database.dart';

/// Manages seeding of initial/updated content into the database.
///
/// Architecture: manifest-based, per-file versioning.
/// - [assets/seed/manifest.json] lists every seed file and its version.
/// - Each file installed version is stored in [user_settings] under key
///   `seed_file:<relative-path>`.
/// - Only files whose manifest version exceeds the installed version are
///   processed — unchanged files are never read after first install.
/// - Files are loaded one at a time so RAM stays bounded even with
///   thousands of entries spread across many files.
///
/// To add new data: edit the relevant file and bump its version in manifest.json.
class SeedService {
  final AppDatabase db;

  static const String _manifestPath = 'assets/seed/manifest.json';
  static const String _seedFileKeyPrefix = 'seed_file:';

  SeedService(this.db);

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Main entry point for production. Reads manifest and seeds only changed files.
  Future<void> seedFromAssets() async {
    try {
      final manifestString = await rootBundle.loadString(_manifestPath);
      final manifest = json.decode(manifestString) as Map<String, dynamic>;
      final files =
          (manifest['files'] as List<dynamic>).cast<Map<String, dynamic>>();

      for (final entry in files) {
        final relativePath = entry['path'] as String;
        final targetVersion = entry['version'] as int;
        final settingKey = '$_seedFileKeyPrefix$relativePath';

        final installed = await _installedVersion(settingKey);
        if (installed >= targetVersion) continue;

        await _processAssetFile(
          'assets/seed/$relativePath',
          settingKey,
          targetVersion,
        );
      }
    } catch (e) {
      debugPrint('SeedService: manifest error — $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Test / legacy helpers
  // ---------------------------------------------------------------------------

  /// Used by unit tests: accepts a pre-decoded JSON map and seeds it.
  /// Respects the top-level [version] field via a legacy seed_version gate.
  Future<bool> seedFromJsonMap(Map<String, dynamic> data) async {
    final seedVersion = data['version'] as int? ?? 1;

    final existing = await (db.select(
      db.userSettings,
    )..where((tbl) => tbl.key.equals('seed_version'))).getSingleOrNull();

    if (existing != null) {
      final installed = int.tryParse(existing.valueJson) ?? 0;
      if (installed >= seedVersion) return false;
    }

    await _runSeedTransaction(data);

    final now = DateTime.now().millisecondsSinceEpoch;
    await db
        .into(db.userSettings)
        .insertOnConflictUpdate(
          UserSettingsCompanion.insert(
            key: 'seed_version',
            valueJson: seedVersion.toString(),
            updatedAtMs: now,
          ),
        );
    return true;
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<int> _installedVersion(String settingKey) async {
    final row = await (db.select(
      db.userSettings,
    )..where((t) => t.key.equals(settingKey))).getSingleOrNull();
    return row != null ? (int.tryParse(row.valueJson) ?? 0) : 0;
  }

  Future<void> _processAssetFile(
    String assetPath,
    String settingKey,
    int targetVersion,
  ) async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final data = json.decode(raw) as Map<String, dynamic>;
      await _runSeedTransaction(data);

      final now = DateTime.now().millisecondsSinceEpoch;
      await db
          .into(db.userSettings)
          .insertOnConflictUpdate(
            UserSettingsCompanion.insert(
              key: settingKey,
              valueJson: targetVersion.toString(),
              updatedAtMs: now,
            ),
          );
    } catch (e) {
      debugPrint('SeedService: failed to process $assetPath — $e');
    }
  }

  /// Core seed logic. Processes whichever sections are present in [data].
  /// All inserts use [insertOnConflictUpdate] — safe to run multiple times.
  Future<void> _runSeedTransaction(Map<String, dynamic> data) async {
    await db.transaction(() async {
      final now = DateTime.now().millisecondsSinceEpoch;

      // 1. Content sources
      for (final s in (data['sources'] as List<dynamic>? ?? [])) {
        final src = s as Map<String, dynamic>;
        await db
            .into(db.contentSources)
            .insertOnConflictUpdate(
              ContentSourcesCompanion.insert(
                id: src['id'] as String,
                name: src['name'] as String,
                licence: Value(src['licence'] as String?),
                url: Value(src['url'] as String?),
              ),
            );
      }

      // 2. Tags
      for (final t in (data['tags'] as List<dynamic>? ?? [])) {
        final tag = t as Map<String, dynamic>;
        await db
            .into(db.tags)
            .insertOnConflictUpdate(
              TagsCompanion.insert(
                id: tag['id'] as String,
                slug: tag['slug'] as String,
                name: tag['name'] as String,
                category: tag['category'] as String,
                description: Value(tag['description'] as String?),
              ),
            );
      }

      // 3. Headwords
      for (final hw in (data['headwords'] as List<dynamic>? ?? [])) {
        final hwMap = hw as Map<String, dynamic>;
        final hwId = hwMap['id'] as String;

        await db
            .into(db.headwords)
            .insertOnConflictUpdate(
              HeadwordsCompanion.insert(
                id: hwId,
                spelling: hwMap['spelling'] as String,
                normalizedSpelling: (hwMap['normalizedSpelling'] as String)
                    .toLowerCase()
                    .trim(),
                homographNo: Value(hwMap['homographNo'] as int? ?? 1),
                cefrLevel: Value(hwMap['cefrLevel'] as String?),
                notes: Value(hwMap['notes'] as String?),
                isArchived: Value(hwMap['isArchived'] as int? ?? 0),
                createdAtMs: hwMap['createdAtMs'] as int? ?? now,
                updatedAtMs: hwMap['updatedAtMs'] as int? ?? now,
              ),
            );

        for (final p in (hwMap['pronunciations'] as List<dynamic>? ?? [])) {
          final pMap = p as Map<String, dynamic>;
          await db
              .into(db.pronunciations)
              .insertOnConflictUpdate(
                PronunciationsCompanion.insert(
                  id: pMap['id'] as String,
                  headwordId: Value(hwId),
                  accent: pMap['accent'] as String,
                  ipa: Value(pMap['ipa'] as String?),
                  audioAssetKey: Value(pMap['audioAssetKey'] as String?),
                ),
              );
        }

        for (final inf in (hwMap['inflections'] as List<dynamic>? ?? [])) {
          final infMap = inf as Map<String, dynamic>;
          await db
              .into(db.inflections)
              .insertOnConflictUpdate(
                InflectionsCompanion.insert(
                  id: infMap['id'] as String,
                  headwordId: hwId,
                  form: infMap['form'] as String,
                  formType: infMap['formType'] as String,
                ),
              );
        }

        for (final s in (hwMap['senses'] as List<dynamic>? ?? [])) {
          await _insertSense(s as Map<String, dynamic>, hwId, now);
        }
      }

      // 4. Phrases
      for (final ph in (data['phrases'] as List<dynamic>? ?? [])) {
        final phMap = ph as Map<String, dynamic>;
        final phId = phMap['id'] as String;

        await db
            .into(db.phrases)
            .insertOnConflictUpdate(
              PhrasesCompanion.insert(
                id: phId,
                phrase: phMap['phrase'] as String,
                normalizedPhrase: (phMap['normalizedPhrase'] as String)
                    .toLowerCase()
                    .trim(),
                phraseType: phMap['phraseType'] as String,
                cefrLevel: Value(phMap['cefrLevel'] as String?),
                notes: Value(phMap['notes'] as String?),
                isArchived: Value(phMap['isArchived'] as int? ?? 0),
                createdAtMs: phMap['createdAtMs'] as int? ?? now,
                updatedAtMs: phMap['updatedAtMs'] as int? ?? now,
              ),
            );

        for (final s in (phMap['senses'] as List<dynamic>? ?? [])) {
          await _insertPhraseSense(s as Map<String, dynamic>, phId, now);
        }
      }

      // 5. Questions
      for (final q in (data['questions'] as List<dynamic>? ?? [])) {
        final qMap = q as Map<String, dynamic>;
        final qId = qMap['id'] as String;

        await db
            .into(db.questions)
            .insertOnConflictUpdate(
              QuestionsCompanion.insert(
                id: qId,
                targetItemId: Value(qMap['targetItemId'] as String?),
                questionType: qMap['questionType'] as String,
                prompt: qMap['prompt'] as String,
                explanation: Value(qMap['explanation'] as String?),
                cefrLevel: Value(qMap['cefrLevel'] as String?),
                contentOrigin: qMap['contentOrigin'] as String,
                isActive: Value(qMap['isActive'] as int? ?? 1),
                createdAtMs: qMap['createdAtMs'] as int? ?? now,
              ),
            );

        for (final opt in (qMap['options'] as List<dynamic>? ?? [])) {
          final optMap = opt as Map<String, dynamic>;
          await db
              .into(db.questionOptions)
              .insertOnConflictUpdate(
                QuestionOptionsCompanion.insert(
                  id: optMap['id'] as String,
                  questionId: qId,
                  optionText: optMap['optionText'] as String,
                  sortOrder: optMap['sortOrder'] as int,
                  isCorrect: optMap['isCorrect'] as int,
                ),
              );
        }
      }
    });
  }

  Future<void> _insertSense(
    Map<String, dynamic> sMap,
    String hwId,
    int now,
  ) async {
    final senseId = sMap['id'] as String;

    await db
        .into(db.studyItems)
        .insertOnConflictUpdate(
          StudyItemsCompanion.insert(
            id: senseId,
            itemType: 'sense',
            createdAtMs: sMap['createdAtMs'] as int? ?? now,
          ),
        );

    await db
        .into(db.senses)
        .insertOnConflictUpdate(
          SensesCompanion.insert(
            id: senseId,
            headwordId: hwId,
            senseNumber: sMap['senseNumber'] as int,
            partOfSpeech: sMap['partOfSpeech'] as String,
            definitionEn: sMap['definitionEn'] as String,
            meaningVi: Value(sMap['meaningVi'] as String?),
            cefrLevel: Value(sMap['cefrLevel'] as String?),
            registerLabel: Value(sMap['registerLabel'] as String?),
            domainLabel: Value(sMap['domainLabel'] as String?),
            grammarNote: Value(sMap['grammarNote'] as String?),
            usageNote: Value(sMap['usageNote'] as String?),
            isActive: Value(sMap['isActive'] as int? ?? 1),
          ),
        );

    await _insertTagsAndExamples(sMap, senseId, now);
    await _initLearningProgress(senseId, now);
  }

  Future<void> _insertPhraseSense(
    Map<String, dynamic> sMap,
    String phraseId,
    int now,
  ) async {
    final senseId = sMap['id'] as String;

    await db
        .into(db.studyItems)
        .insertOnConflictUpdate(
          StudyItemsCompanion.insert(
            id: senseId,
            itemType: 'phrase_sense',
            createdAtMs: now,
          ),
        );

    await db
        .into(db.phraseSenses)
        .insertOnConflictUpdate(
          PhraseSensesCompanion.insert(
            id: senseId,
            phraseId: phraseId,
            senseNumber: Value(sMap['senseNumber'] as int? ?? 1),
            partOfSpeech: Value(sMap['partOfSpeech'] as String?),
            definitionEn: sMap['definitionEn'] as String,
            meaningVi: Value(sMap['meaningVi'] as String?),
            cefrLevel: Value(sMap['cefrLevel'] as String?),
            registerLabel: Value(sMap['registerLabel'] as String?),
            domainLabel: Value(sMap['domainLabel'] as String?),
            grammarNote: Value(sMap['grammarNote'] as String?),
            usageNote: Value(sMap['usageNote'] as String?),
            isActive: Value(sMap['isActive'] as int? ?? 1),
          ),
        );

    await _insertTagsAndExamples(sMap, senseId, now);
    await _initLearningProgress(senseId, now);
  }

  Future<void> _insertTagsAndExamples(
    Map<String, dynamic> sMap,
    String studyItemId,
    int now,
  ) async {
    for (final tagId in (sMap['tags'] as List<dynamic>? ?? [])) {
      await db
          .into(db.itemTags)
          .insertOnConflictUpdate(
            ItemTagsCompanion.insert(
              studyItemId: studyItemId,
              tagId: tagId as String,
            ),
          );
    }

    for (final ex in (sMap['examples'] as List<dynamic>? ?? [])) {
      final exMap = ex as Map<String, dynamic>;
      await db
          .into(db.examples)
          .insertOnConflictUpdate(
            ExamplesCompanion.insert(
              id: exMap['id'] as String,
              studyItemId: studyItemId,
              englishText: exMap['englishText'] as String,
              vietnameseText: Value(exMap['vietnameseText'] as String?),
              note: Value(exMap['note'] as String?),
              sortOrder: Value(exMap['sortOrder'] as int? ?? 0),
            ),
          );
    }
  }

  Future<void> _initLearningProgress(String studyItemId, int now) async {
    await db
        .into(db.learningProgress)
        .insertOnConflictUpdate(
          LearningProgressCompanion.insert(
            studyItemId: studyItemId,
            status: 'new',
            repetitionCount: const Value(0),
            intervalDays: const Value(0.0),
            easeFactor: const Value(2.5),
            lapses: const Value(0),
            dueAtMs: const Value(null),
            lastReviewedAtMs: const Value(null),
            totalCorrect: const Value(0),
            totalIncorrect: const Value(0),
            isFavorite: const Value(0),
            updatedAtMs: now,
          ),
        );
  }
}
