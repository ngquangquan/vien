import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../review/data/review_repository.dart';

class QuizQuestionDetail {
  final Question question;
  final List<QuestionOption> options;
  final String? targetItemTitle;
  final String? targetItemMeaning;

  const QuizQuestionDetail({
    required this.question,
    required this.options,
    this.targetItemTitle,
    this.targetItemMeaning,
  });

  QuestionOption? get correctOption => options
      .cast<QuestionOption?>()
      .firstWhere((o) => o?.isCorrect == 1, orElse: () => null);
}

class QuizAnswerResult {
  final bool isCorrect;
  final String explanation;
  final String correctOptionId;
  final String selectedOptionId;

  const QuizAnswerResult({
    required this.isCorrect,
    required this.explanation,
    required this.correctOptionId,
    required this.selectedOptionId,
  });
}

class QuizRepository {
  final AppDatabase db;
  final ReviewRepository reviewRepo;

  QuizRepository(this.db, this.reviewRepo);

  Future<List<QuizQuestionDetail>> getQuizSession({
    String? cefrLevel,
    int limit = 10,
  }) async {
    final query = db.select(db.questions)..where((q) => q.isActive.equals(1));

    if (cefrLevel != null && cefrLevel.isNotEmpty) {
      query.where((q) => q.cefrLevel.equals(cefrLevel));
    }

    final questions = await query.get();
    final List<QuizQuestionDetail> session = [];

    for (final q in questions) {
      final options =
          await (db.select(db.questionOptions)
                ..where((o) => o.questionId.equals(q.id))
                ..orderBy([(o) => OrderingTerm(expression: o.sortOrder)]))
              .get();

      // Validate exactly one correct option exists
      final correctCount = options.where((o) => o.isCorrect == 1).length;
      if (correctCount != 1 || options.length < 2) {
        continue;
      }

      String? targetTitle;
      String? targetMeaning;

      if (q.targetItemId != null) {
        final sense = await (db.select(
          db.senses,
        )..where((s) => s.id.equals(q.targetItemId!))).getSingleOrNull();
        if (sense != null) {
          final hw = await (db.select(
            db.headwords,
          )..where((h) => h.id.equals(sense.headwordId))).getSingleOrNull();
          targetTitle = hw?.spelling;
          targetMeaning = sense.meaningVi ?? sense.definitionEn;
        } else {
          final ps = await (db.select(
            db.phraseSenses,
          )..where((s) => s.id.equals(q.targetItemId!))).getSingleOrNull();
          if (ps != null) {
            final phr = await (db.select(
              db.phrases,
            )..where((p) => p.id.equals(ps.phraseId))).getSingleOrNull();
            targetTitle = phr?.phrase;
            targetMeaning = ps.meaningVi ?? ps.definitionEn;
          }
        }
      }

      session.add(
        QuizQuestionDetail(
          question: q,
          options: options,
          targetItemTitle: targetTitle,
          targetItemMeaning: targetMeaning,
        ),
      );

      if (session.length >= limit) break;
    }

    return session;
  }

  Future<QuizAnswerResult> submitQuizAnswer({
    required String questionId,
    required String selectedOptionId,
    required int elapsedMs,
  }) async {
    final q = await (db.select(
      db.questions,
    )..where((tbl) => tbl.id.equals(questionId))).getSingle();
    final options = await (db.select(
      db.questionOptions,
    )..where((tbl) => tbl.questionId.equals(questionId))).get();

    final correctOpt = options.firstWhere(
      (o) => o.isCorrect == 1,
      orElse: () =>
          throw StateError('Question $questionId has no correct option!'),
    );

    final isCorrect = (selectedOptionId == correctOpt.id);
    final quality = isCorrect ? 4 : 1;

    if (q.targetItemId != null) {
      await reviewRepo.submitReviewResult(
        studyItemId: q.targetItemId!,
        quality: quality,
        studyMode: 'quiz',
        elapsedMs: elapsedMs,
        questionId: questionId,
        selectedOptionId: selectedOptionId,
        isCorrect: isCorrect ? 1 : 0,
      );
    }

    return QuizAnswerResult(
      isCorrect: isCorrect,
      explanation:
          q.explanation ??
          (isCorrect
              ? 'Chính xác!'
              : 'Đáp án đúng là: ${correctOpt.optionText}'),
      correctOptionId: correctOpt.id,
      selectedOptionId: selectedOptionId,
    );
  }
}
