import 'package:drift/drift.dart';

import 'headwords.dart';
import 'study_items.dart';

@TableIndex(name: 'idx_senses_headword', columns: {#headwordId})
@TableIndex(name: 'idx_senses_cefr', columns: {#cefrLevel})
@TableIndex(name: 'idx_senses_pos', columns: {#partOfSpeech})
class Senses extends Table {
  TextColumn get id =>
      text().references(StudyItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get headwordId =>
      text().references(Headwords, #id, onDelete: KeyAction.cascade)();
  IntColumn get senseNumber => integer()();
  TextColumn get partOfSpeech => text()();
  TextColumn get definitionEn => text()();
  TextColumn get meaningVi => text().nullable()();
  TextColumn get cefrLevel => text().nullable()();
  TextColumn get registerLabel => text().nullable()();
  TextColumn get domainLabel => text().nullable()();
  TextColumn get grammarNote => text().nullable()();
  TextColumn get usageNote => text().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {headwordId, senseNumber},
  ];
}
