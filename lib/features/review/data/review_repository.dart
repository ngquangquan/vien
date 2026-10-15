import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/sm2_scheduler.dart';

class ReviewItemCandidate {
  final StudyItem studyItem;
  final LearningProgressData progress;
  final String title; // Spelling or phrase
  final String posOrType;
  final String definitionEn;
  final String? meaningVi;
  final String? cefrLevel;
  final List<String> exampleTexts;
  final double priorityScore;

  const ReviewItemCandidate({
    required this.studyItem,
    required this.progress,
    required this.title,
    required this.posOrType,
    required this.definitionEn,
    this.meaningVi,
    this.cefrLevel,
    this.exampleTexts = const [],
    required this.priorityScore,
  });
}

class ReviewRepository {
  final AppDatabase db;
  final _uuid = const Uuid();

  ReviewRepository(this.db);

  Stream<int> watchDueCount() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final query = db.select(db.learningProgress)
      ..where((p) => p.dueAtMs.isNull() | p.dueAtMs.isSmallerOrEqualValue(now));
    return query.watch().map((list) => list.length);
  }

  Future<List<ReviewItemCandidate>> getDueReviewItems({
    int limit = 20,
    List<String> preferredCefr = const [],
    List<String> preferredTags = const [],
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Fetch progress items due or new
    final progressRows =
        await (db.select(db.learningProgress)..where(
              (p) => p.dueAtMs.isNull() | p.dueAtMs.isSmallerOrEqualValue(now),
            ))
            .get();

    final List<ReviewItemCandidate> candidates = [];

    for (final prog in progressRows) {
      final studyItem = await (db.select(
        db.studyItems,
      )..where((s) => s.id.equals(prog.studyItemId))).getSingleOrNull();
      if (studyItem == null) continue;

      String title = '';
      String posOrType = '';
      String defEn = '';
      String? meanVi;
      String? cefr;

      if (studyItem.itemType == 'sense') {
        final sense = await (db.select(
          db.senses,
        )..where((s) => s.id.equals(studyItem.id))).getSingleOrNull();
        if (sense == null) continue;

        final hw = await (db.select(
          db.headwords,
        )..where((h) => h.id.equals(sense.headwordId))).getSingleOrNull();
        if (hw == null || hw.isArchived == 1) {
          continue; // Exclude archived items!
        }

        title = hw.spelling;
        posOrType = sense.partOfSpeech;
        defEn = sense.definitionEn;
        meanVi = sense.meaningVi;
        cefr = sense.cefrLevel ?? hw.cefrLevel;
      } else if (studyItem.itemType == 'phrase_sense') {
        final ps = await (db.select(
          db.phraseSenses,
        )..where((s) => s.id.equals(studyItem.id))).getSingleOrNull();
        if (ps == null) continue;

        final phrase = await (db.select(
          db.phrases,
        )..where((p) => p.id.equals(ps.phraseId))).getSingleOrNull();
        if (phrase == null || phrase.isArchived == 1) {
          continue; // Exclude archived!
        }

        title = phrase.phrase;
        posOrType = phrase.phraseType;
        defEn = ps.definitionEn;
        meanVi = ps.meaningVi;
        cefr = ps.cefrLevel ?? phrase.cefrLevel;
      }

      // Check tags
      final itemTagsRows = await (db.select(
        db.itemTags,
      )..where((it) => it.studyItemId.equals(studyItem.id))).get();
      final tagIds = itemTagsRows.map((it) => it.tagId).toList();

      final isPreferred =
          (cefr != null && preferredCefr.contains(cefr)) ||
          tagIds.any((t) => preferredTags.contains(t));

      final priority = Sm2Scheduler.calculatePriorityScore(
        dueAtMs: prog.dueAtMs,
        totalCorrect: prog.totalCorrect,
        totalIncorrect: prog.totalIncorrect,
        lapses: prog.lapses,
        nowMs: now,
        isUserPreference: isPreferred,
      );

      final examples =
          await (db.select(db.examples)
                ..where((e) => e.studyItemId.equals(studyItem.id))
                ..orderBy([(e) => OrderingTerm(expression: e.sortOrder)])
                ..limit(2))
              .get();

      candidates.add(
        ReviewItemCandidate(
          studyItem: studyItem,
          progress: prog,
          title: title,
          posOrType: posOrType,
          definitionEn: defEn,
          meaningVi: meanVi,
          cefrLevel: cefr,
          exampleTexts: examples.map((e) => e.englishText).toList(),
          priorityScore: priority,
        ),
      );
    }

    // Sort by priority descending
    candidates.sort((a, b) => b.priorityScore.compareTo(a.priorityScore));
    return candidates.take(limit).toList();
  }

  Future<void> submitReviewResult({
    required String studyItemId,
    required int quality, // 0 to 5
    required String studyMode, // review, quiz, notification, self_rating
    int? elapsedMs,
    String? questionId,
    String? selectedOptionId,
    int? isCorrect,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.transaction(() async {
      final currentProg = await (db.select(
        db.learningProgress,
      )..where((p) => p.studyItemId.equals(studyItemId))).getSingleOrNull();

      final schedResult = Sm2Scheduler.calculateNextSchedule(
        quality: quality,
        currentRepetition: currentProg?.repetitionCount ?? 0,
        currentIntervalDays: currentProg?.intervalDays ?? 0.0,
        currentEaseFactor: currentProg?.easeFactor ?? 2.5,
        currentLapses: currentProg?.lapses ?? 0,
        currentTotalCorrect: currentProg?.totalCorrect ?? 0,
        currentTotalIncorrect: currentProg?.totalIncorrect ?? 0,
        nowMs: now,
      );

      await db
          .into(db.learningProgress)
          .insertOnConflictUpdate(
            LearningProgressCompanion.insert(
              studyItemId: studyItemId,
              status: schedResult.status,
              repetitionCount: Value(schedResult.repetitionCount),
              intervalDays: Value(schedResult.intervalDays),
              easeFactor: Value(schedResult.easeFactor),
              lapses: Value(schedResult.lapses),
              dueAtMs: Value(schedResult.dueAtMs),
              lastReviewedAtMs: Value(now),
              totalCorrect: Value(schedResult.totalCorrect),
              totalIncorrect: Value(schedResult.totalIncorrect),
              isFavorite: Value(currentProg?.isFavorite ?? 0),
              updatedAtMs: now,
            ),
          );

      await db
          .into(db.reviewEvents)
          .insert(
            ReviewEventsCompanion.insert(
              id: _uuid.v4(),
              studyItemId: studyItemId,
              questionId: Value(questionId),
              selectedOptionId: Value(selectedOptionId),
              isCorrect: Value(isCorrect ?? (quality >= 3 ? 1 : 0)),
              quality: Value(quality),
              elapsedMs: Value(elapsedMs),
              studyMode: studyMode,
              answeredAtMs: now,
            ),
          );
    });
  }

  Future<Map<String, int>> getLearningStats() async {
    final list = await db.select(db.learningProgress).get();
    int newCount = 0;
    int learningCount = 0;
    int reviewCount = 0;
    int masteredCount = 0;

    for (final item in list) {
      switch (item.status) {
        case 'new':
          newCount++;
          break;
        case 'learning':
          learningCount++;
          break;
        case 'review':
          reviewCount++;
          break;
        case 'mastered':
          masteredCount++;
          break;
      }
    }

    return {
      'total': list.length,
      'new': newCount,
      'learning': learningCount,
      'review': reviewCount,
      'mastered': masteredCount,
    };
  }
}
