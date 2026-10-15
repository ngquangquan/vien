import 'package:drift/drift.dart';

@TableIndex(name: 'idx_phrases_normalized', columns: {#normalizedPhrase})
class Phrases extends Table {
  TextColumn get id => text()();
  TextColumn get phrase => text()();
  TextColumn get normalizedPhrase => text()();
  TextColumn get phraseType => text().customConstraint(
    "NOT NULL CHECK (phrase_type IN ('idiom', 'collocation', 'phrasal_verb', 'slang', 'expression', 'other'))",
  )();
  TextColumn get cefrLevel => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get isArchived => integer().withDefault(const Constant(0))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
