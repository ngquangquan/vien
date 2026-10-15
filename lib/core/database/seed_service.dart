import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';

import 'app_database.dart';

class SeedService {
  final AppDatabase db;

  SeedService(this.db);

  Future<bool> seedFromAsset({
    String assetPath = 'assets/seed/initial_seed.json',
  }) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      return await seedFromJsonString(jsonString);
    } catch (e) {
      // If rootBundle is unavailable (e.g. in headless unit test without flutter asset bundle),
      // callers can use seedFromJsonMap directly.
      return false;
    }
  }

  Future<bool> seedFromJsonString(String jsonString) async {
    final Map<String, dynamic> data =
        json.decode(jsonString) as Map<String, dynamic>;
    return await seedFromJsonMap(data);
  }

  Future<bool> seedFromJsonMap(Map<String, dynamic> data) async {
    final seedVersion = data['version'] as int? ?? 1;

    // Check existing seed version in user_settings
    final existingSetting = await (db.select(
      db.userSettings,
    )..where((tbl) => tbl.key.equals('seed_version'))).getSingleOrNull();

    if (existingSetting != null) {
      final installedVersion = int.tryParse(existingSetting.valueJson) ?? 0;
      if (installedVersion >= seedVersion) {
        // Already installed this version or higher
        return false;
      }
    }

    await db.transaction(() async {
      final now = DateTime.now().millisecondsSinceEpoch;

      // 1. Content sources
      final sources = data['sources'] as List<dynamic>? ?? [];
      for (final s in sources) {
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
      final tags = data['tags'] as List<dynamic>? ?? [];
      for (final t in tags) {
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
      final headwords = data['headwords'] as List<dynamic>? ?? [];
      for (final hw in headwords) {
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

        // Pronunciations
        final prons = hwMap['pronunciations'] as List<dynamic>? ?? [];
        for (final p in prons) {
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

        // Inflections
        final infs = hwMap['inflections'] as List<dynamic>? ?? [];
        for (final inf in infs) {
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

        // Senses
        final senses = hwMap['senses'] as List<dynamic>? ?? [];
        for (final s in senses) {
          final sMap = s as Map<String, dynamic>;
          final senseId = sMap['id'] as String;

          // Insert study item parent
          await db
              .into(db.studyItems)
              .insertOnConflictUpdate(
                StudyItemsCompanion.insert(
                  id: senseId,
                  itemType: 'sense',
                  createdAtMs: hwMap['createdAtMs'] as int? ?? now,
                ),
              );

          // Insert sense
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

          // Senses tags
          final tagIds = sMap['tags'] as List<dynamic>? ?? [];
          for (final tagId in tagIds) {
            await db
                .into(db.itemTags)
                .insertOnConflictUpdate(
                  ItemTagsCompanion.insert(
                    studyItemId: senseId,
                    tagId: tagId as String,
                  ),
                );
          }

          // Examples
          final examples = sMap['examples'] as List<dynamic>? ?? [];
          for (final ex in examples) {
            final exMap = ex as Map<String, dynamic>;
            await db
                .into(db.examples)
                .insertOnConflictUpdate(
                  ExamplesCompanion.insert(
                    id: exMap['id'] as String,
                    studyItemId: senseId,
                    englishText: exMap['englishText'] as String,
                    vietnameseText: Value(exMap['vietnameseText'] as String?),
                    note: Value(exMap['note'] as String?),
                    sortOrder: Value(exMap['sortOrder'] as int? ?? 0),
                  ),
                );
          }

          // Initialise Learning Progress
          await db
              .into(db.learningProgress)
              .insertOnConflictUpdate(
                LearningProgressCompanion.insert(
                  studyItemId: senseId,
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

      // 4. Phrases
      final phrases = data['phrases'] as List<dynamic>? ?? [];
      for (final ph in phrases) {
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

        // Phrase senses
        final senses = phMap['senses'] as List<dynamic>? ?? [];
        for (final s in senses) {
          final sMap = s as Map<String, dynamic>;
          final senseId = sMap['id'] as String;

          await db
              .into(db.studyItems)
              .insertOnConflictUpdate(
                StudyItemsCompanion.insert(
                  id: senseId,
                  itemType: 'phrase_sense',
                  createdAtMs: phMap['createdAtMs'] as int? ?? now,
                ),
              );

          await db
              .into(db.phraseSenses)
              .insertOnConflictUpdate(
                PhraseSensesCompanion.insert(
                  id: senseId,
                  phraseId: phId,
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

          final tagIds = sMap['tags'] as List<dynamic>? ?? [];
          for (final tagId in tagIds) {
            await db
                .into(db.itemTags)
                .insertOnConflictUpdate(
                  ItemTagsCompanion.insert(
                    studyItemId: senseId,
                    tagId: tagId as String,
                  ),
                );
          }

          final examples = sMap['examples'] as List<dynamic>? ?? [];
          for (final ex in examples) {
            final exMap = ex as Map<String, dynamic>;
            await db
                .into(db.examples)
                .insertOnConflictUpdate(
                  ExamplesCompanion.insert(
                    id: exMap['id'] as String,
                    studyItemId: senseId,
                    englishText: exMap['englishText'] as String,
                    vietnameseText: Value(exMap['vietnameseText'] as String?),
                    note: Value(exMap['note'] as String?),
                    sortOrder: Value(exMap['sortOrder'] as int? ?? 0),
                  ),
                );
          }

          await db
              .into(db.learningProgress)
              .insertOnConflictUpdate(
                LearningProgressCompanion.insert(
                  studyItemId: senseId,
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

      // 5. Questions
      final questions = data['questions'] as List<dynamic>? ?? [];
      for (final q in questions) {
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

        final options = qMap['options'] as List<dynamic>? ?? [];
        for (final opt in options) {
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

      // Record seed version
      await db
          .into(db.userSettings)
          .insertOnConflictUpdate(
            UserSettingsCompanion.insert(
              key: 'seed_version',
              valueJson: seedVersion.toString(),
              updatedAtMs: now,
            ),
          );
    });

    return true;
  }
}
