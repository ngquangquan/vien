import 'package:drift/drift.dart';

class ContentSources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get licence => text().nullable()();
  TextColumn get url => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SourceAttributions extends Table {
  TextColumn get id => text()();
  TextColumn get sourceId =>
      text().references(ContentSources, #id, onDelete: KeyAction.cascade)();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
