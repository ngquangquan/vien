import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:vien/core/database/app_database.dart';
import 'package:vien/core/database/seed_service.dart';
import 'package:vien/features/vocabulary/data/vocabulary_repository.dart';
import 'package:vien/features/vocabulary/domain/models/vocabulary_models.dart';
import 'package:vien/features/phrases/data/phrases_repository.dart';
import 'package:vien/features/phrases/domain/models/phrase_models.dart';
import 'package:vien/features/tags/data/tags_repository.dart';
import 'package:vien/features/review/data/review_repository.dart';
import 'package:vien/features/quiz/data/quiz_repository.dart';
import 'package:vien/features/settings/data/settings_repository.dart';

void main() {
  late AppDatabase db;
  late VocabularyRepository vocabRepo;
  late PhrasesRepository phrasesRepo;
  late TagsRepository tagsRepo;
  late ReviewRepository reviewRepo;
  late QuizRepository quizRepo;
  late SettingsRepository settingsRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final seedService = SeedService(db);

    final seedFile = File('assets/seed/initial_seed.json');
    final content = await seedFile.readAsString();
    final seedData = json.decode(content) as Map<String, dynamic>;
    await seedService.seedFromJsonMap(seedData);

    vocabRepo = VocabularyRepository(db);
    phrasesRepo = PhrasesRepository(db);
    tagsRepo = TagsRepository(db);
    reviewRepo = ReviewRepository(db);
    quizRepo = QuizRepository(db, reviewRepo);
    settingsRepo = SettingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Phase 2 - Repositories & Core Use Cases', () {
    test(
      'Vocabulary search by normalized spelling and meaning works',
      () async {
        final results1 = await vocabRepo.searchHeadwords(
          const VocabularyFilter(query: 'run'),
        );
        expect(results1.any((h) => h.spelling == 'run'), isTrue);

        final results2 = await vocabRepo.searchHeadwords(
          const VocabularyFilter(query: 'sách'),
        );
        expect(results2.any((h) => h.spelling == 'book'), isTrue);
      },
    );

    test('Vocabulary filter by CEFR level on senses works', () async {
      final c1Results = await vocabRepo.searchHeadwords(
        const VocabularyFilter(cefrLevels: ['C1']),
      );
      expect(c1Results.length, 1);
      expect(c1Results.first.spelling, 'meticulous');
    });

    test('Create new headword with multiple senses preserves distinct POS and CEFR', () async {
      final tag = await tagsRepo.createTag(
        name: 'Công nghệ',
        category: 'topic',
        slug: 'tech',
      );

      final detail = HeadwordDetail(
        headword: Headword(
          id: '',
          spelling: 'code',
          normalizedSpelling: 'code',
          homographNo: 1,
          cefrLevel: 'A2',
          notes: null,
          isArchived: 0,
          createdAtMs: 0,
          updatedAtMs: 0,
        ),
        senses: [
          SenseDetail(
            sense: Sense(
              id: '',
              headwordId: '',
              senseNumber: 1,
              partOfSpeech: 'noun',
              definitionEn:
                  'A set of instructions that a computer can understand.',
              meaningVi: 'Mã nguồn máy tính',
              cefrLevel: 'A2',
              registerLabel: null,
              domainLabel: 'technology',
              grammarNote: 'uncountable',
              usageNote: null,
              isActive: 1,
            ),
            tags: [tag],
            examples: [
              Example(
                id: '',
                studyItemId: '',
                englishText: 'He writes clean code every day.',
                vietnameseText: 'Anh ấy viết mã nguồn sạch mỗi ngày.',
                note: null,
                audioAssetKey: null,
                sortOrder: 1,
                sourceId: null,
              ),
            ],
          ),
          SenseDetail(
            sense: Sense(
              id: '',
              headwordId: '',
              senseNumber: 2,
              partOfSpeech: 'verb',
              definitionEn: 'To write programming instructions for a computer.',
              meaningVi: 'Lập trình, viết code',
              cefrLevel: 'B1',
              registerLabel: null,
              domainLabel: 'technology',
              grammarNote: 'transitive',
              usageNote: null,
              isActive: 1,
            ),
          ),
        ],
      );

      final hwId = await vocabRepo.saveHeadword(detail);
      expect(hwId, isNotEmpty);

      final loaded = await vocabRepo.getHeadwordDetail(hwId);
      expect(loaded, isNotNull);
      expect(loaded!.senses.length, 2);
      expect(loaded.senses[0].sense.partOfSpeech, 'noun');
      expect(loaded.senses[0].sense.cefrLevel, 'A2');
      expect(loaded.senses[0].examples.length, 1);
      expect(loaded.senses[0].tags.length, 1);
      expect(loaded.senses[1].sense.partOfSpeech, 'verb');
      expect(loaded.senses[1].sense.cefrLevel, 'B1');
    });

    test('Phrases repository search and filter works', () async {
      final idioms = await phrasesRepo.searchPhrases(
        const PhraseFilter(phraseTypes: ['idiom']),
      );
      expect(idioms.length, 2);

      final searchResult = await phrasesRepo.searchPhrases(
        const PhraseFilter(query: 'chúc may mắn'),
      );
      expect(searchResult.any((p) => p.phrase == 'break a leg'), isTrue);
    });

    test('Archive headword hides it from regular search', () async {
      await vocabRepo.archiveHeadword('hw-run', true);

      final activeList = await vocabRepo.searchHeadwords(
        const VocabularyFilter(onlyArchived: false),
      );
      expect(activeList.any((h) => h.id == 'hw-run'), isFalse);

      final archivedList = await vocabRepo.searchHeadwords(
        const VocabularyFilter(onlyArchived: true),
      );
      expect(archivedList.any((h) => h.id == 'hw-run'), isTrue);
    });

    test(
      'SM-2 review scheduling correctly updates progress and records events',
      () async {
        const studyItemId = 'sense-run-v1';

        // First successful review (quality 4)
        await reviewRepo.submitReviewResult(
          studyItemId: studyItemId,
          quality: 4,
          studyMode: 'review',
        );

        final p1 = await (db.select(
          db.learningProgress,
        )..where((p) => p.studyItemId.equals(studyItemId))).getSingle();
        expect(p1.repetitionCount, 1);
        expect(p1.intervalDays, 1.0);
        expect(p1.status, 'review');

        // Second successful review (quality 4)
        await reviewRepo.submitReviewResult(
          studyItemId: studyItemId,
          quality: 4,
          studyMode: 'review',
        );

        final p2 = await (db.select(
          db.learningProgress,
        )..where((p) => p.studyItemId.equals(studyItemId))).getSingle();
        expect(p2.repetitionCount, 2);
        expect(p2.intervalDays, 6.0);

        // Failure resets repetition count to 0 and interval to 1 day
        await reviewRepo.submitReviewResult(
          studyItemId: studyItemId,
          quality: 1,
          studyMode: 'review',
        );

        final p3 = await (db.select(
          db.learningProgress,
        )..where((p) => p.studyItemId.equals(studyItemId))).getSingle();
        expect(p3.repetitionCount, 0);
        expect(p3.intervalDays, 1.0);
        expect(p3.lapses, 1);
        expect(p3.status, 'learning');

        // Verify review_events recorded 3 events
        final events = await (db.select(
          db.reviewEvents,
        )..where((e) => e.studyItemId.equals(studyItemId))).get();
        expect(events.length, 3);
      },
    );

    test(
      'Quiz repository validates options and records answer result',
      () async {
        final session = await quizRepo.getQuizSession(limit: 5);
        expect(session, isNotEmpty);

        final q1 = session.firstWhere((q) => q.question.id == 'q-run-v1');
        expect(q1.options.length, 4);

        final correctOpt = q1.correctOption;
        expect(correctOpt, isNotNull);

        // Submit correct answer
        final result = await quizRepo.submitQuizAnswer(
          questionId: q1.question.id,
          selectedOptionId: correctOpt!.id,
          elapsedMs: 2500,
        );

        expect(result.isCorrect, isTrue);

        // Verify learning_progress updated for target item
        final prog = await (db.select(
          db.learningProgress,
        )..where((p) => p.studyItemId.equals('sense-run-v1'))).getSingle();
        expect(prog.totalCorrect, 1);
        expect(prog.totalIncorrect, 0);
      },
    );

    test(
      'Settings repository saves and retrieves UserPreferences correctly',
      () async {
        const prefs = UserPreferences(
          dailyGoal: 20,
          preferredCefr: ['B1', 'B2'],
          darkTheme: true,
        );

        await settingsRepo.savePreferences(prefs);
        final retrieved = await settingsRepo.getPreferences();

        expect(retrieved.dailyGoal, 20);
        expect(retrieved.preferredCefr, ['B1', 'B2']);
        expect(retrieved.darkTheme, isTrue);
      },
    );
  });
}
