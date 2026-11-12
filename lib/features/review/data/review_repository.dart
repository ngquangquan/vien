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

  Expression<bool> _isDue(int nowMs) =>
      db.learningProgress.dueAtMs.isNull() |
      db.learningProgress.dueAtMs.isSmallerOrEqualValue(nowMs);

  Stream<int> watchDueCount() {
    final count = db.learningProgress.studyItemId.count();
    final query = db.selectOnly(db.learningProgress)
      ..addColumns([count])
      ..where(_isDue(DateTime.now().millisecondsSinceEpoch));
    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }

  /// Due (or never-reviewed) items of non-archived words and phrases, highest
  /// priority first. A fixed handful of queries regardless of dictionary size.
  Future<List<ReviewItemCandidate>> getDueReviewItems({
    int limit = 20,
    List<String> preferredCefr = const [],
    List<String> preferredTags = const [],
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final lp = db.learningProgress;

    final preferredTagItems = preferredTags.isEmpty
        ? const <String>{}
        : (await (db.select(
            db.itemTags,
          )..where((t) => t.tagId.isIn(preferredTags))).get())
              .map((t) => t.studyItemId)
              .toSet();

    final List<ReviewItemCandidate> candidates = [];

    void add(
      TypedResult row, {
      required String title,
      required String posOrType,
      required String definitionEn,
      String? meaningVi,
      String? cefr,
    }) {
      final prog = row.readTable(lp);
      candidates.add(
        ReviewItemCandidate(
          studyItem: row.readTable(db.studyItems),
          progress: prog,
          title: title,
          posOrType: posOrType,
          definitionEn: definitionEn,
          meaningVi: meaningVi,
          cefrLevel: cefr,
          exampleTexts: [], // filled below, only for the items returned
          priorityScore: Sm2Scheduler.calculatePriorityScore(
            dueAtMs: prog.dueAtMs,
            totalCorrect: prog.totalCorrect,
            totalIncorrect: prog.totalIncorrect,
            lapses: prog.lapses,
            nowMs: now,
            isUserPreference:
                (cefr != null && preferredCefr.contains(cefr)) ||
                preferredTagItems.contains(prog.studyItemId),
          ),
        ),
      );
    }

    final senseRows =
        await (db.select(lp).join([
              innerJoin(db.studyItems, db.studyItems.id.equalsExp(lp.studyItemId)),
              innerJoin(db.senses, db.senses.id.equalsExp(lp.studyItemId)),
              innerJoin(
                db.headwords,
                db.headwords.id.equalsExp(db.senses.headwordId),
              ),
            ])..where(_isDue(now) & db.headwords.isArchived.equals(0)))
            .get();
    for (final row in senseRows) {
      final sense = row.readTable(db.senses);
      final hw = row.readTable(db.headwords);
      add(
        row,
        title: hw.spelling,
        posOrType: sense.partOfSpeech,
        definitionEn: sense.definitionEn,
        meaningVi: sense.meaningVi,
        cefr: sense.cefrLevel ?? hw.cefrLevel,
      );
    }

    final phraseRows =
        await (db.select(lp).join([
              innerJoin(db.studyItems, db.studyItems.id.equalsExp(lp.studyItemId)),
              innerJoin(
                db.phraseSenses,
                db.phraseSenses.id.equalsExp(lp.studyItemId),
              ),
              innerJoin(
                db.phrases,
                db.phrases.id.equalsExp(db.phraseSenses.phraseId),
              ),
            ])..where(_isDue(now) & db.phrases.isArchived.equals(0)))
            .get();
    for (final row in phraseRows) {
      final ps = row.readTable(db.phraseSenses);
      final phrase = row.readTable(db.phrases);
      add(
        row,
        title: phrase.phrase,
        posOrType: phrase.phraseType,
        definitionEn: ps.definitionEn,
        meaningVi: ps.meaningVi,
        cefr: ps.cefrLevel ?? phrase.cefrLevel,
      );
    }

    candidates.sort((a, b) => b.priorityScore.compareTo(a.priorityScore));
    final top = candidates.take(limit).toList();
    if (top.isEmpty) return top;

    final byId = {for (final c in top) c.studyItem.id: c};
    final examples =
        await (db.select(db.examples)
              ..where((e) => e.studyItemId.isIn(byId.keys))
              ..orderBy([(e) => OrderingTerm(expression: e.sortOrder)]))
            .get();
    for (final e in examples) {
      final texts = byId[e.studyItemId]!.exampleTexts;
      if (texts.length < 2) texts.add(e.englishText);
    }
    return top;
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
    final lp = db.learningProgress;
    final count = lp.studyItemId.count();
    final rows =
        await (db.selectOnly(lp)
              ..addColumns([lp.status, count])
              ..groupBy([lp.status]))
            .get();
    final byStatus = {
      for (final r in rows) r.read(lp.status)!: r.read(count) ?? 0,
    };

    return {
      'total': byStatus.values.fold(0, (a, b) => a + b),
      for (final s in const ['new', 'learning', 'review', 'mastered'])
        s: byStatus[s] ?? 0,
    };
  }
}
