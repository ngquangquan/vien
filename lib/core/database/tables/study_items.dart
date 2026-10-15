import 'package:drift/drift.dart';

class StudyItems extends Table {
  TextColumn get id => text()();
  TextColumn get itemType => text().customConstraint(
    "NOT NULL CHECK (item_type IN ('sense', 'phrase_sense'))",
  )();
  IntColumn get createdAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
