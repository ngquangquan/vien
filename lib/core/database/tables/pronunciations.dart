import 'package:drift/drift.dart';

import 'headwords.dart';
import 'study_items.dart';

class Pronunciations extends Table {
  TextColumn get id => text()();
  TextColumn get headwordId => text().nullable().references(
    Headwords,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get senseId => text().nullable().references(
    StudyItems,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get accent => text()(); // uk, us, au, other
  TextColumn get ipa => text().nullable()();
  TextColumn get audioAssetKey => text().nullable()();
  TextColumn get sourceNote => text().nullable()();
  TextColumn get licenceNote => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
