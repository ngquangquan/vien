import 'dart:convert';

import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../../features/vocabulary/data/vocabulary_repository.dart';
import '../../features/phrases/data/phrases_repository.dart';

class BackupPreview {
  final int schemaVersion;
  final int headwordsCount;
  final int phrasesCount;
  final int tagsCount;
  final int questionsCount;
  final int progressCount;
  final int reviewEventsCount;
  final List<String> warnings;

  const BackupPreview({
    required this.schemaVersion,
    required this.headwordsCount,
    required this.phrasesCount,
    required this.tagsCount,
    required this.questionsCount,
    required this.progressCount,
    required this.reviewEventsCount,
    this.warnings = const [],
  });
}

class BackupService {
  final AppDatabase db;
  final VocabularyRepository vocabRepo;
  final PhrasesRepository phrasesRepo;

  BackupService(this.db, this.vocabRepo, this.phrasesRepo);

  static const int currentSchemaVersion = 1;

  Future<String> exportToJsonString() async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Export tags
    final tags = await db.select(db.tags).get();
    final tagsJson = tags
        .map(
          (t) => {
            'id': t.id,
            'slug': t.slug,
            'name': t.name,
            'category': t.category,
            'description': t.description,
          },
        )
        .toList();

    // Export headwords with all relations
    final headwords = await db.select(db.headwords).get();
    final List<Map<String, dynamic>> headwordsJson = [];

    for (final hw in headwords) {
      final detail = await vocabRepo.getHeadwordDetail(hw.id);
      if (detail == null) continue;

      headwordsJson.add({
        'id': detail.headword.id,
        'spelling': detail.headword.spelling,
        'normalizedSpelling': detail.headword.normalizedSpelling,
        'homographNo': detail.headword.homographNo,
        'cefrLevel': detail.headword.cefrLevel,
        'notes': detail.headword.notes,
        'isArchived': detail.headword.isArchived,
        'createdAtMs': detail.headword.createdAtMs,
        'updatedAtMs': detail.headword.updatedAtMs,
        'pronunciations': detail.pronunciations
            .map(
              (p) => {
                'id': p.id,
                'accent': p.accent,
                'ipa': p.ipa,
                'audioAssetKey': p.audioAssetKey,
                'sourceNote': p.sourceNote,
                'licenceNote': p.licenceNote,
              },
            )
            .toList(),
        'inflections': detail.inflections
            .map(
              (inf) => {
                'id': inf.id,
                'form': inf.form,
                'formType': inf.formType,
              },
            )
            .toList(),
        'senses': detail.senses
            .map(
              (s) => {
                'id': s.sense.id,
                'senseNumber': s.sense.senseNumber,
                'partOfSpeech': s.sense.partOfSpeech,
                'definitionEn': s.sense.definitionEn,
                'meaningVi': s.sense.meaningVi,
                'cefrLevel': s.sense.cefrLevel,
                'registerLabel': s.sense.registerLabel,
                'domainLabel': s.sense.domainLabel,
                'grammarNote': s.sense.grammarNote,
                'usageNote': s.sense.usageNote,
                'isActive': s.sense.isActive,
                'tags': s.tags.map((t) => t.id).toList(),
                'examples': s.examples
                    .map(
                      (ex) => {
                        'id': ex.id,
                        'englishText': ex.englishText,
                        'vietnameseText': ex.vietnameseText,
                        'note': ex.note,
                        'sortOrder': ex.sortOrder,
                      },
                    )
                    .toList(),
              },
            )
            .toList(),
      });
    }

    // Export phrases
    final phrases = await db.select(db.phrases).get();
    final List<Map<String, dynamic>> phrasesJson = [];

