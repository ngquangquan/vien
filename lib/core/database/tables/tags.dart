import 'package:drift/drift.dart';

import 'study_items.dart';

class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get slug => text().unique()();
  TextColumn get name => text()();
  TextColumn get category => text()(); // topic, register, exam, grammar, custom
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_item_tags_tag', columns: {#tagId})
@TableIndex(name: 'idx_item_tags_item', columns: {#studyItemId})
class ItemTags extends Table {
  TextColumn get studyItemId =>
      text().references(StudyItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {studyItemId, tagId};
}
