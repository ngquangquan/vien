import 'package:drift/drift.dart';

import 'content_sources.dart';
import 'study_items.dart';

@TableIndex(name: 'idx_examples_study_item', columns: {#studyItemId})
class Examples extends Table {
  TextColumn get id => text()();
  TextColumn get studyItemId =>
      text().references(StudyItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get englishText => text()();
  TextColumn get vietnameseText => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get audioAssetKey => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get sourceId => text().nullable().references(
    ContentSources,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column> get primaryKey => {id};
}