    for (final ph in phrases) {
      final detail = await phrasesRepo.getPhraseDetail(ph.id);
      if (detail == null) continue;

      phrasesJson.add({
        'id': detail.phrase.id,
        'phrase': detail.phrase.phrase,
        'normalizedPhrase': detail.phrase.normalizedPhrase,
        'phraseType': detail.phrase.phraseType,
        'cefrLevel': detail.phrase.cefrLevel,
        'notes': detail.phrase.notes,
        'isArchived': detail.phrase.isArchived,
        'createdAtMs': detail.phrase.createdAtMs,
        'updatedAtMs': detail.phrase.updatedAtMs,
        'senses': detail.senses
            .map(
              (s) => {
                'id': s.sense.id,
                'senseNumber': s.sense.senseNumber,
                'partOfSpeech': s.sense.partOfSpeech,
                'definitionEn': s.sense.definitionEn,
                'meaningVi': s.sense.meaningVi,
                'cefrLevel': s.sense.cefrLevel,
                'registerLabel': s.sense.registerLabel,
                'domainLabel': s.sense.domainLabel,
                'grammarNote': s.sense.grammarNote,
                'usageNote': s.sense.usageNote,
                'isActive': s.sense.isActive,
                'tags': s.tags.map((t) => t.id).toList(),
                'examples': s.examples
                    .map(
                      (ex) => {
                        'id': ex.id,
                        'englishText': ex.englishText,
                        'vietnameseText': ex.vietnameseText,
                        'note': ex.note,
                        'sortOrder': ex.sortOrder,
                      },
                    )
                    .toList(),
              },
            )
            .toList(),
      });
    }

    // Export questions & options
    final questions = await db.select(db.questions).get();
    final List<Map<String, dynamic>> questionsJson = [];
    for (final q in questions) {
      final options = await (db.select(
        db.questionOptions,
      )..where((o) => o.questionId.equals(q.id))).get();
      questionsJson.add({
        'id': q.id,
        'targetItemId': q.targetItemId,
        'questionType': q.questionType,
        'prompt': q.prompt,
        'explanation': q.explanation,
        'cefrLevel': q.cefrLevel,
        'contentOrigin': q.contentOrigin,
        'isActive': q.isActive,
        'createdAtMs': q.createdAtMs,
        'options': options
            .map(
              (o) => {
                'id': o.id,
                'optionText': o.optionText,
                'sortOrder': o.sortOrder,
                'isCorrect': o.isCorrect,
              },
            )
            .toList(),
      });
    }

    // Export progress & review events
    final progressList = await db.select(db.learningProgress).get();
    final progressJson = progressList
        .map(
          (p) => {
            'studyItemId': p.studyItemId,
            'status': p.status,
            'repetitionCount': p.repetitionCount,
            'intervalDays': p.intervalDays,
            'easeFactor': p.easeFactor,
            'lapses': p.lapses,
            'dueAtMs': p.dueAtMs,
            'lastReviewedAtMs': p.lastReviewedAtMs,
            'totalCorrect': p.totalCorrect,
            'totalIncorrect': p.totalIncorrect,
            'isFavorite': p.isFavorite,
            'updatedAtMs': p.updatedAtMs,
          },
        )
        .toList();

    final reviewsList = await db.select(db.reviewEvents).get();
    final reviewsJson = reviewsList
        .map(
          (r) => {
            'id': r.id,
            'studyItemId': r.studyItemId,
            'questionId': r.questionId,
            'selectedOptionId': r.selectedOptionId,
            'isCorrect': r.isCorrect,
            'quality': r.quality,
            'elapsedMs': r.elapsedMs,
            'studyMode': r.studyMode,
            'answeredAtMs': r.answeredAtMs,
          },
        )
        .toList();

    final exportMap = {
      'schemaVersion': currentSchemaVersion,
      'exportedAt': now,
      'tags': tagsJson,
      'headwords': headwordsJson,
      'phrases': phrasesJson,
      'questions': questionsJson,
      'learningProgress': progressJson,
      'reviewEvents': reviewsJson,
    };

