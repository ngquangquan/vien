import 'package:drift/drift.dart';

import 'questions.dart';
import 'study_items.dart';

@TableIndex(name: 'idx_progress_due', columns: {#dueAtMs})
class LearningProgress extends Table {
  TextColumn get studyItemId =>
      text().references(StudyItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => text().customConstraint(
    "NOT NULL CHECK (status IN ('new', 'learning', 'review', 'mastered'))",
  )();
  IntColumn get repetitionCount => integer().withDefault(const Constant(0))();
  RealColumn get intervalDays => real().withDefault(const Constant(0.0))();
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  IntColumn get dueAtMs => integer().nullable()();
  IntColumn get lastReviewedAtMs => integer().nullable()();
  IntColumn get totalCorrect => integer().withDefault(const Constant(0))();
  IntColumn get totalIncorrect => integer().withDefault(const Constant(0))();
  IntColumn get isFavorite => integer().withDefault(const Constant(0))();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {studyItemId};
}

@TableIndex(name: 'idx_reviews_item', columns: {#studyItemId})
@TableIndex(name: 'idx_reviews_answered', columns: {#answeredAtMs})
class ReviewEvents extends Table {
  TextColumn get id => text()();
  TextColumn get studyItemId =>
      text().references(StudyItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get questionId => text().nullable().references(
    Questions,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get selectedOptionId => text().nullable().references(
    QuestionOptions,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get isCorrect => integer().nullable().customConstraint(
    "CHECK (is_correct IS NULL OR is_correct IN (0, 1))",
  )();
  IntColumn get quality => integer().nullable()();
  IntColumn get elapsedMs => integer().nullable()();
  TextColumn get studyMode =>
      text()(); // review, quiz, notification, self_rating
  IntColumn get answeredAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
