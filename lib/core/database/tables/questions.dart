import 'package:drift/drift.dart';

import 'study_items.dart';

@TableIndex(name: 'idx_questions_target', columns: {#targetItemId})
class Questions extends Table {
  TextColumn get id => text()();
  TextColumn get targetItemId => text().nullable().references(
    StudyItems,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get questionType => text().customConstraint(
    "NOT NULL CHECK (question_type IN ('meaning_choice', 'definition_choice', 'cloze_choice'))",
  )();
  TextColumn get prompt => text()();
  TextColumn get explanation => text().nullable()();
  TextColumn get cefrLevel => text().nullable()();
  TextColumn get contentOrigin => text().customConstraint(
    "NOT NULL CHECK (content_origin IN ('seed', 'user', 'app_generated'))",
  )();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  IntColumn get createdAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_question_options_q', columns: {#questionId})
class QuestionOptions extends Table {
  TextColumn get id => text()();
  TextColumn get questionId =>
      text().references(Questions, #id, onDelete: KeyAction.cascade)();
  TextColumn get optionText => text()();
  IntColumn get sortOrder => integer()();
  IntColumn get isCorrect =>
      integer().customConstraint("NOT NULL CHECK (is_correct IN (0, 1))")();

  @override
  Set<Column> get primaryKey => {id};
}
