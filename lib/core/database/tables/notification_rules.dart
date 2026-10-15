import 'package:drift/drift.dart';

import 'tags.dart';

class NotificationRules extends Table {
  TextColumn get id => text()();
  TextColumn get ruleType => text().customConstraint(
    "NOT NULL CHECK (rule_type IN ('word', 'phrase', 'due_review', 'quiz'))",
  )();
  IntColumn get enabled => integer().withDefault(const Constant(0))();
  TextColumn get timeOfDay => text()(); // HH:mm
  IntColumn get weekdaysMask => integer().withDefault(const Constant(127))();
  IntColumn get dailyCount => integer().withDefault(const Constant(1))();
  TextColumn get minCefr => text().nullable()();
  TextColumn get maxCefr => text().nullable()();
  TextColumn get tagFilterId =>
      text().nullable().references(Tags, #id, onDelete: KeyAction.setNull)();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
