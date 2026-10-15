import 'package:drift/drift.dart';

@TableIndex(name: 'idx_headwords_normalized', columns: {#normalizedSpelling})
class Headwords extends Table {
  TextColumn get id => text()();
  TextColumn get spelling => text()();
  TextColumn get normalizedSpelling => text()();
  IntColumn get homographNo => integer().withDefault(const Constant(1))();
  TextColumn get cefrLevel => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get isArchived => integer().withDefault(const Constant(0))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {normalizedSpelling, homographNo},
  ];
}