    return const JsonEncoder.withIndent('  ').convert(exportMap);
  }

  BackupPreview previewBackup(String jsonString) {
    final Map<String, dynamic> data =
        json.decode(jsonString) as Map<String, dynamic>;
    final version =
        data['schemaVersion'] as int? ?? (data['version'] as int? ?? 1);

    final tags = (data['tags'] as List<dynamic>?) ?? [];
    final headwords = (data['headwords'] as List<dynamic>?) ?? [];
    final phrases = (data['phrases'] as List<dynamic>?) ?? [];
    final questions = (data['questions'] as List<dynamic>?) ?? [];
    final progress = (data['learningProgress'] as List<dynamic>?) ?? [];
    final reviews = (data['reviewEvents'] as List<dynamic>?) ?? [];

    final List<String> warnings = [];
    if (version > currentSchemaVersion) {
      warnings.add(
        'Phiên bản bản sao lưu ($version) mới hơn phiên bản ứng dụng hiện tại ($currentSchemaVersion).',
      );
    }

    return BackupPreview(
      schemaVersion: version,
      headwordsCount: headwords.length,
      phrasesCount: phrases.length,
      tagsCount: tags.length,
      questionsCount: questions.length,
      progressCount: progress.length,
      reviewEventsCount: reviews.length,
      warnings: warnings,
    );
  }

  Future<void> restoreFromJsonString(
    String jsonString, {
    bool replaceMode = false,
  }) async {
    final Map<String, dynamic> data =
        json.decode(jsonString) as Map<String, dynamic>;

    await db.transaction(() async {
      if (replaceMode) {
        // Clear existing user data atomically
        await db.delete(db.reviewEvents).go();
        await db.delete(db.learningProgress).go();
        await db.delete(db.questionOptions).go();
        await db.delete(db.questions).go();
        await db.delete(db.examples).go();
        await db.delete(db.itemTags).go();
        await db.delete(db.senses).go();
        await db.delete(db.phraseSenses).go();
        await db.delete(db.studyItems).go();
        await db.delete(db.pronunciations).go();
        await db.delete(db.inflections).go();
        await db.delete(db.headwords).go();
        await db.delete(db.phrases).go();
        await db.delete(db.tags).go();
      }

      final now = DateTime.now().millisecondsSinceEpoch;

      // 1. Tags
      final tags = (data['tags'] as List<dynamic>?) ?? [];
      for (final t in tags) {
        final tm = t as Map<String, dynamic>;
        await db
            .into(db.tags)
            .insertOnConflictUpdate(
              TagsCompanion.insert(
                id: tm['id'] as String,
                slug: tm['slug'] as String,
                name: tm['name'] as String,
                category: tm['category'] as String,
                description: Value(tm['description'] as String?),
              ),
            );
      }

      // 2. Headwords
      final headwords = (data['headwords'] as List<dynamic>?) ?? [];
      for (final hw in headwords) {
        final hm = hw as Map<String, dynamic>;
        final hwId = hm['id'] as String;

        await db
            .into(db.headwords)
            .insertOnConflictUpdate(
              HeadwordsCompanion.insert(
                id: hwId,
                spelling: hm['spelling'] as String,
                normalizedSpelling: (hm['normalizedSpelling'] as String)
                    .toLowerCase(),
                homographNo: Value(hm['homographNo'] as int? ?? 1),
                cefrLevel: Value(hm['cefrLevel'] as String?),
                notes: Value(hm['notes'] as String?),
                isArchived: Value(hm['isArchived'] as int? ?? 0),
                createdAtMs: hm['createdAtMs'] as int? ?? now,
                updatedAtMs: hm['updatedAtMs'] as int? ?? now,
              ),
            );

        final prons = (hm['pronunciations'] as List<dynamic>?) ?? [];
        for (final p in prons) {
          final pm = p as Map<String, dynamic>;
          await db
              .into(db.pronunciations)
              .insertOnConflictUpdate(
                PronunciationsCompanion.insert(
                  id: pm['id'] as String,
                  headwordId: Value(hwId),
                  accent: pm['accent'] as String,
                  ipa: Value(pm['ipa'] as String?),
                  audioAssetKey: Value(pm['audioAssetKey'] as String?),
                  sourceNote: Value(pm['sourceNote'] as String?),
                  licenceNote: Value(pm['licenceNote'] as String?),
                ),
              );
        }

        final infs = (hm['inflections'] as List<dynamic>?) ?? [];
        for (final inf in infs) {
          final im = inf as Map<String, dynamic>;
          await db
              .into(db.inflections)
              .insertOnConflictUpdate(
                InflectionsCompanion.insert(
                  id: im['id'] as String,
                  headwordId: hwId,
                  form: im['form'] as String,
                  formType: im['formType'] as String,
                ),
              );
        }

        final senses = (hm['senses'] as List<dynamic>?) ?? [];
        for (final s in senses) {
          final sm = s as Map<String, dynamic>;
          final senseId = sm['id'] as String;

          await db
              .into(db.studyItems)
              .insertOnConflictUpdate(
                StudyItemsCompanion.insert(
                  id: senseId,
                  itemType: 'sense',
                  createdAtMs: now,
                ),
              );

          await db
              .into(db.senses)
              .insertOnConflictUpdate(
                SensesCompanion.insert(
                  id: senseId,
                  headwordId: hwId,
                  senseNumber: sm['senseNumber'] as int,
                  partOfSpeech: sm['partOfSpeech'] as String,
                  definitionEn: sm['definitionEn'] as String,
                  meaningVi: Value(sm['meaningVi'] as String?),
                  cefrLevel: Value(sm['cefrLevel'] as String?),
                  registerLabel: Value(sm['registerLabel'] as String?),
                  domainLabel: Value(sm['domainLabel'] as String?),
                  grammarNote: Value(sm['grammarNote'] as String?),
                  usageNote: Value(sm['usageNote'] as String?),
                  isActive: Value(sm['isActive'] as int? ?? 1),
                ),
              );

          final tagIds = (sm['tags'] as List<dynamic>?) ?? [];
          for (final tid in tagIds) {
            await db
                .into(db.itemTags)
                .insertOnConflictUpdate(
                  ItemTagsCompanion.insert(
                    studyItemId: senseId,
                    tagId: tid as String,
                  ),
                );
          }

          final examples = (sm['examples'] as List<dynamic>?) ?? [];
          for (final ex in examples) {
            final em = ex as Map<String, dynamic>;
            await db
                .into(db.examples)
                .insertOnConflictUpdate(
                  ExamplesCompanion.insert(
                    id: em['id'] as String,
                    studyItemId: senseId,
                    englishText: em['englishText'] as String,
                    vietnameseText: Value(em['vietnameseText'] as String?),
                    note: Value(em['note'] as String?),
                    sortOrder: Value(em['sortOrder'] as int? ?? 0),
                  ),
                );
          }
        }
      }

      // 3. Phrases
      final phrases = (data['phrases'] as List<dynamic>?) ?? [];
      for (final ph in phrases) {
        final pm = ph as Map<String, dynamic>;
        final phId = pm['id'] as String;

        await db
            .into(db.phrases)
            .insertOnConflictUpdate(
              PhrasesCompanion.insert(
                id: phId,
                phrase: pm['phrase'] as String,
                normalizedPhrase: (pm['normalizedPhrase'] as String)
                    .toLowerCase(),
                phraseType: pm['phraseType'] as String,
                cefrLevel: Value(pm['cefrLevel'] as String?),
                notes: Value(pm['notes'] as String?),
                isArchived: Value(pm['isArchived'] as int? ?? 0),
                createdAtMs: pm['createdAtMs'] as int? ?? now,
                updatedAtMs: pm['updatedAtMs'] as int? ?? now,
              ),
            );

        final senses = (pm['senses'] as List<dynamic>?) ?? [];
        for (final s in senses) {
          final sm = s as Map<String, dynamic>;
          final senseId = sm['id'] as String;

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
                  phraseId: phId,
                  senseNumber: Value(sm['senseNumber'] as int? ?? 1),
                  partOfSpeech: Value(sm['partOfSpeech'] as String?),
                  definitionEn: sm['definitionEn'] as String,
                  meaningVi: Value(sm['meaningVi'] as String?),
                  cefrLevel: Value(sm['cefrLevel'] as String?),
                  registerLabel: Value(sm['registerLabel'] as String?),
                  domainLabel: Value(sm['domainLabel'] as String?),
                  grammarNote: Value(sm['grammarNote'] as String?),
                  usageNote: Value(sm['usageNote'] as String?),
                  isActive: Value(sm['isActive'] as int? ?? 1),
                ),
              );

          final tagIds = (sm['tags'] as List<dynamic>?) ?? [];
          for (final tid in tagIds) {
            await db
                .into(db.itemTags)
                .insertOnConflictUpdate(
                  ItemTagsCompanion.insert(
                    studyItemId: senseId,
                    tagId: tid as String,
                  ),
                );
          }

          final examples = (sm['examples'] as List<dynamic>?) ?? [];
          for (final ex in examples) {
            final em = ex as Map<String, dynamic>;
            await db
                .into(db.examples)
                .insertOnConflictUpdate(
                  ExamplesCompanion.insert(
                    id: em['id'] as String,
                    studyItemId: senseId,
                    englishText: em['englishText'] as String,
                    vietnameseText: Value(em['vietnameseText'] as String?),
                    note: Value(em['note'] as String?),
                    sortOrder: Value(em['sortOrder'] as int? ?? 0),
                  ),
                );
          }
        }
      }

      // 4. Questions
      final questions = (data['questions'] as List<dynamic>?) ?? [];
      for (final q in questions) {
        final qm = q as Map<String, dynamic>;
        final qId = qm['id'] as String;

        await db
            .into(db.questions)
            .insertOnConflictUpdate(
              QuestionsCompanion.insert(
                id: qId,
                targetItemId: Value(qm['targetItemId'] as String?),
                questionType: qm['questionType'] as String,
                prompt: qm['prompt'] as String,
                explanation: Value(qm['explanation'] as String?),
                cefrLevel: Value(qm['cefrLevel'] as String?),
                contentOrigin: qm['contentOrigin'] as String,
                isActive: Value(qm['isActive'] as int? ?? 1),
                createdAtMs: qm['createdAtMs'] as int? ?? now,
              ),
            );

        final options = (qm['options'] as List<dynamic>?) ?? [];
        for (final opt in options) {
          final om = opt as Map<String, dynamic>;
          await db
              .into(db.questionOptions)
              .insertOnConflictUpdate(
                QuestionOptionsCompanion.insert(
                  id: om['id'] as String,
                  questionId: qId,
                  optionText: om['optionText'] as String,
                  sortOrder: om['sortOrder'] as int,
                  isCorrect: om['isCorrect'] as int,
                ),
              );
        }
      }

      // 5. Progress
      final progress = (data['learningProgress'] as List<dynamic>?) ?? [];
      for (final p in progress) {
        final pm = p as Map<String, dynamic>;
        await db
            .into(db.learningProgress)
            .insertOnConflictUpdate(
              LearningProgressCompanion.insert(
                studyItemId: pm['studyItemId'] as String,
                status: pm['status'] as String,
                repetitionCount: Value(pm['repetitionCount'] as int? ?? 0),
                intervalDays: Value(
                  (pm['intervalDays'] as num?)?.toDouble() ?? 0.0,
                ),
                easeFactor: Value(
                  (pm['easeFactor'] as num?)?.toDouble() ?? 2.5,
                ),
                lapses: Value(pm['lapses'] as int? ?? 0),
                dueAtMs: Value(pm['dueAtMs'] as int?),
                lastReviewedAtMs: Value(pm['lastReviewedAtMs'] as int?),
                totalCorrect: Value(pm['totalCorrect'] as int? ?? 0),
                totalIncorrect: Value(pm['totalIncorrect'] as int? ?? 0),
                isFavorite: Value(pm['isFavorite'] as int? ?? 0),
                updatedAtMs: pm['updatedAtMs'] as int? ?? now,
              ),
            );
      }

      // 6. Review events
      final reviews = (data['reviewEvents'] as List<dynamic>?) ?? [];
      for (final r in reviews) {
        final rm = r as Map<String, dynamic>;
        await db
            .into(db.reviewEvents)
            .insertOnConflictUpdate(
              ReviewEventsCompanion.insert(
                id: rm['id'] as String,
                studyItemId: rm['studyItemId'] as String,
                questionId: Value(rm['questionId'] as String?),
                selectedOptionId: Value(rm['selectedOptionId'] as String?),
                isCorrect: Value(rm['isCorrect'] as int?),
                quality: Value(rm['quality'] as int?),
                elapsedMs: Value(rm['elapsedMs'] as int?),
                studyMode: rm['studyMode'] as String,
                answeredAtMs: rm['answeredAtMs'] as int,
              ),
            );
      }
    });
  }
}
