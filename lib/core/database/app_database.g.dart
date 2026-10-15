// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HeadwordsTable extends Headwords
    with TableInfo<$HeadwordsTable, Headword> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HeadwordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spellingMeta = const VerificationMeta(
    'spelling',
  );
  @override
  late final GeneratedColumn<String> spelling = GeneratedColumn<String>(
    'spelling',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedSpellingMeta =
      const VerificationMeta('normalizedSpelling');
  @override
  late final GeneratedColumn<String> normalizedSpelling =
      GeneratedColumn<String>(
        'normalized_spelling',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _homographNoMeta = const VerificationMeta(
    'homographNo',
  );
  @override
  late final GeneratedColumn<int> homographNo = GeneratedColumn<int>(
    'homograph_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<int> isArchived = GeneratedColumn<int>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    spelling,
    normalizedSpelling,
    homographNo,
    cefrLevel,
    notes,
    isArchived,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'headwords';
  @override
  VerificationContext validateIntegrity(
    Insertable<Headword> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('spelling')) {
      context.handle(
        _spellingMeta,
        spelling.isAcceptableOrUnknown(data['spelling']!, _spellingMeta),
      );
    } else if (isInserting) {
      context.missing(_spellingMeta);
    }
    if (data.containsKey('normalized_spelling')) {
      context.handle(
        _normalizedSpellingMeta,
        normalizedSpelling.isAcceptableOrUnknown(
          data['normalized_spelling']!,
          _normalizedSpellingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedSpellingMeta);
    }
    if (data.containsKey('homograph_no')) {
      context.handle(
        _homographNoMeta,
        homographNo.isAcceptableOrUnknown(
          data['homograph_no']!,
          _homographNoMeta,
        ),
      );
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {normalizedSpelling, homographNo},
  ];
  @override
  Headword map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Headword(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      spelling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spelling'],
      )!,
      normalizedSpelling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_spelling'],
      )!,
      homographNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}homograph_no'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $HeadwordsTable createAlias(String alias) {
    return $HeadwordsTable(attachedDatabase, alias);
  }
}

class Headword extends DataClass implements Insertable<Headword> {
  final String id;
  final String spelling;
  final String normalizedSpelling;
  final int homographNo;
  final String? cefrLevel;
  final String? notes;
  final int isArchived;
  final int createdAtMs;
  final int updatedAtMs;
  const Headword({
    required this.id,
    required this.spelling,
    required this.normalizedSpelling,
    required this.homographNo,
    this.cefrLevel,
    this.notes,
    required this.isArchived,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['spelling'] = Variable<String>(spelling);
    map['normalized_spelling'] = Variable<String>(normalizedSpelling);
    map['homograph_no'] = Variable<int>(homographNo);
    if (!nullToAbsent || cefrLevel != null) {
      map['cefr_level'] = Variable<String>(cefrLevel);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<int>(isArchived);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  HeadwordsCompanion toCompanion(bool nullToAbsent) {
    return HeadwordsCompanion(
      id: Value(id),
      spelling: Value(spelling),
      normalizedSpelling: Value(normalizedSpelling),
      homographNo: Value(homographNo),
      cefrLevel: cefrLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(cefrLevel),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory Headword.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Headword(
      id: serializer.fromJson<String>(json['id']),
      spelling: serializer.fromJson<String>(json['spelling']),
      normalizedSpelling: serializer.fromJson<String>(
        json['normalizedSpelling'],
      ),
      homographNo: serializer.fromJson<int>(json['homographNo']),
      cefrLevel: serializer.fromJson<String?>(json['cefrLevel']),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<int>(json['isArchived']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'spelling': serializer.toJson<String>(spelling),
      'normalizedSpelling': serializer.toJson<String>(normalizedSpelling),
      'homographNo': serializer.toJson<int>(homographNo),
      'cefrLevel': serializer.toJson<String?>(cefrLevel),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<int>(isArchived),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  Headword copyWith({
    String? id,
    String? spelling,
    String? normalizedSpelling,
    int? homographNo,
    Value<String?> cefrLevel = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? isArchived,
    int? createdAtMs,
    int? updatedAtMs,
  }) => Headword(
    id: id ?? this.id,
    spelling: spelling ?? this.spelling,
    normalizedSpelling: normalizedSpelling ?? this.normalizedSpelling,
    homographNo: homographNo ?? this.homographNo,
    cefrLevel: cefrLevel.present ? cefrLevel.value : this.cefrLevel,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  Headword copyWithCompanion(HeadwordsCompanion data) {
    return Headword(
      id: data.id.present ? data.id.value : this.id,
      spelling: data.spelling.present ? data.spelling.value : this.spelling,
      normalizedSpelling: data.normalizedSpelling.present
          ? data.normalizedSpelling.value
          : this.normalizedSpelling,
      homographNo: data.homographNo.present
          ? data.homographNo.value
          : this.homographNo,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Headword(')
          ..write('id: $id, ')
          ..write('spelling: $spelling, ')
          ..write('normalizedSpelling: $normalizedSpelling, ')
          ..write('homographNo: $homographNo, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    spelling,
    normalizedSpelling,
    homographNo,
    cefrLevel,
    notes,
    isArchived,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Headword &&
          other.id == this.id &&
          other.spelling == this.spelling &&
          other.normalizedSpelling == this.normalizedSpelling &&
          other.homographNo == this.homographNo &&
          other.cefrLevel == this.cefrLevel &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class HeadwordsCompanion extends UpdateCompanion<Headword> {
  final Value<String> id;
  final Value<String> spelling;
  final Value<String> normalizedSpelling;
  final Value<int> homographNo;
  final Value<String?> cefrLevel;
  final Value<String?> notes;
  final Value<int> isArchived;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const HeadwordsCompanion({
    this.id = const Value.absent(),
    this.spelling = const Value.absent(),
    this.normalizedSpelling = const Value.absent(),
    this.homographNo = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HeadwordsCompanion.insert({
    required String id,
    required String spelling,
    required String normalizedSpelling,
    this.homographNo = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       spelling = Value(spelling),
       normalizedSpelling = Value(normalizedSpelling),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<Headword> custom({
    Expression<String>? id,
    Expression<String>? spelling,
    Expression<String>? normalizedSpelling,
    Expression<int>? homographNo,
    Expression<String>? cefrLevel,
    Expression<String>? notes,
    Expression<int>? isArchived,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (spelling != null) 'spelling': spelling,
      if (normalizedSpelling != null) 'normalized_spelling': normalizedSpelling,
      if (homographNo != null) 'homograph_no': homographNo,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HeadwordsCompanion copyWith({
    Value<String>? id,
    Value<String>? spelling,
    Value<String>? normalizedSpelling,
    Value<int>? homographNo,
    Value<String?>? cefrLevel,
    Value<String?>? notes,
    Value<int>? isArchived,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return HeadwordsCompanion(
      id: id ?? this.id,
      spelling: spelling ?? this.spelling,
      normalizedSpelling: normalizedSpelling ?? this.normalizedSpelling,
      homographNo: homographNo ?? this.homographNo,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (spelling.present) {
      map['spelling'] = Variable<String>(spelling.value);
    }
    if (normalizedSpelling.present) {
      map['normalized_spelling'] = Variable<String>(normalizedSpelling.value);
    }
    if (homographNo.present) {
      map['homograph_no'] = Variable<int>(homographNo.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<int>(isArchived.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HeadwordsCompanion(')
          ..write('id: $id, ')
          ..write('spelling: $spelling, ')
          ..write('normalizedSpelling: $normalizedSpelling, ')
          ..write('homographNo: $homographNo, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyItemsTable extends StudyItems
    with TableInfo<$StudyItemsTable, StudyItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (item_type IN (\'sense\', \'phrase_sense\'))',
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, itemType, createdAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
    );
  }

  @override
  $StudyItemsTable createAlias(String alias) {
    return $StudyItemsTable(attachedDatabase, alias);
  }
}

class StudyItem extends DataClass implements Insertable<StudyItem> {
  final String id;
  final String itemType;
  final int createdAtMs;
  const StudyItem({
    required this.id,
    required this.itemType,
    required this.createdAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_type'] = Variable<String>(itemType);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    return map;
  }

  StudyItemsCompanion toCompanion(bool nullToAbsent) {
    return StudyItemsCompanion(
      id: Value(id),
      itemType: Value(itemType),
      createdAtMs: Value(createdAtMs),
    );
  }

  factory StudyItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyItem(
      id: serializer.fromJson<String>(json['id']),
      itemType: serializer.fromJson<String>(json['itemType']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemType': serializer.toJson<String>(itemType),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
    };
  }

  StudyItem copyWith({String? id, String? itemType, int? createdAtMs}) =>
      StudyItem(
        id: id ?? this.id,
        itemType: itemType ?? this.itemType,
        createdAtMs: createdAtMs ?? this.createdAtMs,
      );
  StudyItem copyWithCompanion(StudyItemsCompanion data) {
    return StudyItem(
      id: data.id.present ? data.id.value : this.id,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyItem(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemType, createdAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyItem &&
          other.id == this.id &&
          other.itemType == this.itemType &&
          other.createdAtMs == this.createdAtMs);
}

class StudyItemsCompanion extends UpdateCompanion<StudyItem> {
  final Value<String> id;
  final Value<String> itemType;
  final Value<int> createdAtMs;
  final Value<int> rowid;
  const StudyItemsCompanion({
    this.id = const Value.absent(),
    this.itemType = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyItemsCompanion.insert({
    required String id,
    required String itemType,
    required int createdAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemType = Value(itemType),
       createdAtMs = Value(createdAtMs);
  static Insertable<StudyItem> custom({
    Expression<String>? id,
    Expression<String>? itemType,
    Expression<int>? createdAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemType != null) 'item_type': itemType,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemType,
    Value<int>? createdAtMs,
    Value<int>? rowid,
  }) {
    return StudyItemsCompanion(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SensesTable extends Senses with TableInfo<$SensesTable, Sense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _headwordIdMeta = const VerificationMeta(
    'headwordId',
  );
  @override
  late final GeneratedColumn<String> headwordId = GeneratedColumn<String>(
    'headword_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES headwords (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _senseNumberMeta = const VerificationMeta(
    'senseNumber',
  );
  @override
  late final GeneratedColumn<int> senseNumber = GeneratedColumn<int>(
    'sense_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionEnMeta = const VerificationMeta(
    'definitionEn',
  );
  @override
  late final GeneratedColumn<String> definitionEn = GeneratedColumn<String>(
    'definition_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningViMeta = const VerificationMeta(
    'meaningVi',
  );
  @override
  late final GeneratedColumn<String> meaningVi = GeneratedColumn<String>(
    'meaning_vi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _registerLabelMeta = const VerificationMeta(
    'registerLabel',
  );
  @override
  late final GeneratedColumn<String> registerLabel = GeneratedColumn<String>(
    'register_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _domainLabelMeta = const VerificationMeta(
    'domainLabel',
  );
  @override
  late final GeneratedColumn<String> domainLabel = GeneratedColumn<String>(
    'domain_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grammarNoteMeta = const VerificationMeta(
    'grammarNote',
  );
  @override
  late final GeneratedColumn<String> grammarNote = GeneratedColumn<String>(
    'grammar_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageNoteMeta = const VerificationMeta(
    'usageNote',
  );
  @override
  late final GeneratedColumn<String> usageNote = GeneratedColumn<String>(
    'usage_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    headwordId,
    senseNumber,
    partOfSpeech,
    definitionEn,
    meaningVi,
    cefrLevel,
    registerLabel,
    domainLabel,
    grammarNote,
    usageNote,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'senses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('headword_id')) {
      context.handle(
        _headwordIdMeta,
        headwordId.isAcceptableOrUnknown(data['headword_id']!, _headwordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_headwordIdMeta);
    }
    if (data.containsKey('sense_number')) {
      context.handle(
        _senseNumberMeta,
        senseNumber.isAcceptableOrUnknown(
          data['sense_number']!,
          _senseNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_senseNumberMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('definition_en')) {
      context.handle(
        _definitionEnMeta,
        definitionEn.isAcceptableOrUnknown(
          data['definition_en']!,
          _definitionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_definitionEnMeta);
    }
    if (data.containsKey('meaning_vi')) {
      context.handle(
        _meaningViMeta,
        meaningVi.isAcceptableOrUnknown(data['meaning_vi']!, _meaningViMeta),
      );
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    }
    if (data.containsKey('register_label')) {
      context.handle(
        _registerLabelMeta,
        registerLabel.isAcceptableOrUnknown(
          data['register_label']!,
          _registerLabelMeta,
        ),
      );
    }
    if (data.containsKey('domain_label')) {
      context.handle(
        _domainLabelMeta,
        domainLabel.isAcceptableOrUnknown(
          data['domain_label']!,
          _domainLabelMeta,
        ),
      );
    }
    if (data.containsKey('grammar_note')) {
      context.handle(
        _grammarNoteMeta,
        grammarNote.isAcceptableOrUnknown(
          data['grammar_note']!,
          _grammarNoteMeta,
        ),
      );
    }
    if (data.containsKey('usage_note')) {
      context.handle(
        _usageNoteMeta,
        usageNote.isAcceptableOrUnknown(data['usage_note']!, _usageNoteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {headwordId, senseNumber},
  ];
  @override
  Sense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      headwordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}headword_id'],
      )!,
      senseNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sense_number'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      )!,
      definitionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition_en'],
      )!,
      meaningVi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning_vi'],
      ),
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      ),
      registerLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}register_label'],
      ),
      domainLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}domain_label'],
      ),
      grammarNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_note'],
      ),
      usageNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $SensesTable createAlias(String alias) {
    return $SensesTable(attachedDatabase, alias);
  }
}

class Sense extends DataClass implements Insertable<Sense> {
  final String id;
  final String headwordId;
  final int senseNumber;
  final String partOfSpeech;
  final String definitionEn;
  final String? meaningVi;
  final String? cefrLevel;
  final String? registerLabel;
  final String? domainLabel;
  final String? grammarNote;
  final String? usageNote;
  final int isActive;
  const Sense({
    required this.id,
    required this.headwordId,
    required this.senseNumber,
    required this.partOfSpeech,
    required this.definitionEn,
    this.meaningVi,
    this.cefrLevel,
    this.registerLabel,
    this.domainLabel,
    this.grammarNote,
    this.usageNote,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['headword_id'] = Variable<String>(headwordId);
    map['sense_number'] = Variable<int>(senseNumber);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    map['definition_en'] = Variable<String>(definitionEn);
    if (!nullToAbsent || meaningVi != null) {
      map['meaning_vi'] = Variable<String>(meaningVi);
    }
    if (!nullToAbsent || cefrLevel != null) {
      map['cefr_level'] = Variable<String>(cefrLevel);
    }
    if (!nullToAbsent || registerLabel != null) {
      map['register_label'] = Variable<String>(registerLabel);
    }
    if (!nullToAbsent || domainLabel != null) {
      map['domain_label'] = Variable<String>(domainLabel);
    }
    if (!nullToAbsent || grammarNote != null) {
      map['grammar_note'] = Variable<String>(grammarNote);
    }
    if (!nullToAbsent || usageNote != null) {
      map['usage_note'] = Variable<String>(usageNote);
    }
    map['is_active'] = Variable<int>(isActive);
    return map;
  }

  SensesCompanion toCompanion(bool nullToAbsent) {
    return SensesCompanion(
      id: Value(id),
      headwordId: Value(headwordId),
      senseNumber: Value(senseNumber),
      partOfSpeech: Value(partOfSpeech),
      definitionEn: Value(definitionEn),
      meaningVi: meaningVi == null && nullToAbsent
          ? const Value.absent()
          : Value(meaningVi),
      cefrLevel: cefrLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(cefrLevel),
      registerLabel: registerLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(registerLabel),
      domainLabel: domainLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(domainLabel),
      grammarNote: grammarNote == null && nullToAbsent
          ? const Value.absent()
          : Value(grammarNote),
      usageNote: usageNote == null && nullToAbsent
          ? const Value.absent()
          : Value(usageNote),
      isActive: Value(isActive),
    );
  }

  factory Sense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sense(
      id: serializer.fromJson<String>(json['id']),
      headwordId: serializer.fromJson<String>(json['headwordId']),
      senseNumber: serializer.fromJson<int>(json['senseNumber']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      definitionEn: serializer.fromJson<String>(json['definitionEn']),
      meaningVi: serializer.fromJson<String?>(json['meaningVi']),
      cefrLevel: serializer.fromJson<String?>(json['cefrLevel']),
      registerLabel: serializer.fromJson<String?>(json['registerLabel']),
      domainLabel: serializer.fromJson<String?>(json['domainLabel']),
      grammarNote: serializer.fromJson<String?>(json['grammarNote']),
      usageNote: serializer.fromJson<String?>(json['usageNote']),
      isActive: serializer.fromJson<int>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'headwordId': serializer.toJson<String>(headwordId),
      'senseNumber': serializer.toJson<int>(senseNumber),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'definitionEn': serializer.toJson<String>(definitionEn),
      'meaningVi': serializer.toJson<String?>(meaningVi),
      'cefrLevel': serializer.toJson<String?>(cefrLevel),
      'registerLabel': serializer.toJson<String?>(registerLabel),
      'domainLabel': serializer.toJson<String?>(domainLabel),
      'grammarNote': serializer.toJson<String?>(grammarNote),
      'usageNote': serializer.toJson<String?>(usageNote),
      'isActive': serializer.toJson<int>(isActive),
    };
  }

  Sense copyWith({
    String? id,
    String? headwordId,
    int? senseNumber,
    String? partOfSpeech,
    String? definitionEn,
    Value<String?> meaningVi = const Value.absent(),
    Value<String?> cefrLevel = const Value.absent(),
    Value<String?> registerLabel = const Value.absent(),
    Value<String?> domainLabel = const Value.absent(),
    Value<String?> grammarNote = const Value.absent(),
    Value<String?> usageNote = const Value.absent(),
    int? isActive,
  }) => Sense(
    id: id ?? this.id,
    headwordId: headwordId ?? this.headwordId,
    senseNumber: senseNumber ?? this.senseNumber,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    definitionEn: definitionEn ?? this.definitionEn,
    meaningVi: meaningVi.present ? meaningVi.value : this.meaningVi,
    cefrLevel: cefrLevel.present ? cefrLevel.value : this.cefrLevel,
    registerLabel: registerLabel.present
        ? registerLabel.value
        : this.registerLabel,
    domainLabel: domainLabel.present ? domainLabel.value : this.domainLabel,
    grammarNote: grammarNote.present ? grammarNote.value : this.grammarNote,
    usageNote: usageNote.present ? usageNote.value : this.usageNote,
    isActive: isActive ?? this.isActive,
  );
  Sense copyWithCompanion(SensesCompanion data) {
    return Sense(
      id: data.id.present ? data.id.value : this.id,
      headwordId: data.headwordId.present
          ? data.headwordId.value
          : this.headwordId,
      senseNumber: data.senseNumber.present
          ? data.senseNumber.value
          : this.senseNumber,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      definitionEn: data.definitionEn.present
          ? data.definitionEn.value
          : this.definitionEn,
      meaningVi: data.meaningVi.present ? data.meaningVi.value : this.meaningVi,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      registerLabel: data.registerLabel.present
          ? data.registerLabel.value
          : this.registerLabel,
      domainLabel: data.domainLabel.present
          ? data.domainLabel.value
          : this.domainLabel,
      grammarNote: data.grammarNote.present
          ? data.grammarNote.value
          : this.grammarNote,
      usageNote: data.usageNote.present ? data.usageNote.value : this.usageNote,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sense(')
          ..write('id: $id, ')
          ..write('headwordId: $headwordId, ')
          ..write('senseNumber: $senseNumber, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definitionEn: $definitionEn, ')
          ..write('meaningVi: $meaningVi, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('registerLabel: $registerLabel, ')
          ..write('domainLabel: $domainLabel, ')
          ..write('grammarNote: $grammarNote, ')
          ..write('usageNote: $usageNote, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    headwordId,
    senseNumber,
    partOfSpeech,
    definitionEn,
    meaningVi,
    cefrLevel,
    registerLabel,
    domainLabel,
    grammarNote,
    usageNote,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sense &&
          other.id == this.id &&
          other.headwordId == this.headwordId &&
          other.senseNumber == this.senseNumber &&
          other.partOfSpeech == this.partOfSpeech &&
          other.definitionEn == this.definitionEn &&
          other.meaningVi == this.meaningVi &&
          other.cefrLevel == this.cefrLevel &&
          other.registerLabel == this.registerLabel &&
          other.domainLabel == this.domainLabel &&
          other.grammarNote == this.grammarNote &&
          other.usageNote == this.usageNote &&
          other.isActive == this.isActive);
}

class SensesCompanion extends UpdateCompanion<Sense> {
  final Value<String> id;
  final Value<String> headwordId;
  final Value<int> senseNumber;
  final Value<String> partOfSpeech;
  final Value<String> definitionEn;
  final Value<String?> meaningVi;
  final Value<String?> cefrLevel;
  final Value<String?> registerLabel;
  final Value<String?> domainLabel;
  final Value<String?> grammarNote;
  final Value<String?> usageNote;
  final Value<int> isActive;
  final Value<int> rowid;
  const SensesCompanion({
    this.id = const Value.absent(),
    this.headwordId = const Value.absent(),
    this.senseNumber = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.definitionEn = const Value.absent(),
    this.meaningVi = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.registerLabel = const Value.absent(),
    this.domainLabel = const Value.absent(),
    this.grammarNote = const Value.absent(),
    this.usageNote = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SensesCompanion.insert({
    required String id,
    required String headwordId,
    required int senseNumber,
    required String partOfSpeech,
    required String definitionEn,
    this.meaningVi = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.registerLabel = const Value.absent(),
    this.domainLabel = const Value.absent(),
    this.grammarNote = const Value.absent(),
    this.usageNote = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       headwordId = Value(headwordId),
       senseNumber = Value(senseNumber),
       partOfSpeech = Value(partOfSpeech),
       definitionEn = Value(definitionEn);
  static Insertable<Sense> custom({
    Expression<String>? id,
    Expression<String>? headwordId,
    Expression<int>? senseNumber,
    Expression<String>? partOfSpeech,
    Expression<String>? definitionEn,
    Expression<String>? meaningVi,
    Expression<String>? cefrLevel,
    Expression<String>? registerLabel,
    Expression<String>? domainLabel,
    Expression<String>? grammarNote,
    Expression<String>? usageNote,
    Expression<int>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (headwordId != null) 'headword_id': headwordId,
      if (senseNumber != null) 'sense_number': senseNumber,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (definitionEn != null) 'definition_en': definitionEn,
      if (meaningVi != null) 'meaning_vi': meaningVi,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (registerLabel != null) 'register_label': registerLabel,
      if (domainLabel != null) 'domain_label': domainLabel,
      if (grammarNote != null) 'grammar_note': grammarNote,
      if (usageNote != null) 'usage_note': usageNote,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SensesCompanion copyWith({
    Value<String>? id,
    Value<String>? headwordId,
    Value<int>? senseNumber,
    Value<String>? partOfSpeech,
    Value<String>? definitionEn,
    Value<String?>? meaningVi,
    Value<String?>? cefrLevel,
    Value<String?>? registerLabel,
    Value<String?>? domainLabel,
    Value<String?>? grammarNote,
    Value<String?>? usageNote,
    Value<int>? isActive,
    Value<int>? rowid,
  }) {
    return SensesCompanion(
      id: id ?? this.id,
      headwordId: headwordId ?? this.headwordId,
      senseNumber: senseNumber ?? this.senseNumber,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitionEn: definitionEn ?? this.definitionEn,
      meaningVi: meaningVi ?? this.meaningVi,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      registerLabel: registerLabel ?? this.registerLabel,
      domainLabel: domainLabel ?? this.domainLabel,
      grammarNote: grammarNote ?? this.grammarNote,
      usageNote: usageNote ?? this.usageNote,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (headwordId.present) {
      map['headword_id'] = Variable<String>(headwordId.value);
    }
    if (senseNumber.present) {
      map['sense_number'] = Variable<int>(senseNumber.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (definitionEn.present) {
      map['definition_en'] = Variable<String>(definitionEn.value);
    }
    if (meaningVi.present) {
      map['meaning_vi'] = Variable<String>(meaningVi.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (registerLabel.present) {
      map['register_label'] = Variable<String>(registerLabel.value);
    }
    if (domainLabel.present) {
      map['domain_label'] = Variable<String>(domainLabel.value);
    }
    if (grammarNote.present) {
      map['grammar_note'] = Variable<String>(grammarNote.value);
    }
    if (usageNote.present) {
      map['usage_note'] = Variable<String>(usageNote.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SensesCompanion(')
          ..write('id: $id, ')
          ..write('headwordId: $headwordId, ')
          ..write('senseNumber: $senseNumber, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definitionEn: $definitionEn, ')
          ..write('meaningVi: $meaningVi, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('registerLabel: $registerLabel, ')
          ..write('domainLabel: $domainLabel, ')
          ..write('grammarNote: $grammarNote, ')
          ..write('usageNote: $usageNote, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhrasesTable extends Phrases with TableInfo<$PhrasesTable, Phrase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhrasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phraseMeta = const VerificationMeta('phrase');
  @override
  late final GeneratedColumn<String> phrase = GeneratedColumn<String>(
    'phrase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedPhraseMeta = const VerificationMeta(
    'normalizedPhrase',
  );
  @override
  late final GeneratedColumn<String> normalizedPhrase = GeneratedColumn<String>(
    'normalized_phrase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phraseTypeMeta = const VerificationMeta(
    'phraseType',
  );
  @override
  late final GeneratedColumn<String> phraseType = GeneratedColumn<String>(
    'phrase_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (phrase_type IN (\'idiom\', \'collocation\', \'phrasal_verb\', \'slang\', \'expression\', \'other\'))',
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<int> isArchived = GeneratedColumn<int>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phrase,
    normalizedPhrase,
    phraseType,
    cefrLevel,
    notes,
    isArchived,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phrases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Phrase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phrase')) {
      context.handle(
        _phraseMeta,
        phrase.isAcceptableOrUnknown(data['phrase']!, _phraseMeta),
      );
    } else if (isInserting) {
      context.missing(_phraseMeta);
    }
    if (data.containsKey('normalized_phrase')) {
      context.handle(
        _normalizedPhraseMeta,
        normalizedPhrase.isAcceptableOrUnknown(
          data['normalized_phrase']!,
          _normalizedPhraseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedPhraseMeta);
    }
    if (data.containsKey('phrase_type')) {
      context.handle(
        _phraseTypeMeta,
        phraseType.isAcceptableOrUnknown(data['phrase_type']!, _phraseTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_phraseTypeMeta);
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Phrase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Phrase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phrase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phrase'],
      )!,
      normalizedPhrase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_phrase'],
      )!,
      phraseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phrase_type'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $PhrasesTable createAlias(String alias) {
    return $PhrasesTable(attachedDatabase, alias);
  }
}

class Phrase extends DataClass implements Insertable<Phrase> {
  final String id;
  final String phrase;
  final String normalizedPhrase;
  final String phraseType;
  final String? cefrLevel;
  final String? notes;
  final int isArchived;
  final int createdAtMs;
  final int updatedAtMs;
  const Phrase({
    required this.id,
    required this.phrase,
    required this.normalizedPhrase,
    required this.phraseType,
    this.cefrLevel,
    this.notes,
    required this.isArchived,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phrase'] = Variable<String>(phrase);
    map['normalized_phrase'] = Variable<String>(normalizedPhrase);
    map['phrase_type'] = Variable<String>(phraseType);
    if (!nullToAbsent || cefrLevel != null) {
      map['cefr_level'] = Variable<String>(cefrLevel);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<int>(isArchived);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  PhrasesCompanion toCompanion(bool nullToAbsent) {
    return PhrasesCompanion(
      id: Value(id),
      phrase: Value(phrase),
      normalizedPhrase: Value(normalizedPhrase),
      phraseType: Value(phraseType),
      cefrLevel: cefrLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(cefrLevel),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory Phrase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Phrase(
      id: serializer.fromJson<String>(json['id']),
      phrase: serializer.fromJson<String>(json['phrase']),
      normalizedPhrase: serializer.fromJson<String>(json['normalizedPhrase']),
      phraseType: serializer.fromJson<String>(json['phraseType']),
      cefrLevel: serializer.fromJson<String?>(json['cefrLevel']),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<int>(json['isArchived']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phrase': serializer.toJson<String>(phrase),
      'normalizedPhrase': serializer.toJson<String>(normalizedPhrase),
      'phraseType': serializer.toJson<String>(phraseType),
      'cefrLevel': serializer.toJson<String?>(cefrLevel),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<int>(isArchived),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  Phrase copyWith({
    String? id,
    String? phrase,
    String? normalizedPhrase,
    String? phraseType,
    Value<String?> cefrLevel = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? isArchived,
    int? createdAtMs,
    int? updatedAtMs,
  }) => Phrase(
    id: id ?? this.id,
    phrase: phrase ?? this.phrase,
    normalizedPhrase: normalizedPhrase ?? this.normalizedPhrase,
    phraseType: phraseType ?? this.phraseType,
    cefrLevel: cefrLevel.present ? cefrLevel.value : this.cefrLevel,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  Phrase copyWithCompanion(PhrasesCompanion data) {
    return Phrase(
      id: data.id.present ? data.id.value : this.id,
      phrase: data.phrase.present ? data.phrase.value : this.phrase,
      normalizedPhrase: data.normalizedPhrase.present
          ? data.normalizedPhrase.value
          : this.normalizedPhrase,
      phraseType: data.phraseType.present
          ? data.phraseType.value
          : this.phraseType,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Phrase(')
          ..write('id: $id, ')
          ..write('phrase: $phrase, ')
          ..write('normalizedPhrase: $normalizedPhrase, ')
          ..write('phraseType: $phraseType, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phrase,
    normalizedPhrase,
    phraseType,
    cefrLevel,
    notes,
    isArchived,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phrase &&
          other.id == this.id &&
          other.phrase == this.phrase &&
          other.normalizedPhrase == this.normalizedPhrase &&
          other.phraseType == this.phraseType &&
          other.cefrLevel == this.cefrLevel &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class PhrasesCompanion extends UpdateCompanion<Phrase> {
  final Value<String> id;
  final Value<String> phrase;
  final Value<String> normalizedPhrase;
  final Value<String> phraseType;
  final Value<String?> cefrLevel;
  final Value<String?> notes;
  final Value<int> isArchived;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const PhrasesCompanion({
    this.id = const Value.absent(),
    this.phrase = const Value.absent(),
    this.normalizedPhrase = const Value.absent(),
    this.phraseType = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhrasesCompanion.insert({
    required String id,
    required String phrase,
    required String normalizedPhrase,
    required String phraseType,
    this.cefrLevel = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phrase = Value(phrase),
       normalizedPhrase = Value(normalizedPhrase),
       phraseType = Value(phraseType),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<Phrase> custom({
    Expression<String>? id,
    Expression<String>? phrase,
    Expression<String>? normalizedPhrase,
    Expression<String>? phraseType,
    Expression<String>? cefrLevel,
    Expression<String>? notes,
    Expression<int>? isArchived,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phrase != null) 'phrase': phrase,
      if (normalizedPhrase != null) 'normalized_phrase': normalizedPhrase,
      if (phraseType != null) 'phrase_type': phraseType,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhrasesCompanion copyWith({
    Value<String>? id,
    Value<String>? phrase,
    Value<String>? normalizedPhrase,
    Value<String>? phraseType,
    Value<String?>? cefrLevel,
    Value<String?>? notes,
    Value<int>? isArchived,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return PhrasesCompanion(
      id: id ?? this.id,
      phrase: phrase ?? this.phrase,
      normalizedPhrase: normalizedPhrase ?? this.normalizedPhrase,
      phraseType: phraseType ?? this.phraseType,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phrase.present) {
      map['phrase'] = Variable<String>(phrase.value);
    }
    if (normalizedPhrase.present) {
      map['normalized_phrase'] = Variable<String>(normalizedPhrase.value);
    }
    if (phraseType.present) {
      map['phrase_type'] = Variable<String>(phraseType.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<int>(isArchived.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesCompanion(')
          ..write('id: $id, ')
          ..write('phrase: $phrase, ')
          ..write('normalizedPhrase: $normalizedPhrase, ')
          ..write('phraseType: $phraseType, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhraseSensesTable extends PhraseSenses
    with TableInfo<$PhraseSensesTable, PhraseSense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhraseSensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _phraseIdMeta = const VerificationMeta(
    'phraseId',
  );
  @override
  late final GeneratedColumn<String> phraseId = GeneratedColumn<String>(
    'phrase_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES phrases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _senseNumberMeta = const VerificationMeta(
    'senseNumber',
  );
  @override
  late final GeneratedColumn<int> senseNumber = GeneratedColumn<int>(
    'sense_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _definitionEnMeta = const VerificationMeta(
    'definitionEn',
  );
  @override
  late final GeneratedColumn<String> definitionEn = GeneratedColumn<String>(
    'definition_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningViMeta = const VerificationMeta(
    'meaningVi',
  );
  @override
  late final GeneratedColumn<String> meaningVi = GeneratedColumn<String>(
    'meaning_vi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _registerLabelMeta = const VerificationMeta(
    'registerLabel',
  );
  @override
  late final GeneratedColumn<String> registerLabel = GeneratedColumn<String>(
    'register_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _domainLabelMeta = const VerificationMeta(
    'domainLabel',
  );
  @override
  late final GeneratedColumn<String> domainLabel = GeneratedColumn<String>(
    'domain_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grammarNoteMeta = const VerificationMeta(
    'grammarNote',
  );
  @override
  late final GeneratedColumn<String> grammarNote = GeneratedColumn<String>(
    'grammar_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageNoteMeta = const VerificationMeta(
    'usageNote',
  );
  @override
  late final GeneratedColumn<String> usageNote = GeneratedColumn<String>(
    'usage_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phraseId,
    senseNumber,
    partOfSpeech,
    definitionEn,
    meaningVi,
    cefrLevel,
    registerLabel,
    domainLabel,
    grammarNote,
    usageNote,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phrase_senses';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhraseSense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phrase_id')) {
      context.handle(
        _phraseIdMeta,
        phraseId.isAcceptableOrUnknown(data['phrase_id']!, _phraseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_phraseIdMeta);
    }
    if (data.containsKey('sense_number')) {
      context.handle(
        _senseNumberMeta,
        senseNumber.isAcceptableOrUnknown(
          data['sense_number']!,
          _senseNumberMeta,
        ),
      );
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('definition_en')) {
      context.handle(
        _definitionEnMeta,
        definitionEn.isAcceptableOrUnknown(
          data['definition_en']!,
          _definitionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_definitionEnMeta);
    }
    if (data.containsKey('meaning_vi')) {
      context.handle(
        _meaningViMeta,
        meaningVi.isAcceptableOrUnknown(data['meaning_vi']!, _meaningViMeta),
      );
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    }
    if (data.containsKey('register_label')) {
      context.handle(
        _registerLabelMeta,
        registerLabel.isAcceptableOrUnknown(
          data['register_label']!,
          _registerLabelMeta,
        ),
      );
    }
    if (data.containsKey('domain_label')) {
      context.handle(
        _domainLabelMeta,
        domainLabel.isAcceptableOrUnknown(
          data['domain_label']!,
          _domainLabelMeta,
        ),
      );
    }
    if (data.containsKey('grammar_note')) {
      context.handle(
        _grammarNoteMeta,
        grammarNote.isAcceptableOrUnknown(
          data['grammar_note']!,
          _grammarNoteMeta,
        ),
      );
    }
    if (data.containsKey('usage_note')) {
      context.handle(
        _usageNoteMeta,
        usageNote.isAcceptableOrUnknown(data['usage_note']!, _usageNoteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {phraseId, senseNumber},
  ];
  @override
  PhraseSense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhraseSense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phraseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phrase_id'],
      )!,
      senseNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sense_number'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      ),
      definitionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition_en'],
      )!,
      meaningVi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning_vi'],
      ),
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      ),
      registerLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}register_label'],
      ),
      domainLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}domain_label'],
      ),
      grammarNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_note'],
      ),
      usageNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $PhraseSensesTable createAlias(String alias) {
    return $PhraseSensesTable(attachedDatabase, alias);
  }
}

class PhraseSense extends DataClass implements Insertable<PhraseSense> {
  final String id;
  final String phraseId;
  final int senseNumber;
  final String? partOfSpeech;
  final String definitionEn;
  final String? meaningVi;
  final String? cefrLevel;
  final String? registerLabel;
  final String? domainLabel;
  final String? grammarNote;
  final String? usageNote;
  final int isActive;
  const PhraseSense({
    required this.id,
    required this.phraseId,
    required this.senseNumber,
    this.partOfSpeech,
    required this.definitionEn,
    this.meaningVi,
    this.cefrLevel,
    this.registerLabel,
    this.domainLabel,
    this.grammarNote,
    this.usageNote,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phrase_id'] = Variable<String>(phraseId);
    map['sense_number'] = Variable<int>(senseNumber);
    if (!nullToAbsent || partOfSpeech != null) {
      map['part_of_speech'] = Variable<String>(partOfSpeech);
    }
    map['definition_en'] = Variable<String>(definitionEn);
    if (!nullToAbsent || meaningVi != null) {
      map['meaning_vi'] = Variable<String>(meaningVi);
    }
    if (!nullToAbsent || cefrLevel != null) {
      map['cefr_level'] = Variable<String>(cefrLevel);
    }
    if (!nullToAbsent || registerLabel != null) {
      map['register_label'] = Variable<String>(registerLabel);
    }
    if (!nullToAbsent || domainLabel != null) {
      map['domain_label'] = Variable<String>(domainLabel);
    }
    if (!nullToAbsent || grammarNote != null) {
      map['grammar_note'] = Variable<String>(grammarNote);
    }
    if (!nullToAbsent || usageNote != null) {
      map['usage_note'] = Variable<String>(usageNote);
    }
    map['is_active'] = Variable<int>(isActive);
    return map;
  }

  PhraseSensesCompanion toCompanion(bool nullToAbsent) {
    return PhraseSensesCompanion(
      id: Value(id),
      phraseId: Value(phraseId),
      senseNumber: Value(senseNumber),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
      definitionEn: Value(definitionEn),
      meaningVi: meaningVi == null && nullToAbsent
          ? const Value.absent()
          : Value(meaningVi),
      cefrLevel: cefrLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(cefrLevel),
      registerLabel: registerLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(registerLabel),
      domainLabel: domainLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(domainLabel),
      grammarNote: grammarNote == null && nullToAbsent
          ? const Value.absent()
          : Value(grammarNote),
      usageNote: usageNote == null && nullToAbsent
          ? const Value.absent()
          : Value(usageNote),
      isActive: Value(isActive),
    );
  }

  factory PhraseSense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhraseSense(
      id: serializer.fromJson<String>(json['id']),
      phraseId: serializer.fromJson<String>(json['phraseId']),
      senseNumber: serializer.fromJson<int>(json['senseNumber']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      definitionEn: serializer.fromJson<String>(json['definitionEn']),
      meaningVi: serializer.fromJson<String?>(json['meaningVi']),
      cefrLevel: serializer.fromJson<String?>(json['cefrLevel']),
      registerLabel: serializer.fromJson<String?>(json['registerLabel']),
      domainLabel: serializer.fromJson<String?>(json['domainLabel']),
      grammarNote: serializer.fromJson<String?>(json['grammarNote']),
      usageNote: serializer.fromJson<String?>(json['usageNote']),
      isActive: serializer.fromJson<int>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phraseId': serializer.toJson<String>(phraseId),
      'senseNumber': serializer.toJson<int>(senseNumber),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'definitionEn': serializer.toJson<String>(definitionEn),
      'meaningVi': serializer.toJson<String?>(meaningVi),
      'cefrLevel': serializer.toJson<String?>(cefrLevel),
      'registerLabel': serializer.toJson<String?>(registerLabel),
      'domainLabel': serializer.toJson<String?>(domainLabel),
      'grammarNote': serializer.toJson<String?>(grammarNote),
      'usageNote': serializer.toJson<String?>(usageNote),
      'isActive': serializer.toJson<int>(isActive),
    };
  }

  PhraseSense copyWith({
    String? id,
    String? phraseId,
    int? senseNumber,
    Value<String?> partOfSpeech = const Value.absent(),
    String? definitionEn,
    Value<String?> meaningVi = const Value.absent(),
    Value<String?> cefrLevel = const Value.absent(),
    Value<String?> registerLabel = const Value.absent(),
    Value<String?> domainLabel = const Value.absent(),
    Value<String?> grammarNote = const Value.absent(),
    Value<String?> usageNote = const Value.absent(),
    int? isActive,
  }) => PhraseSense(
    id: id ?? this.id,
    phraseId: phraseId ?? this.phraseId,
    senseNumber: senseNumber ?? this.senseNumber,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    definitionEn: definitionEn ?? this.definitionEn,
    meaningVi: meaningVi.present ? meaningVi.value : this.meaningVi,
    cefrLevel: cefrLevel.present ? cefrLevel.value : this.cefrLevel,
    registerLabel: registerLabel.present
        ? registerLabel.value
        : this.registerLabel,
    domainLabel: domainLabel.present ? domainLabel.value : this.domainLabel,
    grammarNote: grammarNote.present ? grammarNote.value : this.grammarNote,
    usageNote: usageNote.present ? usageNote.value : this.usageNote,
    isActive: isActive ?? this.isActive,
  );
  PhraseSense copyWithCompanion(PhraseSensesCompanion data) {
    return PhraseSense(
      id: data.id.present ? data.id.value : this.id,
      phraseId: data.phraseId.present ? data.phraseId.value : this.phraseId,
      senseNumber: data.senseNumber.present
          ? data.senseNumber.value
          : this.senseNumber,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      definitionEn: data.definitionEn.present
          ? data.definitionEn.value
          : this.definitionEn,
      meaningVi: data.meaningVi.present ? data.meaningVi.value : this.meaningVi,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      registerLabel: data.registerLabel.present
          ? data.registerLabel.value
          : this.registerLabel,
      domainLabel: data.domainLabel.present
          ? data.domainLabel.value
          : this.domainLabel,
      grammarNote: data.grammarNote.present
          ? data.grammarNote.value
          : this.grammarNote,
      usageNote: data.usageNote.present ? data.usageNote.value : this.usageNote,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhraseSense(')
          ..write('id: $id, ')
          ..write('phraseId: $phraseId, ')
          ..write('senseNumber: $senseNumber, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definitionEn: $definitionEn, ')
          ..write('meaningVi: $meaningVi, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('registerLabel: $registerLabel, ')
          ..write('domainLabel: $domainLabel, ')
          ..write('grammarNote: $grammarNote, ')
          ..write('usageNote: $usageNote, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phraseId,
    senseNumber,
    partOfSpeech,
    definitionEn,
    meaningVi,
    cefrLevel,
    registerLabel,
    domainLabel,
    grammarNote,
    usageNote,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhraseSense &&
          other.id == this.id &&
          other.phraseId == this.phraseId &&
          other.senseNumber == this.senseNumber &&
          other.partOfSpeech == this.partOfSpeech &&
          other.definitionEn == this.definitionEn &&
          other.meaningVi == this.meaningVi &&
          other.cefrLevel == this.cefrLevel &&
          other.registerLabel == this.registerLabel &&
          other.domainLabel == this.domainLabel &&
          other.grammarNote == this.grammarNote &&
          other.usageNote == this.usageNote &&
          other.isActive == this.isActive);
}

class PhraseSensesCompanion extends UpdateCompanion<PhraseSense> {
  final Value<String> id;
  final Value<String> phraseId;
  final Value<int> senseNumber;
  final Value<String?> partOfSpeech;
  final Value<String> definitionEn;
  final Value<String?> meaningVi;
  final Value<String?> cefrLevel;
  final Value<String?> registerLabel;
  final Value<String?> domainLabel;
  final Value<String?> grammarNote;
  final Value<String?> usageNote;
  final Value<int> isActive;
  final Value<int> rowid;
  const PhraseSensesCompanion({
    this.id = const Value.absent(),
    this.phraseId = const Value.absent(),
    this.senseNumber = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.definitionEn = const Value.absent(),
    this.meaningVi = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.registerLabel = const Value.absent(),
    this.domainLabel = const Value.absent(),
    this.grammarNote = const Value.absent(),
    this.usageNote = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhraseSensesCompanion.insert({
    required String id,
    required String phraseId,
    this.senseNumber = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    required String definitionEn,
    this.meaningVi = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.registerLabel = const Value.absent(),
    this.domainLabel = const Value.absent(),
    this.grammarNote = const Value.absent(),
    this.usageNote = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phraseId = Value(phraseId),
       definitionEn = Value(definitionEn);
  static Insertable<PhraseSense> custom({
    Expression<String>? id,
    Expression<String>? phraseId,
    Expression<int>? senseNumber,
    Expression<String>? partOfSpeech,
    Expression<String>? definitionEn,
    Expression<String>? meaningVi,
    Expression<String>? cefrLevel,
    Expression<String>? registerLabel,
    Expression<String>? domainLabel,
    Expression<String>? grammarNote,
    Expression<String>? usageNote,
    Expression<int>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phraseId != null) 'phrase_id': phraseId,
      if (senseNumber != null) 'sense_number': senseNumber,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (definitionEn != null) 'definition_en': definitionEn,
      if (meaningVi != null) 'meaning_vi': meaningVi,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (registerLabel != null) 'register_label': registerLabel,
      if (domainLabel != null) 'domain_label': domainLabel,
      if (grammarNote != null) 'grammar_note': grammarNote,
      if (usageNote != null) 'usage_note': usageNote,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhraseSensesCompanion copyWith({
    Value<String>? id,
    Value<String>? phraseId,
    Value<int>? senseNumber,
    Value<String?>? partOfSpeech,
    Value<String>? definitionEn,
    Value<String?>? meaningVi,
    Value<String?>? cefrLevel,
    Value<String?>? registerLabel,
    Value<String?>? domainLabel,
    Value<String?>? grammarNote,
    Value<String?>? usageNote,
    Value<int>? isActive,
    Value<int>? rowid,
  }) {
    return PhraseSensesCompanion(
      id: id ?? this.id,
      phraseId: phraseId ?? this.phraseId,
      senseNumber: senseNumber ?? this.senseNumber,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitionEn: definitionEn ?? this.definitionEn,
      meaningVi: meaningVi ?? this.meaningVi,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      registerLabel: registerLabel ?? this.registerLabel,
      domainLabel: domainLabel ?? this.domainLabel,
      grammarNote: grammarNote ?? this.grammarNote,
      usageNote: usageNote ?? this.usageNote,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phraseId.present) {
      map['phrase_id'] = Variable<String>(phraseId.value);
    }
    if (senseNumber.present) {
      map['sense_number'] = Variable<int>(senseNumber.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (definitionEn.present) {
      map['definition_en'] = Variable<String>(definitionEn.value);
    }
    if (meaningVi.present) {
      map['meaning_vi'] = Variable<String>(meaningVi.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (registerLabel.present) {
      map['register_label'] = Variable<String>(registerLabel.value);
    }
    if (domainLabel.present) {
      map['domain_label'] = Variable<String>(domainLabel.value);
    }
    if (grammarNote.present) {
      map['grammar_note'] = Variable<String>(grammarNote.value);
    }
    if (usageNote.present) {
      map['usage_note'] = Variable<String>(usageNote.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhraseSensesCompanion(')
          ..write('id: $id, ')
          ..write('phraseId: $phraseId, ')
          ..write('senseNumber: $senseNumber, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definitionEn: $definitionEn, ')
          ..write('meaningVi: $meaningVi, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('registerLabel: $registerLabel, ')
          ..write('domainLabel: $domainLabel, ')
          ..write('grammarNote: $grammarNote, ')
          ..write('usageNote: $usageNote, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PronunciationsTable extends Pronunciations
    with TableInfo<$PronunciationsTable, Pronunciation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PronunciationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _headwordIdMeta = const VerificationMeta(
    'headwordId',
  );
  @override
  late final GeneratedColumn<String> headwordId = GeneratedColumn<String>(
    'headword_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES headwords (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _senseIdMeta = const VerificationMeta(
    'senseId',
  );
  @override
  late final GeneratedColumn<String> senseId = GeneratedColumn<String>(
    'sense_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _accentMeta = const VerificationMeta('accent');
  @override
  late final GeneratedColumn<String> accent = GeneratedColumn<String>(
    'accent',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ipaMeta = const VerificationMeta('ipa');
  @override
  late final GeneratedColumn<String> ipa = GeneratedColumn<String>(
    'ipa',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioAssetKeyMeta = const VerificationMeta(
    'audioAssetKey',
  );
  @override
  late final GeneratedColumn<String> audioAssetKey = GeneratedColumn<String>(
    'audio_asset_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceNoteMeta = const VerificationMeta(
    'sourceNote',
  );
  @override
  late final GeneratedColumn<String> sourceNote = GeneratedColumn<String>(
    'source_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenceNoteMeta = const VerificationMeta(
    'licenceNote',
  );
  @override
  late final GeneratedColumn<String> licenceNote = GeneratedColumn<String>(
    'licence_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    headwordId,
    senseId,
    accent,
    ipa,
    audioAssetKey,
    sourceNote,
    licenceNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pronunciations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pronunciation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('headword_id')) {
      context.handle(
        _headwordIdMeta,
        headwordId.isAcceptableOrUnknown(data['headword_id']!, _headwordIdMeta),
      );
    }
    if (data.containsKey('sense_id')) {
      context.handle(
        _senseIdMeta,
        senseId.isAcceptableOrUnknown(data['sense_id']!, _senseIdMeta),
      );
    }
    if (data.containsKey('accent')) {
      context.handle(
        _accentMeta,
        accent.isAcceptableOrUnknown(data['accent']!, _accentMeta),
      );
    } else if (isInserting) {
      context.missing(_accentMeta);
    }
    if (data.containsKey('ipa')) {
      context.handle(
        _ipaMeta,
        ipa.isAcceptableOrUnknown(data['ipa']!, _ipaMeta),
      );
    }
    if (data.containsKey('audio_asset_key')) {
      context.handle(
        _audioAssetKeyMeta,
        audioAssetKey.isAcceptableOrUnknown(
          data['audio_asset_key']!,
          _audioAssetKeyMeta,
        ),
      );
    }
    if (data.containsKey('source_note')) {
      context.handle(
        _sourceNoteMeta,
        sourceNote.isAcceptableOrUnknown(data['source_note']!, _sourceNoteMeta),
      );
    }
    if (data.containsKey('licence_note')) {
      context.handle(
        _licenceNoteMeta,
        licenceNote.isAcceptableOrUnknown(
          data['licence_note']!,
          _licenceNoteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pronunciation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pronunciation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      headwordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}headword_id'],
      ),
      senseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sense_id'],
      ),
      accent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent'],
      )!,
      ipa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ipa'],
      ),
      audioAssetKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_asset_key'],
      ),
      sourceNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_note'],
      ),
      licenceNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}licence_note'],
      ),
    );
  }

  @override
  $PronunciationsTable createAlias(String alias) {
    return $PronunciationsTable(attachedDatabase, alias);
  }
}

class Pronunciation extends DataClass implements Insertable<Pronunciation> {
  final String id;
  final String? headwordId;
  final String? senseId;
  final String accent;
  final String? ipa;
  final String? audioAssetKey;
  final String? sourceNote;
  final String? licenceNote;
  const Pronunciation({
    required this.id,
    this.headwordId,
    this.senseId,
    required this.accent,
    this.ipa,
    this.audioAssetKey,
    this.sourceNote,
    this.licenceNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || headwordId != null) {
      map['headword_id'] = Variable<String>(headwordId);
    }
    if (!nullToAbsent || senseId != null) {
      map['sense_id'] = Variable<String>(senseId);
    }
    map['accent'] = Variable<String>(accent);
    if (!nullToAbsent || ipa != null) {
      map['ipa'] = Variable<String>(ipa);
    }
    if (!nullToAbsent || audioAssetKey != null) {
      map['audio_asset_key'] = Variable<String>(audioAssetKey);
    }
    if (!nullToAbsent || sourceNote != null) {
      map['source_note'] = Variable<String>(sourceNote);
    }
    if (!nullToAbsent || licenceNote != null) {
      map['licence_note'] = Variable<String>(licenceNote);
    }
    return map;
  }

  PronunciationsCompanion toCompanion(bool nullToAbsent) {
    return PronunciationsCompanion(
      id: Value(id),
      headwordId: headwordId == null && nullToAbsent
          ? const Value.absent()
          : Value(headwordId),
      senseId: senseId == null && nullToAbsent
          ? const Value.absent()
          : Value(senseId),
      accent: Value(accent),
      ipa: ipa == null && nullToAbsent ? const Value.absent() : Value(ipa),
      audioAssetKey: audioAssetKey == null && nullToAbsent
          ? const Value.absent()
          : Value(audioAssetKey),
      sourceNote: sourceNote == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceNote),
      licenceNote: licenceNote == null && nullToAbsent
          ? const Value.absent()
          : Value(licenceNote),
    );
  }

  factory Pronunciation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pronunciation(
      id: serializer.fromJson<String>(json['id']),
      headwordId: serializer.fromJson<String?>(json['headwordId']),
      senseId: serializer.fromJson<String?>(json['senseId']),
      accent: serializer.fromJson<String>(json['accent']),
      ipa: serializer.fromJson<String?>(json['ipa']),
      audioAssetKey: serializer.fromJson<String?>(json['audioAssetKey']),
      sourceNote: serializer.fromJson<String?>(json['sourceNote']),
      licenceNote: serializer.fromJson<String?>(json['licenceNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'headwordId': serializer.toJson<String?>(headwordId),
      'senseId': serializer.toJson<String?>(senseId),
      'accent': serializer.toJson<String>(accent),
      'ipa': serializer.toJson<String?>(ipa),
      'audioAssetKey': serializer.toJson<String?>(audioAssetKey),
      'sourceNote': serializer.toJson<String?>(sourceNote),
      'licenceNote': serializer.toJson<String?>(licenceNote),
    };
  }

  Pronunciation copyWith({
    String? id,
    Value<String?> headwordId = const Value.absent(),
    Value<String?> senseId = const Value.absent(),
    String? accent,
    Value<String?> ipa = const Value.absent(),
    Value<String?> audioAssetKey = const Value.absent(),
    Value<String?> sourceNote = const Value.absent(),
    Value<String?> licenceNote = const Value.absent(),
  }) => Pronunciation(
    id: id ?? this.id,
    headwordId: headwordId.present ? headwordId.value : this.headwordId,
    senseId: senseId.present ? senseId.value : this.senseId,
    accent: accent ?? this.accent,
    ipa: ipa.present ? ipa.value : this.ipa,
    audioAssetKey: audioAssetKey.present
        ? audioAssetKey.value
        : this.audioAssetKey,
    sourceNote: sourceNote.present ? sourceNote.value : this.sourceNote,
    licenceNote: licenceNote.present ? licenceNote.value : this.licenceNote,
  );
  Pronunciation copyWithCompanion(PronunciationsCompanion data) {
    return Pronunciation(
      id: data.id.present ? data.id.value : this.id,
      headwordId: data.headwordId.present
          ? data.headwordId.value
          : this.headwordId,
      senseId: data.senseId.present ? data.senseId.value : this.senseId,
      accent: data.accent.present ? data.accent.value : this.accent,
      ipa: data.ipa.present ? data.ipa.value : this.ipa,
      audioAssetKey: data.audioAssetKey.present
          ? data.audioAssetKey.value
          : this.audioAssetKey,
      sourceNote: data.sourceNote.present
          ? data.sourceNote.value
          : this.sourceNote,
      licenceNote: data.licenceNote.present
          ? data.licenceNote.value
          : this.licenceNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pronunciation(')
          ..write('id: $id, ')
          ..write('headwordId: $headwordId, ')
          ..write('senseId: $senseId, ')
          ..write('accent: $accent, ')
          ..write('ipa: $ipa, ')
          ..write('audioAssetKey: $audioAssetKey, ')
          ..write('sourceNote: $sourceNote, ')
          ..write('licenceNote: $licenceNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    headwordId,
    senseId,
    accent,
    ipa,
    audioAssetKey,
    sourceNote,
    licenceNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pronunciation &&
          other.id == this.id &&
          other.headwordId == this.headwordId &&
          other.senseId == this.senseId &&
          other.accent == this.accent &&
          other.ipa == this.ipa &&
          other.audioAssetKey == this.audioAssetKey &&
          other.sourceNote == this.sourceNote &&
          other.licenceNote == this.licenceNote);
}

class PronunciationsCompanion extends UpdateCompanion<Pronunciation> {
  final Value<String> id;
  final Value<String?> headwordId;
  final Value<String?> senseId;
  final Value<String> accent;
  final Value<String?> ipa;
  final Value<String?> audioAssetKey;
  final Value<String?> sourceNote;
  final Value<String?> licenceNote;
  final Value<int> rowid;
  const PronunciationsCompanion({
    this.id = const Value.absent(),
    this.headwordId = const Value.absent(),
    this.senseId = const Value.absent(),
    this.accent = const Value.absent(),
    this.ipa = const Value.absent(),
    this.audioAssetKey = const Value.absent(),
    this.sourceNote = const Value.absent(),
    this.licenceNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PronunciationsCompanion.insert({
    required String id,
    this.headwordId = const Value.absent(),
    this.senseId = const Value.absent(),
    required String accent,
    this.ipa = const Value.absent(),
    this.audioAssetKey = const Value.absent(),
    this.sourceNote = const Value.absent(),
    this.licenceNote = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accent = Value(accent);
  static Insertable<Pronunciation> custom({
    Expression<String>? id,
    Expression<String>? headwordId,
    Expression<String>? senseId,
    Expression<String>? accent,
    Expression<String>? ipa,
    Expression<String>? audioAssetKey,
    Expression<String>? sourceNote,
    Expression<String>? licenceNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (headwordId != null) 'headword_id': headwordId,
      if (senseId != null) 'sense_id': senseId,
      if (accent != null) 'accent': accent,
      if (ipa != null) 'ipa': ipa,
      if (audioAssetKey != null) 'audio_asset_key': audioAssetKey,
      if (sourceNote != null) 'source_note': sourceNote,
      if (licenceNote != null) 'licence_note': licenceNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PronunciationsCompanion copyWith({
    Value<String>? id,
    Value<String?>? headwordId,
    Value<String?>? senseId,
    Value<String>? accent,
    Value<String?>? ipa,
    Value<String?>? audioAssetKey,
    Value<String?>? sourceNote,
    Value<String?>? licenceNote,
    Value<int>? rowid,
  }) {
    return PronunciationsCompanion(
      id: id ?? this.id,
      headwordId: headwordId ?? this.headwordId,
      senseId: senseId ?? this.senseId,
      accent: accent ?? this.accent,
      ipa: ipa ?? this.ipa,
      audioAssetKey: audioAssetKey ?? this.audioAssetKey,
      sourceNote: sourceNote ?? this.sourceNote,
      licenceNote: licenceNote ?? this.licenceNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (headwordId.present) {
      map['headword_id'] = Variable<String>(headwordId.value);
    }
    if (senseId.present) {
      map['sense_id'] = Variable<String>(senseId.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (ipa.present) {
      map['ipa'] = Variable<String>(ipa.value);
    }
    if (audioAssetKey.present) {
      map['audio_asset_key'] = Variable<String>(audioAssetKey.value);
    }
    if (sourceNote.present) {
      map['source_note'] = Variable<String>(sourceNote.value);
    }
    if (licenceNote.present) {
      map['licence_note'] = Variable<String>(licenceNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PronunciationsCompanion(')
          ..write('id: $id, ')
          ..write('headwordId: $headwordId, ')
          ..write('senseId: $senseId, ')
          ..write('accent: $accent, ')
          ..write('ipa: $ipa, ')
          ..write('audioAssetKey: $audioAssetKey, ')
          ..write('sourceNote: $sourceNote, ')
          ..write('licenceNote: $licenceNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InflectionsTable extends Inflections
    with TableInfo<$InflectionsTable, Inflection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InflectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _headwordIdMeta = const VerificationMeta(
    'headwordId',
  );
  @override
  late final GeneratedColumn<String> headwordId = GeneratedColumn<String>(
    'headword_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES headwords (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formTypeMeta = const VerificationMeta(
    'formType',
  );
  @override
  late final GeneratedColumn<String> formType = GeneratedColumn<String>(
    'form_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, headwordId, form, formType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inflections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Inflection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('headword_id')) {
      context.handle(
        _headwordIdMeta,
        headwordId.isAcceptableOrUnknown(data['headword_id']!, _headwordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_headwordIdMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('form_type')) {
      context.handle(
        _formTypeMeta,
        formType.isAcceptableOrUnknown(data['form_type']!, _formTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_formTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {headwordId, form, formType},
  ];
  @override
  Inflection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Inflection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      headwordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}headword_id'],
      )!,
      form: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      formType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form_type'],
      )!,
    );
  }

  @override
  $InflectionsTable createAlias(String alias) {
    return $InflectionsTable(attachedDatabase, alias);
  }
}

class Inflection extends DataClass implements Insertable<Inflection> {
  final String id;
  final String headwordId;
  final String form;
  final String formType;
  const Inflection({
    required this.id,
    required this.headwordId,
    required this.form,
    required this.formType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['headword_id'] = Variable<String>(headwordId);
    map['form'] = Variable<String>(form);
    map['form_type'] = Variable<String>(formType);
    return map;
  }

  InflectionsCompanion toCompanion(bool nullToAbsent) {
    return InflectionsCompanion(
      id: Value(id),
      headwordId: Value(headwordId),
      form: Value(form),
      formType: Value(formType),
    );
  }

  factory Inflection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inflection(
      id: serializer.fromJson<String>(json['id']),
      headwordId: serializer.fromJson<String>(json['headwordId']),
      form: serializer.fromJson<String>(json['form']),
      formType: serializer.fromJson<String>(json['formType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'headwordId': serializer.toJson<String>(headwordId),
      'form': serializer.toJson<String>(form),
      'formType': serializer.toJson<String>(formType),
    };
  }

  Inflection copyWith({
    String? id,
    String? headwordId,
    String? form,
    String? formType,
  }) => Inflection(
    id: id ?? this.id,
    headwordId: headwordId ?? this.headwordId,
    form: form ?? this.form,
    formType: formType ?? this.formType,
  );
  Inflection copyWithCompanion(InflectionsCompanion data) {
    return Inflection(
      id: data.id.present ? data.id.value : this.id,
      headwordId: data.headwordId.present
          ? data.headwordId.value
          : this.headwordId,
      form: data.form.present ? data.form.value : this.form,
      formType: data.formType.present ? data.formType.value : this.formType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Inflection(')
          ..write('id: $id, ')
          ..write('headwordId: $headwordId, ')
          ..write('form: $form, ')
          ..write('formType: $formType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, headwordId, form, formType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inflection &&
          other.id == this.id &&
          other.headwordId == this.headwordId &&
          other.form == this.form &&
          other.formType == this.formType);
}

class InflectionsCompanion extends UpdateCompanion<Inflection> {
  final Value<String> id;
  final Value<String> headwordId;
  final Value<String> form;
  final Value<String> formType;
  final Value<int> rowid;
  const InflectionsCompanion({
    this.id = const Value.absent(),
    this.headwordId = const Value.absent(),
    this.form = const Value.absent(),
    this.formType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InflectionsCompanion.insert({
    required String id,
    required String headwordId,
    required String form,
    required String formType,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       headwordId = Value(headwordId),
       form = Value(form),
       formType = Value(formType);
  static Insertable<Inflection> custom({
    Expression<String>? id,
    Expression<String>? headwordId,
    Expression<String>? form,
    Expression<String>? formType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (headwordId != null) 'headword_id': headwordId,
      if (form != null) 'form': form,
      if (formType != null) 'form_type': formType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InflectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? headwordId,
    Value<String>? form,
    Value<String>? formType,
    Value<int>? rowid,
  }) {
    return InflectionsCompanion(
      id: id ?? this.id,
      headwordId: headwordId ?? this.headwordId,
      form: form ?? this.form,
      formType: formType ?? this.formType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (headwordId.present) {
      map['headword_id'] = Variable<String>(headwordId.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (formType.present) {
      map['form_type'] = Variable<String>(formType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InflectionsCompanion(')
          ..write('id: $id, ')
          ..write('headwordId: $headwordId, ')
          ..write('form: $form, ')
          ..write('formType: $formType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentSourcesTable extends ContentSources
    with TableInfo<$ContentSourcesTable, ContentSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenceMeta = const VerificationMeta(
    'licence',
  );
  @override
  late final GeneratedColumn<String> licence = GeneratedColumn<String>(
    'licence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, licence, url];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('licence')) {
      context.handle(
        _licenceMeta,
        licence.isAcceptableOrUnknown(data['licence']!, _licenceMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      licence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}licence'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
    );
  }

  @override
  $ContentSourcesTable createAlias(String alias) {
    return $ContentSourcesTable(attachedDatabase, alias);
  }
}

class ContentSource extends DataClass implements Insertable<ContentSource> {
  final String id;
  final String name;
  final String? licence;
  final String? url;
  const ContentSource({
    required this.id,
    required this.name,
    this.licence,
    this.url,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || licence != null) {
      map['licence'] = Variable<String>(licence);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    return map;
  }

  ContentSourcesCompanion toCompanion(bool nullToAbsent) {
    return ContentSourcesCompanion(
      id: Value(id),
      name: Value(name),
      licence: licence == null && nullToAbsent
          ? const Value.absent()
          : Value(licence),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
    );
  }

  factory ContentSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentSource(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      licence: serializer.fromJson<String?>(json['licence']),
      url: serializer.fromJson<String?>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'licence': serializer.toJson<String?>(licence),
      'url': serializer.toJson<String?>(url),
    };
  }

  ContentSource copyWith({
    String? id,
    String? name,
    Value<String?> licence = const Value.absent(),
    Value<String?> url = const Value.absent(),
  }) => ContentSource(
    id: id ?? this.id,
    name: name ?? this.name,
    licence: licence.present ? licence.value : this.licence,
    url: url.present ? url.value : this.url,
  );
  ContentSource copyWithCompanion(ContentSourcesCompanion data) {
    return ContentSource(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      licence: data.licence.present ? data.licence.value : this.licence,
      url: data.url.present ? data.url.value : this.url,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentSource(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('licence: $licence, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, licence, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentSource &&
          other.id == this.id &&
          other.name == this.name &&
          other.licence == this.licence &&
          other.url == this.url);
}

class ContentSourcesCompanion extends UpdateCompanion<ContentSource> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> licence;
  final Value<String?> url;
  final Value<int> rowid;
  const ContentSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.licence = const Value.absent(),
    this.url = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentSourcesCompanion.insert({
    required String id,
    required String name,
    this.licence = const Value.absent(),
    this.url = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<ContentSource> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? licence,
    Expression<String>? url,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (licence != null) 'licence': licence,
      if (url != null) 'url': url,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentSourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? licence,
    Value<String?>? url,
    Value<int>? rowid,
  }) {
    return ContentSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      licence: licence ?? this.licence,
      url: url ?? this.url,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (licence.present) {
      map['licence'] = Variable<String>(licence.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('licence: $licence, ')
          ..write('url: $url, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SourceAttributionsTable extends SourceAttributions
    with TableInfo<$SourceAttributionsTable, SourceAttribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SourceAttributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES content_sources (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sourceId, entityType, entityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'source_attributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SourceAttribution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SourceAttribution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SourceAttribution(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
    );
  }

  @override
  $SourceAttributionsTable createAlias(String alias) {
    return $SourceAttributionsTable(attachedDatabase, alias);
  }
}

class SourceAttribution extends DataClass
    implements Insertable<SourceAttribution> {
  final String id;
  final String sourceId;
  final String entityType;
  final String entityId;
  const SourceAttribution({
    required this.id,
    required this.sourceId,
    required this.entityType,
    required this.entityId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_id'] = Variable<String>(sourceId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    return map;
  }

  SourceAttributionsCompanion toCompanion(bool nullToAbsent) {
    return SourceAttributionsCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      entityType: Value(entityType),
      entityId: Value(entityId),
    );
  }

  factory SourceAttribution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SourceAttribution(
      id: serializer.fromJson<String>(json['id']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceId': serializer.toJson<String>(sourceId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
    };
  }

  SourceAttribution copyWith({
    String? id,
    String? sourceId,
    String? entityType,
    String? entityId,
  }) => SourceAttribution(
    id: id ?? this.id,
    sourceId: sourceId ?? this.sourceId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
  );
  SourceAttribution copyWithCompanion(SourceAttributionsCompanion data) {
    return SourceAttribution(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SourceAttribution(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceId, entityType, entityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SourceAttribution &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId);
}

class SourceAttributionsCompanion extends UpdateCompanion<SourceAttribution> {
  final Value<String> id;
  final Value<String> sourceId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<int> rowid;
  const SourceAttributionsCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SourceAttributionsCompanion.insert({
    required String id,
    required String sourceId,
    required String entityType,
    required String entityId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceId = Value(sourceId),
       entityType = Value(entityType),
       entityId = Value(entityId);
  static Insertable<SourceAttribution> custom({
    Expression<String>? id,
    Expression<String>? sourceId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SourceAttributionsCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<int>? rowid,
  }) {
    return SourceAttributionsCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SourceAttributionsCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamplesTable extends Examples with TableInfo<$ExamplesTable, Example> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamplesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyItemIdMeta = const VerificationMeta(
    'studyItemId',
  );
  @override
  late final GeneratedColumn<String> studyItemId = GeneratedColumn<String>(
    'study_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _englishTextMeta = const VerificationMeta(
    'englishText',
  );
  @override
  late final GeneratedColumn<String> englishText = GeneratedColumn<String>(
    'english_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vietnameseTextMeta = const VerificationMeta(
    'vietnameseText',
  );
  @override
  late final GeneratedColumn<String> vietnameseText = GeneratedColumn<String>(
    'vietnamese_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioAssetKeyMeta = const VerificationMeta(
    'audioAssetKey',
  );
  @override
  late final GeneratedColumn<String> audioAssetKey = GeneratedColumn<String>(
    'audio_asset_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES content_sources (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyItemId,
    englishText,
    vietnameseText,
    note,
    audioAssetKey,
    sortOrder,
    sourceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'examples';
  @override
  VerificationContext validateIntegrity(
    Insertable<Example> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_item_id')) {
      context.handle(
        _studyItemIdMeta,
        studyItemId.isAcceptableOrUnknown(
          data['study_item_id']!,
          _studyItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyItemIdMeta);
    }
    if (data.containsKey('english_text')) {
      context.handle(
        _englishTextMeta,
        englishText.isAcceptableOrUnknown(
          data['english_text']!,
          _englishTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_englishTextMeta);
    }
    if (data.containsKey('vietnamese_text')) {
      context.handle(
        _vietnameseTextMeta,
        vietnameseText.isAcceptableOrUnknown(
          data['vietnamese_text']!,
          _vietnameseTextMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('audio_asset_key')) {
      context.handle(
        _audioAssetKeyMeta,
        audioAssetKey.isAcceptableOrUnknown(
          data['audio_asset_key']!,
          _audioAssetKeyMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Example map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Example(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_item_id'],
      )!,
      englishText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}english_text'],
      )!,
      vietnameseText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vietnamese_text'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      audioAssetKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_asset_key'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
    );
  }

  @override
  $ExamplesTable createAlias(String alias) {
    return $ExamplesTable(attachedDatabase, alias);
  }
}

class Example extends DataClass implements Insertable<Example> {
  final String id;
  final String studyItemId;
  final String englishText;
  final String? vietnameseText;
  final String? note;
  final String? audioAssetKey;
  final int sortOrder;
  final String? sourceId;
  const Example({
    required this.id,
    required this.studyItemId,
    required this.englishText,
    this.vietnameseText,
    this.note,
    this.audioAssetKey,
    required this.sortOrder,
    this.sourceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_item_id'] = Variable<String>(studyItemId);
    map['english_text'] = Variable<String>(englishText);
    if (!nullToAbsent || vietnameseText != null) {
      map['vietnamese_text'] = Variable<String>(vietnameseText);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || audioAssetKey != null) {
      map['audio_asset_key'] = Variable<String>(audioAssetKey);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    return map;
  }

  ExamplesCompanion toCompanion(bool nullToAbsent) {
    return ExamplesCompanion(
      id: Value(id),
      studyItemId: Value(studyItemId),
      englishText: Value(englishText),
      vietnameseText: vietnameseText == null && nullToAbsent
          ? const Value.absent()
          : Value(vietnameseText),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      audioAssetKey: audioAssetKey == null && nullToAbsent
          ? const Value.absent()
          : Value(audioAssetKey),
      sortOrder: Value(sortOrder),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
    );
  }

  factory Example.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Example(
      id: serializer.fromJson<String>(json['id']),
      studyItemId: serializer.fromJson<String>(json['studyItemId']),
      englishText: serializer.fromJson<String>(json['englishText']),
      vietnameseText: serializer.fromJson<String?>(json['vietnameseText']),
      note: serializer.fromJson<String?>(json['note']),
      audioAssetKey: serializer.fromJson<String?>(json['audioAssetKey']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyItemId': serializer.toJson<String>(studyItemId),
      'englishText': serializer.toJson<String>(englishText),
      'vietnameseText': serializer.toJson<String?>(vietnameseText),
      'note': serializer.toJson<String?>(note),
      'audioAssetKey': serializer.toJson<String?>(audioAssetKey),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'sourceId': serializer.toJson<String?>(sourceId),
    };
  }

  Example copyWith({
    String? id,
    String? studyItemId,
    String? englishText,
    Value<String?> vietnameseText = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> audioAssetKey = const Value.absent(),
    int? sortOrder,
    Value<String?> sourceId = const Value.absent(),
  }) => Example(
    id: id ?? this.id,
    studyItemId: studyItemId ?? this.studyItemId,
    englishText: englishText ?? this.englishText,
    vietnameseText: vietnameseText.present
        ? vietnameseText.value
        : this.vietnameseText,
    note: note.present ? note.value : this.note,
    audioAssetKey: audioAssetKey.present
        ? audioAssetKey.value
        : this.audioAssetKey,
    sortOrder: sortOrder ?? this.sortOrder,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
  );
  Example copyWithCompanion(ExamplesCompanion data) {
    return Example(
      id: data.id.present ? data.id.value : this.id,
      studyItemId: data.studyItemId.present
          ? data.studyItemId.value
          : this.studyItemId,
      englishText: data.englishText.present
          ? data.englishText.value
          : this.englishText,
      vietnameseText: data.vietnameseText.present
          ? data.vietnameseText.value
          : this.vietnameseText,
      note: data.note.present ? data.note.value : this.note,
      audioAssetKey: data.audioAssetKey.present
          ? data.audioAssetKey.value
          : this.audioAssetKey,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Example(')
          ..write('id: $id, ')
          ..write('studyItemId: $studyItemId, ')
          ..write('englishText: $englishText, ')
          ..write('vietnameseText: $vietnameseText, ')
          ..write('note: $note, ')
          ..write('audioAssetKey: $audioAssetKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('sourceId: $sourceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyItemId,
    englishText,
    vietnameseText,
    note,
    audioAssetKey,
    sortOrder,
    sourceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Example &&
          other.id == this.id &&
          other.studyItemId == this.studyItemId &&
          other.englishText == this.englishText &&
          other.vietnameseText == this.vietnameseText &&
          other.note == this.note &&
          other.audioAssetKey == this.audioAssetKey &&
          other.sortOrder == this.sortOrder &&
          other.sourceId == this.sourceId);
}

class ExamplesCompanion extends UpdateCompanion<Example> {
  final Value<String> id;
  final Value<String> studyItemId;
  final Value<String> englishText;
  final Value<String?> vietnameseText;
  final Value<String?> note;
  final Value<String?> audioAssetKey;
  final Value<int> sortOrder;
  final Value<String?> sourceId;
  final Value<int> rowid;
  const ExamplesCompanion({
    this.id = const Value.absent(),
    this.studyItemId = const Value.absent(),
    this.englishText = const Value.absent(),
    this.vietnameseText = const Value.absent(),
    this.note = const Value.absent(),
    this.audioAssetKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamplesCompanion.insert({
    required String id,
    required String studyItemId,
    required String englishText,
    this.vietnameseText = const Value.absent(),
    this.note = const Value.absent(),
    this.audioAssetKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyItemId = Value(studyItemId),
       englishText = Value(englishText);
  static Insertable<Example> custom({
    Expression<String>? id,
    Expression<String>? studyItemId,
    Expression<String>? englishText,
    Expression<String>? vietnameseText,
    Expression<String>? note,
    Expression<String>? audioAssetKey,
    Expression<int>? sortOrder,
    Expression<String>? sourceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyItemId != null) 'study_item_id': studyItemId,
      if (englishText != null) 'english_text': englishText,
      if (vietnameseText != null) 'vietnamese_text': vietnameseText,
      if (note != null) 'note': note,
      if (audioAssetKey != null) 'audio_asset_key': audioAssetKey,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (sourceId != null) 'source_id': sourceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamplesCompanion copyWith({
    Value<String>? id,
    Value<String>? studyItemId,
    Value<String>? englishText,
    Value<String?>? vietnameseText,
    Value<String?>? note,
    Value<String?>? audioAssetKey,
    Value<int>? sortOrder,
    Value<String?>? sourceId,
    Value<int>? rowid,
  }) {
    return ExamplesCompanion(
      id: id ?? this.id,
      studyItemId: studyItemId ?? this.studyItemId,
      englishText: englishText ?? this.englishText,
      vietnameseText: vietnameseText ?? this.vietnameseText,
      note: note ?? this.note,
      audioAssetKey: audioAssetKey ?? this.audioAssetKey,
      sortOrder: sortOrder ?? this.sortOrder,
      sourceId: sourceId ?? this.sourceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyItemId.present) {
      map['study_item_id'] = Variable<String>(studyItemId.value);
    }
    if (englishText.present) {
      map['english_text'] = Variable<String>(englishText.value);
    }
    if (vietnameseText.present) {
      map['vietnamese_text'] = Variable<String>(vietnameseText.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (audioAssetKey.present) {
      map['audio_asset_key'] = Variable<String>(audioAssetKey.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamplesCompanion(')
          ..write('id: $id, ')
          ..write('studyItemId: $studyItemId, ')
          ..write('englishText: $englishText, ')
          ..write('vietnameseText: $vietnameseText, ')
          ..write('note: $note, ')
          ..write('audioAssetKey: $audioAssetKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('sourceId: $sourceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, slug, name, category, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String slug;
  final String name;
  final String category;
  final String? description;
  const Tag({
    required this.id,
    required this.slug,
    required this.name,
    required this.category,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      category: Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String?>(description),
    };
  }

  Tag copyWith({
    String? id,
    String? slug,
    String? name,
    String? category,
    Value<String?> description = const Value.absent(),
  }) => Tag(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    category: category ?? this.category,
    description: description.present ? description.value : this.description,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, name, category, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.category == this.category &&
          other.description == this.description);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> description;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String slug,
    required String name,
    required String category,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slug = Value(slug),
       name = Value(name),
       category = Value(category);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemTagsTable extends ItemTags with TableInfo<$ItemTagsTable, ItemTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studyItemIdMeta = const VerificationMeta(
    'studyItemId',
  );
  @override
  late final GeneratedColumn<String> studyItemId = GeneratedColumn<String>(
    'study_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [studyItemId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('study_item_id')) {
      context.handle(
        _studyItemIdMeta,
        studyItemId.isAcceptableOrUnknown(
          data['study_item_id']!,
          _studyItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyItemIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studyItemId, tagId};
  @override
  ItemTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemTag(
      studyItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_item_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $ItemTagsTable createAlias(String alias) {
    return $ItemTagsTable(attachedDatabase, alias);
  }
}

class ItemTag extends DataClass implements Insertable<ItemTag> {
  final String studyItemId;
  final String tagId;
  const ItemTag({required this.studyItemId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['study_item_id'] = Variable<String>(studyItemId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  ItemTagsCompanion toCompanion(bool nullToAbsent) {
    return ItemTagsCompanion(
      studyItemId: Value(studyItemId),
      tagId: Value(tagId),
    );
  }

  factory ItemTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemTag(
      studyItemId: serializer.fromJson<String>(json['studyItemId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studyItemId': serializer.toJson<String>(studyItemId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  ItemTag copyWith({String? studyItemId, String? tagId}) => ItemTag(
    studyItemId: studyItemId ?? this.studyItemId,
    tagId: tagId ?? this.tagId,
  );
  ItemTag copyWithCompanion(ItemTagsCompanion data) {
    return ItemTag(
      studyItemId: data.studyItemId.present
          ? data.studyItemId.value
          : this.studyItemId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemTag(')
          ..write('studyItemId: $studyItemId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(studyItemId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemTag &&
          other.studyItemId == this.studyItemId &&
          other.tagId == this.tagId);
}

class ItemTagsCompanion extends UpdateCompanion<ItemTag> {
  final Value<String> studyItemId;
  final Value<String> tagId;
  final Value<int> rowid;
  const ItemTagsCompanion({
    this.studyItemId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemTagsCompanion.insert({
    required String studyItemId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : studyItemId = Value(studyItemId),
       tagId = Value(tagId);
  static Insertable<ItemTag> custom({
    Expression<String>? studyItemId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studyItemId != null) 'study_item_id': studyItemId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemTagsCompanion copyWith({
    Value<String>? studyItemId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return ItemTagsCompanion(
      studyItemId: studyItemId ?? this.studyItemId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studyItemId.present) {
      map['study_item_id'] = Variable<String>(studyItemId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTagsCompanion(')
          ..write('studyItemId: $studyItemId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetItemIdMeta = const VerificationMeta(
    'targetItemId',
  );
  @override
  late final GeneratedColumn<String> targetItemId = GeneratedColumn<String>(
    'target_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _questionTypeMeta = const VerificationMeta(
    'questionType',
  );
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
    'question_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (question_type IN (\'meaning_choice\', \'definition_choice\', \'cloze_choice\'))',
  );
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
    'prompt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentOriginMeta = const VerificationMeta(
    'contentOrigin',
  );
  @override
  late final GeneratedColumn<String> contentOrigin = GeneratedColumn<String>(
    'content_origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (content_origin IN (\'seed\', \'user\', \'app_generated\'))',
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetItemId,
    questionType,
    prompt,
    explanation,
    cefrLevel,
    contentOrigin,
    isActive,
    createdAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Question> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target_item_id')) {
      context.handle(
        _targetItemIdMeta,
        targetItemId.isAcceptableOrUnknown(
          data['target_item_id']!,
          _targetItemIdMeta,
        ),
      );
    }
    if (data.containsKey('question_type')) {
      context.handle(
        _questionTypeMeta,
        questionType.isAcceptableOrUnknown(
          data['question_type']!,
          _questionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(
        _promptMeta,
        prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta),
      );
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    }
    if (data.containsKey('content_origin')) {
      context.handle(
        _contentOriginMeta,
        contentOrigin.isAcceptableOrUnknown(
          data['content_origin']!,
          _contentOriginMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentOriginMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Question(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      targetItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_item_id'],
      ),
      questionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_type'],
      )!,
      prompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      ),
      contentOrigin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_origin'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final String id;
  final String? targetItemId;
  final String questionType;
  final String prompt;
  final String? explanation;
  final String? cefrLevel;
  final String contentOrigin;
  final int isActive;
  final int createdAtMs;
  const Question({
    required this.id,
    this.targetItemId,
    required this.questionType,
    required this.prompt,
    this.explanation,
    this.cefrLevel,
    required this.contentOrigin,
    required this.isActive,
    required this.createdAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || targetItemId != null) {
      map['target_item_id'] = Variable<String>(targetItemId);
    }
    map['question_type'] = Variable<String>(questionType);
    map['prompt'] = Variable<String>(prompt);
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    if (!nullToAbsent || cefrLevel != null) {
      map['cefr_level'] = Variable<String>(cefrLevel);
    }
    map['content_origin'] = Variable<String>(contentOrigin);
    map['is_active'] = Variable<int>(isActive);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      targetItemId: targetItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetItemId),
      questionType: Value(questionType),
      prompt: Value(prompt),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      cefrLevel: cefrLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(cefrLevel),
      contentOrigin: Value(contentOrigin),
      isActive: Value(isActive),
      createdAtMs: Value(createdAtMs),
    );
  }

  factory Question.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<String>(json['id']),
      targetItemId: serializer.fromJson<String?>(json['targetItemId']),
      questionType: serializer.fromJson<String>(json['questionType']),
      prompt: serializer.fromJson<String>(json['prompt']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      cefrLevel: serializer.fromJson<String?>(json['cefrLevel']),
      contentOrigin: serializer.fromJson<String>(json['contentOrigin']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'targetItemId': serializer.toJson<String?>(targetItemId),
      'questionType': serializer.toJson<String>(questionType),
      'prompt': serializer.toJson<String>(prompt),
      'explanation': serializer.toJson<String?>(explanation),
      'cefrLevel': serializer.toJson<String?>(cefrLevel),
      'contentOrigin': serializer.toJson<String>(contentOrigin),
      'isActive': serializer.toJson<int>(isActive),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
    };
  }

  Question copyWith({
    String? id,
    Value<String?> targetItemId = const Value.absent(),
    String? questionType,
    String? prompt,
    Value<String?> explanation = const Value.absent(),
    Value<String?> cefrLevel = const Value.absent(),
    String? contentOrigin,
    int? isActive,
    int? createdAtMs,
  }) => Question(
    id: id ?? this.id,
    targetItemId: targetItemId.present ? targetItemId.value : this.targetItemId,
    questionType: questionType ?? this.questionType,
    prompt: prompt ?? this.prompt,
    explanation: explanation.present ? explanation.value : this.explanation,
    cefrLevel: cefrLevel.present ? cefrLevel.value : this.cefrLevel,
    contentOrigin: contentOrigin ?? this.contentOrigin,
    isActive: isActive ?? this.isActive,
    createdAtMs: createdAtMs ?? this.createdAtMs,
  );
  Question copyWithCompanion(QuestionsCompanion data) {
    return Question(
      id: data.id.present ? data.id.value : this.id,
      targetItemId: data.targetItemId.present
          ? data.targetItemId.value
          : this.targetItemId,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      contentOrigin: data.contentOrigin.present
          ? data.contentOrigin.value
          : this.contentOrigin,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('targetItemId: $targetItemId, ')
          ..write('questionType: $questionType, ')
          ..write('prompt: $prompt, ')
          ..write('explanation: $explanation, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('contentOrigin: $contentOrigin, ')
          ..write('isActive: $isActive, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetItemId,
    questionType,
    prompt,
    explanation,
    cefrLevel,
    contentOrigin,
    isActive,
    createdAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.targetItemId == this.targetItemId &&
          other.questionType == this.questionType &&
          other.prompt == this.prompt &&
          other.explanation == this.explanation &&
          other.cefrLevel == this.cefrLevel &&
          other.contentOrigin == this.contentOrigin &&
          other.isActive == this.isActive &&
          other.createdAtMs == this.createdAtMs);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<String> id;
  final Value<String?> targetItemId;
  final Value<String> questionType;
  final Value<String> prompt;
  final Value<String?> explanation;
  final Value<String?> cefrLevel;
  final Value<String> contentOrigin;
  final Value<int> isActive;
  final Value<int> createdAtMs;
  final Value<int> rowid;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.targetItemId = const Value.absent(),
    this.questionType = const Value.absent(),
    this.prompt = const Value.absent(),
    this.explanation = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.contentOrigin = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    required String id,
    this.targetItemId = const Value.absent(),
    required String questionType,
    required String prompt,
    this.explanation = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    required String contentOrigin,
    this.isActive = const Value.absent(),
    required int createdAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       questionType = Value(questionType),
       prompt = Value(prompt),
       contentOrigin = Value(contentOrigin),
       createdAtMs = Value(createdAtMs);
  static Insertable<Question> custom({
    Expression<String>? id,
    Expression<String>? targetItemId,
    Expression<String>? questionType,
    Expression<String>? prompt,
    Expression<String>? explanation,
    Expression<String>? cefrLevel,
    Expression<String>? contentOrigin,
    Expression<int>? isActive,
    Expression<int>? createdAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetItemId != null) 'target_item_id': targetItemId,
      if (questionType != null) 'question_type': questionType,
      if (prompt != null) 'prompt': prompt,
      if (explanation != null) 'explanation': explanation,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (contentOrigin != null) 'content_origin': contentOrigin,
      if (isActive != null) 'is_active': isActive,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith({
    Value<String>? id,
    Value<String?>? targetItemId,
    Value<String>? questionType,
    Value<String>? prompt,
    Value<String?>? explanation,
    Value<String?>? cefrLevel,
    Value<String>? contentOrigin,
    Value<int>? isActive,
    Value<int>? createdAtMs,
    Value<int>? rowid,
  }) {
    return QuestionsCompanion(
      id: id ?? this.id,
      targetItemId: targetItemId ?? this.targetItemId,
      questionType: questionType ?? this.questionType,
      prompt: prompt ?? this.prompt,
      explanation: explanation ?? this.explanation,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      contentOrigin: contentOrigin ?? this.contentOrigin,
      isActive: isActive ?? this.isActive,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (targetItemId.present) {
      map['target_item_id'] = Variable<String>(targetItemId.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (contentOrigin.present) {
      map['content_origin'] = Variable<String>(contentOrigin.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('targetItemId: $targetItemId, ')
          ..write('questionType: $questionType, ')
          ..write('prompt: $prompt, ')
          ..write('explanation: $explanation, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('contentOrigin: $contentOrigin, ')
          ..write('isActive: $isActive, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionOptionsTable extends QuestionOptions
    with TableInfo<$QuestionOptionsTable, QuestionOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _optionTextMeta = const VerificationMeta(
    'optionText',
  );
  @override
  late final GeneratedColumn<String> optionText = GeneratedColumn<String>(
    'option_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<int> isCorrect = GeneratedColumn<int>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (is_correct IN (0, 1))',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionId,
    optionText,
    sortOrder,
    isCorrect,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionOption> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('option_text')) {
      context.handle(
        _optionTextMeta,
        optionText.isAcceptableOrUnknown(data['option_text']!, _optionTextMeta),
      );
    } else if (isInserting) {
      context.missing(_optionTextMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionOption(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      optionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_text'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_correct'],
      )!,
    );
  }

  @override
  $QuestionOptionsTable createAlias(String alias) {
    return $QuestionOptionsTable(attachedDatabase, alias);
  }
}

class QuestionOption extends DataClass implements Insertable<QuestionOption> {
  final String id;
  final String questionId;
  final String optionText;
  final int sortOrder;
  final int isCorrect;
  const QuestionOption({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.sortOrder,
    required this.isCorrect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question_id'] = Variable<String>(questionId);
    map['option_text'] = Variable<String>(optionText);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_correct'] = Variable<int>(isCorrect);
    return map;
  }

  QuestionOptionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionOptionsCompanion(
      id: Value(id),
      questionId: Value(questionId),
      optionText: Value(optionText),
      sortOrder: Value(sortOrder),
      isCorrect: Value(isCorrect),
    );
  }

  factory QuestionOption.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionOption(
      id: serializer.fromJson<String>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      optionText: serializer.fromJson<String>(json['optionText']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isCorrect: serializer.fromJson<int>(json['isCorrect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionId': serializer.toJson<String>(questionId),
      'optionText': serializer.toJson<String>(optionText),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isCorrect': serializer.toJson<int>(isCorrect),
    };
  }

  QuestionOption copyWith({
    String? id,
    String? questionId,
    String? optionText,
    int? sortOrder,
    int? isCorrect,
  }) => QuestionOption(
    id: id ?? this.id,
    questionId: questionId ?? this.questionId,
    optionText: optionText ?? this.optionText,
    sortOrder: sortOrder ?? this.sortOrder,
    isCorrect: isCorrect ?? this.isCorrect,
  );
  QuestionOption copyWithCompanion(QuestionOptionsCompanion data) {
    return QuestionOption(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      optionText: data.optionText.present
          ? data.optionText.value
          : this.optionText,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionOption(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('optionText: $optionText, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, questionId, optionText, sortOrder, isCorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionOption &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.optionText == this.optionText &&
          other.sortOrder == this.sortOrder &&
          other.isCorrect == this.isCorrect);
}

class QuestionOptionsCompanion extends UpdateCompanion<QuestionOption> {
  final Value<String> id;
  final Value<String> questionId;
  final Value<String> optionText;
  final Value<int> sortOrder;
  final Value<int> isCorrect;
  final Value<int> rowid;
  const QuestionOptionsCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.optionText = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionOptionsCompanion.insert({
    required String id,
    required String questionId,
    required String optionText,
    required int sortOrder,
    required int isCorrect,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       questionId = Value(questionId),
       optionText = Value(optionText),
       sortOrder = Value(sortOrder),
       isCorrect = Value(isCorrect);
  static Insertable<QuestionOption> custom({
    Expression<String>? id,
    Expression<String>? questionId,
    Expression<String>? optionText,
    Expression<int>? sortOrder,
    Expression<int>? isCorrect,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (optionText != null) 'option_text': optionText,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionOptionsCompanion copyWith({
    Value<String>? id,
    Value<String>? questionId,
    Value<String>? optionText,
    Value<int>? sortOrder,
    Value<int>? isCorrect,
    Value<int>? rowid,
  }) {
    return QuestionOptionsCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      optionText: optionText ?? this.optionText,
      sortOrder: sortOrder ?? this.sortOrder,
      isCorrect: isCorrect ?? this.isCorrect,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (optionText.present) {
      map['option_text'] = Variable<String>(optionText.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<int>(isCorrect.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionOptionsCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('optionText: $optionText, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningProgressTable extends LearningProgress
    with TableInfo<$LearningProgressTable, LearningProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studyItemIdMeta = const VerificationMeta(
    'studyItemId',
  );
  @override
  late final GeneratedColumn<String> studyItemId = GeneratedColumn<String>(
    'study_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (status IN (\'new\', \'learning\', \'review\', \'mastered\'))',
  );
  static const VerificationMeta _repetitionCountMeta = const VerificationMeta(
    'repetitionCount',
  );
  @override
  late final GeneratedColumn<int> repetitionCount = GeneratedColumn<int>(
    'repetition_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<double> intervalDays = GeneratedColumn<double>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _easeFactorMeta = const VerificationMeta(
    'easeFactor',
  );
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
    'ease_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
    'lapses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dueAtMsMeta = const VerificationMeta(
    'dueAtMs',
  );
  @override
  late final GeneratedColumn<int> dueAtMs = GeneratedColumn<int>(
    'due_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedAtMsMeta = const VerificationMeta(
    'lastReviewedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastReviewedAtMs = GeneratedColumn<int>(
    'last_reviewed_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCorrectMeta = const VerificationMeta(
    'totalCorrect',
  );
  @override
  late final GeneratedColumn<int> totalCorrect = GeneratedColumn<int>(
    'total_correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalIncorrectMeta = const VerificationMeta(
    'totalIncorrect',
  );
  @override
  late final GeneratedColumn<int> totalIncorrect = GeneratedColumn<int>(
    'total_incorrect',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    studyItemId,
    status,
    repetitionCount,
    intervalDays,
    easeFactor,
    lapses,
    dueAtMs,
    lastReviewedAtMs,
    totalCorrect,
    totalIncorrect,
    isFavorite,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('study_item_id')) {
      context.handle(
        _studyItemIdMeta,
        studyItemId.isAcceptableOrUnknown(
          data['study_item_id']!,
          _studyItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyItemIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('repetition_count')) {
      context.handle(
        _repetitionCountMeta,
        repetitionCount.isAcceptableOrUnknown(
          data['repetition_count']!,
          _repetitionCountMeta,
        ),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
        _easeFactorMeta,
        easeFactor.isAcceptableOrUnknown(data['ease_factor']!, _easeFactorMeta),
      );
    }
    if (data.containsKey('lapses')) {
      context.handle(
        _lapsesMeta,
        lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta),
      );
    }
    if (data.containsKey('due_at_ms')) {
      context.handle(
        _dueAtMsMeta,
        dueAtMs.isAcceptableOrUnknown(data['due_at_ms']!, _dueAtMsMeta),
      );
    }
    if (data.containsKey('last_reviewed_at_ms')) {
      context.handle(
        _lastReviewedAtMsMeta,
        lastReviewedAtMs.isAcceptableOrUnknown(
          data['last_reviewed_at_ms']!,
          _lastReviewedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('total_correct')) {
      context.handle(
        _totalCorrectMeta,
        totalCorrect.isAcceptableOrUnknown(
          data['total_correct']!,
          _totalCorrectMeta,
        ),
      );
    }
    if (data.containsKey('total_incorrect')) {
      context.handle(
        _totalIncorrectMeta,
        totalIncorrect.isAcceptableOrUnknown(
          data['total_incorrect']!,
          _totalIncorrectMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studyItemId};
  @override
  LearningProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningProgressData(
      studyItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_item_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      repetitionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetition_count'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interval_days'],
      )!,
      easeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease_factor'],
      )!,
      lapses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lapses'],
      )!,
      dueAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_at_ms'],
      ),
      lastReviewedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_reviewed_at_ms'],
      ),
      totalCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_correct'],
      )!,
      totalIncorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_incorrect'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_favorite'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $LearningProgressTable createAlias(String alias) {
    return $LearningProgressTable(attachedDatabase, alias);
  }
}

class LearningProgressData extends DataClass
    implements Insertable<LearningProgressData> {
  final String studyItemId;
  final String status;
  final int repetitionCount;
  final double intervalDays;
  final double easeFactor;
  final int lapses;
  final int? dueAtMs;
  final int? lastReviewedAtMs;
  final int totalCorrect;
  final int totalIncorrect;
  final int isFavorite;
  final int updatedAtMs;
  const LearningProgressData({
    required this.studyItemId,
    required this.status,
    required this.repetitionCount,
    required this.intervalDays,
    required this.easeFactor,
    required this.lapses,
    this.dueAtMs,
    this.lastReviewedAtMs,
    required this.totalCorrect,
    required this.totalIncorrect,
    required this.isFavorite,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['study_item_id'] = Variable<String>(studyItemId);
    map['status'] = Variable<String>(status);
    map['repetition_count'] = Variable<int>(repetitionCount);
    map['interval_days'] = Variable<double>(intervalDays);
    map['ease_factor'] = Variable<double>(easeFactor);
    map['lapses'] = Variable<int>(lapses);
    if (!nullToAbsent || dueAtMs != null) {
      map['due_at_ms'] = Variable<int>(dueAtMs);
    }
    if (!nullToAbsent || lastReviewedAtMs != null) {
      map['last_reviewed_at_ms'] = Variable<int>(lastReviewedAtMs);
    }
    map['total_correct'] = Variable<int>(totalCorrect);
    map['total_incorrect'] = Variable<int>(totalIncorrect);
    map['is_favorite'] = Variable<int>(isFavorite);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  LearningProgressCompanion toCompanion(bool nullToAbsent) {
    return LearningProgressCompanion(
      studyItemId: Value(studyItemId),
      status: Value(status),
      repetitionCount: Value(repetitionCount),
      intervalDays: Value(intervalDays),
      easeFactor: Value(easeFactor),
      lapses: Value(lapses),
      dueAtMs: dueAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAtMs),
      lastReviewedAtMs: lastReviewedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAtMs),
      totalCorrect: Value(totalCorrect),
      totalIncorrect: Value(totalIncorrect),
      isFavorite: Value(isFavorite),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory LearningProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningProgressData(
      studyItemId: serializer.fromJson<String>(json['studyItemId']),
      status: serializer.fromJson<String>(json['status']),
      repetitionCount: serializer.fromJson<int>(json['repetitionCount']),
      intervalDays: serializer.fromJson<double>(json['intervalDays']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
      lapses: serializer.fromJson<int>(json['lapses']),
      dueAtMs: serializer.fromJson<int?>(json['dueAtMs']),
      lastReviewedAtMs: serializer.fromJson<int?>(json['lastReviewedAtMs']),
      totalCorrect: serializer.fromJson<int>(json['totalCorrect']),
      totalIncorrect: serializer.fromJson<int>(json['totalIncorrect']),
      isFavorite: serializer.fromJson<int>(json['isFavorite']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studyItemId': serializer.toJson<String>(studyItemId),
      'status': serializer.toJson<String>(status),
      'repetitionCount': serializer.toJson<int>(repetitionCount),
      'intervalDays': serializer.toJson<double>(intervalDays),
      'easeFactor': serializer.toJson<double>(easeFactor),
      'lapses': serializer.toJson<int>(lapses),
      'dueAtMs': serializer.toJson<int?>(dueAtMs),
      'lastReviewedAtMs': serializer.toJson<int?>(lastReviewedAtMs),
      'totalCorrect': serializer.toJson<int>(totalCorrect),
      'totalIncorrect': serializer.toJson<int>(totalIncorrect),
      'isFavorite': serializer.toJson<int>(isFavorite),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  LearningProgressData copyWith({
    String? studyItemId,
    String? status,
    int? repetitionCount,
    double? intervalDays,
    double? easeFactor,
    int? lapses,
    Value<int?> dueAtMs = const Value.absent(),
    Value<int?> lastReviewedAtMs = const Value.absent(),
    int? totalCorrect,
    int? totalIncorrect,
    int? isFavorite,
    int? updatedAtMs,
  }) => LearningProgressData(
    studyItemId: studyItemId ?? this.studyItemId,
    status: status ?? this.status,
    repetitionCount: repetitionCount ?? this.repetitionCount,
    intervalDays: intervalDays ?? this.intervalDays,
    easeFactor: easeFactor ?? this.easeFactor,
    lapses: lapses ?? this.lapses,
    dueAtMs: dueAtMs.present ? dueAtMs.value : this.dueAtMs,
    lastReviewedAtMs: lastReviewedAtMs.present
        ? lastReviewedAtMs.value
        : this.lastReviewedAtMs,
    totalCorrect: totalCorrect ?? this.totalCorrect,
    totalIncorrect: totalIncorrect ?? this.totalIncorrect,
    isFavorite: isFavorite ?? this.isFavorite,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  LearningProgressData copyWithCompanion(LearningProgressCompanion data) {
    return LearningProgressData(
      studyItemId: data.studyItemId.present
          ? data.studyItemId.value
          : this.studyItemId,
      status: data.status.present ? data.status.value : this.status,
      repetitionCount: data.repetitionCount.present
          ? data.repetitionCount.value
          : this.repetitionCount,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      easeFactor: data.easeFactor.present
          ? data.easeFactor.value
          : this.easeFactor,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
      dueAtMs: data.dueAtMs.present ? data.dueAtMs.value : this.dueAtMs,
      lastReviewedAtMs: data.lastReviewedAtMs.present
          ? data.lastReviewedAtMs.value
          : this.lastReviewedAtMs,
      totalCorrect: data.totalCorrect.present
          ? data.totalCorrect.value
          : this.totalCorrect,
      totalIncorrect: data.totalIncorrect.present
          ? data.totalIncorrect.value
          : this.totalIncorrect,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningProgressData(')
          ..write('studyItemId: $studyItemId, ')
          ..write('status: $status, ')
          ..write('repetitionCount: $repetitionCount, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('lapses: $lapses, ')
          ..write('dueAtMs: $dueAtMs, ')
          ..write('lastReviewedAtMs: $lastReviewedAtMs, ')
          ..write('totalCorrect: $totalCorrect, ')
          ..write('totalIncorrect: $totalIncorrect, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    studyItemId,
    status,
    repetitionCount,
    intervalDays,
    easeFactor,
    lapses,
    dueAtMs,
    lastReviewedAtMs,
    totalCorrect,
    totalIncorrect,
    isFavorite,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningProgressData &&
          other.studyItemId == this.studyItemId &&
          other.status == this.status &&
          other.repetitionCount == this.repetitionCount &&
          other.intervalDays == this.intervalDays &&
          other.easeFactor == this.easeFactor &&
          other.lapses == this.lapses &&
          other.dueAtMs == this.dueAtMs &&
          other.lastReviewedAtMs == this.lastReviewedAtMs &&
          other.totalCorrect == this.totalCorrect &&
          other.totalIncorrect == this.totalIncorrect &&
          other.isFavorite == this.isFavorite &&
          other.updatedAtMs == this.updatedAtMs);
}

class LearningProgressCompanion extends UpdateCompanion<LearningProgressData> {
  final Value<String> studyItemId;
  final Value<String> status;
  final Value<int> repetitionCount;
  final Value<double> intervalDays;
  final Value<double> easeFactor;
  final Value<int> lapses;
  final Value<int?> dueAtMs;
  final Value<int?> lastReviewedAtMs;
  final Value<int> totalCorrect;
  final Value<int> totalIncorrect;
  final Value<int> isFavorite;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const LearningProgressCompanion({
    this.studyItemId = const Value.absent(),
    this.status = const Value.absent(),
    this.repetitionCount = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.lapses = const Value.absent(),
    this.dueAtMs = const Value.absent(),
    this.lastReviewedAtMs = const Value.absent(),
    this.totalCorrect = const Value.absent(),
    this.totalIncorrect = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningProgressCompanion.insert({
    required String studyItemId,
    required String status,
    this.repetitionCount = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.lapses = const Value.absent(),
    this.dueAtMs = const Value.absent(),
    this.lastReviewedAtMs = const Value.absent(),
    this.totalCorrect = const Value.absent(),
    this.totalIncorrect = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : studyItemId = Value(studyItemId),
       status = Value(status),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LearningProgressData> custom({
    Expression<String>? studyItemId,
    Expression<String>? status,
    Expression<int>? repetitionCount,
    Expression<double>? intervalDays,
    Expression<double>? easeFactor,
    Expression<int>? lapses,
    Expression<int>? dueAtMs,
    Expression<int>? lastReviewedAtMs,
    Expression<int>? totalCorrect,
    Expression<int>? totalIncorrect,
    Expression<int>? isFavorite,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studyItemId != null) 'study_item_id': studyItemId,
      if (status != null) 'status': status,
      if (repetitionCount != null) 'repetition_count': repetitionCount,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (lapses != null) 'lapses': lapses,
      if (dueAtMs != null) 'due_at_ms': dueAtMs,
      if (lastReviewedAtMs != null) 'last_reviewed_at_ms': lastReviewedAtMs,
      if (totalCorrect != null) 'total_correct': totalCorrect,
      if (totalIncorrect != null) 'total_incorrect': totalIncorrect,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningProgressCompanion copyWith({
    Value<String>? studyItemId,
    Value<String>? status,
    Value<int>? repetitionCount,
    Value<double>? intervalDays,
    Value<double>? easeFactor,
    Value<int>? lapses,
    Value<int?>? dueAtMs,
    Value<int?>? lastReviewedAtMs,
    Value<int>? totalCorrect,
    Value<int>? totalIncorrect,
    Value<int>? isFavorite,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return LearningProgressCompanion(
      studyItemId: studyItemId ?? this.studyItemId,
      status: status ?? this.status,
      repetitionCount: repetitionCount ?? this.repetitionCount,
      intervalDays: intervalDays ?? this.intervalDays,
      easeFactor: easeFactor ?? this.easeFactor,
      lapses: lapses ?? this.lapses,
      dueAtMs: dueAtMs ?? this.dueAtMs,
      lastReviewedAtMs: lastReviewedAtMs ?? this.lastReviewedAtMs,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      totalIncorrect: totalIncorrect ?? this.totalIncorrect,
      isFavorite: isFavorite ?? this.isFavorite,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studyItemId.present) {
      map['study_item_id'] = Variable<String>(studyItemId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (repetitionCount.present) {
      map['repetition_count'] = Variable<int>(repetitionCount.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<double>(intervalDays.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (dueAtMs.present) {
      map['due_at_ms'] = Variable<int>(dueAtMs.value);
    }
    if (lastReviewedAtMs.present) {
      map['last_reviewed_at_ms'] = Variable<int>(lastReviewedAtMs.value);
    }
    if (totalCorrect.present) {
      map['total_correct'] = Variable<int>(totalCorrect.value);
    }
    if (totalIncorrect.present) {
      map['total_incorrect'] = Variable<int>(totalIncorrect.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningProgressCompanion(')
          ..write('studyItemId: $studyItemId, ')
          ..write('status: $status, ')
          ..write('repetitionCount: $repetitionCount, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('lapses: $lapses, ')
          ..write('dueAtMs: $dueAtMs, ')
          ..write('lastReviewedAtMs: $lastReviewedAtMs, ')
          ..write('totalCorrect: $totalCorrect, ')
          ..write('totalIncorrect: $totalIncorrect, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewEventsTable extends ReviewEvents
    with TableInfo<$ReviewEventsTable, ReviewEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyItemIdMeta = const VerificationMeta(
    'studyItemId',
  );
  @override
  late final GeneratedColumn<String> studyItemId = GeneratedColumn<String>(
    'study_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _selectedOptionIdMeta = const VerificationMeta(
    'selectedOptionId',
  );
  @override
  late final GeneratedColumn<String> selectedOptionId = GeneratedColumn<String>(
    'selected_option_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES question_options (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<int> isCorrect = GeneratedColumn<int>(
    'is_correct',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (is_correct IS NULL OR is_correct IN (0, 1))',
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<int> quality = GeneratedColumn<int>(
    'quality',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _elapsedMsMeta = const VerificationMeta(
    'elapsedMs',
  );
  @override
  late final GeneratedColumn<int> elapsedMs = GeneratedColumn<int>(
    'elapsed_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _studyModeMeta = const VerificationMeta(
    'studyMode',
  );
  @override
  late final GeneratedColumn<String> studyMode = GeneratedColumn<String>(
    'study_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answeredAtMsMeta = const VerificationMeta(
    'answeredAtMs',
  );
  @override
  late final GeneratedColumn<int> answeredAtMs = GeneratedColumn<int>(
    'answered_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyItemId,
    questionId,
    selectedOptionId,
    isCorrect,
    quality,
    elapsedMs,
    studyMode,
    answeredAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_item_id')) {
      context.handle(
        _studyItemIdMeta,
        studyItemId.isAcceptableOrUnknown(
          data['study_item_id']!,
          _studyItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyItemIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    }
    if (data.containsKey('selected_option_id')) {
      context.handle(
        _selectedOptionIdMeta,
        selectedOptionId.isAcceptableOrUnknown(
          data['selected_option_id']!,
          _selectedOptionIdMeta,
        ),
      );
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    }
    if (data.containsKey('elapsed_ms')) {
      context.handle(
        _elapsedMsMeta,
        elapsedMs.isAcceptableOrUnknown(data['elapsed_ms']!, _elapsedMsMeta),
      );
    }
    if (data.containsKey('study_mode')) {
      context.handle(
        _studyModeMeta,
        studyMode.isAcceptableOrUnknown(data['study_mode']!, _studyModeMeta),
      );
    } else if (isInserting) {
      context.missing(_studyModeMeta);
    }
    if (data.containsKey('answered_at_ms')) {
      context.handle(
        _answeredAtMsMeta,
        answeredAtMs.isAcceptableOrUnknown(
          data['answered_at_ms']!,
          _answeredAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_item_id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      ),
      selectedOptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_option_id'],
      ),
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_correct'],
      ),
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality'],
      ),
      elapsedMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_ms'],
      ),
      studyMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_mode'],
      )!,
      answeredAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}answered_at_ms'],
      )!,
    );
  }

  @override
  $ReviewEventsTable createAlias(String alias) {
    return $ReviewEventsTable(attachedDatabase, alias);
  }
}

class ReviewEvent extends DataClass implements Insertable<ReviewEvent> {
  final String id;
  final String studyItemId;
  final String? questionId;
  final String? selectedOptionId;
  final int? isCorrect;
  final int? quality;
  final int? elapsedMs;
  final String studyMode;
  final int answeredAtMs;
  const ReviewEvent({
    required this.id,
    required this.studyItemId,
    this.questionId,
    this.selectedOptionId,
    this.isCorrect,
    this.quality,
    this.elapsedMs,
    required this.studyMode,
    required this.answeredAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_item_id'] = Variable<String>(studyItemId);
    if (!nullToAbsent || questionId != null) {
      map['question_id'] = Variable<String>(questionId);
    }
    if (!nullToAbsent || selectedOptionId != null) {
      map['selected_option_id'] = Variable<String>(selectedOptionId);
    }
    if (!nullToAbsent || isCorrect != null) {
      map['is_correct'] = Variable<int>(isCorrect);
    }
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<int>(quality);
    }
    if (!nullToAbsent || elapsedMs != null) {
      map['elapsed_ms'] = Variable<int>(elapsedMs);
    }
    map['study_mode'] = Variable<String>(studyMode);
    map['answered_at_ms'] = Variable<int>(answeredAtMs);
    return map;
  }

  ReviewEventsCompanion toCompanion(bool nullToAbsent) {
    return ReviewEventsCompanion(
      id: Value(id),
      studyItemId: Value(studyItemId),
      questionId: questionId == null && nullToAbsent
          ? const Value.absent()
          : Value(questionId),
      selectedOptionId: selectedOptionId == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedOptionId),
      isCorrect: isCorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(isCorrect),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
      elapsedMs: elapsedMs == null && nullToAbsent
          ? const Value.absent()
          : Value(elapsedMs),
      studyMode: Value(studyMode),
      answeredAtMs: Value(answeredAtMs),
    );
  }

  factory ReviewEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewEvent(
      id: serializer.fromJson<String>(json['id']),
      studyItemId: serializer.fromJson<String>(json['studyItemId']),
      questionId: serializer.fromJson<String?>(json['questionId']),
      selectedOptionId: serializer.fromJson<String?>(json['selectedOptionId']),
      isCorrect: serializer.fromJson<int?>(json['isCorrect']),
      quality: serializer.fromJson<int?>(json['quality']),
      elapsedMs: serializer.fromJson<int?>(json['elapsedMs']),
      studyMode: serializer.fromJson<String>(json['studyMode']),
      answeredAtMs: serializer.fromJson<int>(json['answeredAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyItemId': serializer.toJson<String>(studyItemId),
      'questionId': serializer.toJson<String?>(questionId),
      'selectedOptionId': serializer.toJson<String?>(selectedOptionId),
      'isCorrect': serializer.toJson<int?>(isCorrect),
      'quality': serializer.toJson<int?>(quality),
      'elapsedMs': serializer.toJson<int?>(elapsedMs),
      'studyMode': serializer.toJson<String>(studyMode),
      'answeredAtMs': serializer.toJson<int>(answeredAtMs),
    };
  }

  ReviewEvent copyWith({
    String? id,
    String? studyItemId,
    Value<String?> questionId = const Value.absent(),
    Value<String?> selectedOptionId = const Value.absent(),
    Value<int?> isCorrect = const Value.absent(),
    Value<int?> quality = const Value.absent(),
    Value<int?> elapsedMs = const Value.absent(),
    String? studyMode,
    int? answeredAtMs,
  }) => ReviewEvent(
    id: id ?? this.id,
    studyItemId: studyItemId ?? this.studyItemId,
    questionId: questionId.present ? questionId.value : this.questionId,
    selectedOptionId: selectedOptionId.present
        ? selectedOptionId.value
        : this.selectedOptionId,
    isCorrect: isCorrect.present ? isCorrect.value : this.isCorrect,
    quality: quality.present ? quality.value : this.quality,
    elapsedMs: elapsedMs.present ? elapsedMs.value : this.elapsedMs,
    studyMode: studyMode ?? this.studyMode,
    answeredAtMs: answeredAtMs ?? this.answeredAtMs,
  );
  ReviewEvent copyWithCompanion(ReviewEventsCompanion data) {
    return ReviewEvent(
      id: data.id.present ? data.id.value : this.id,
      studyItemId: data.studyItemId.present
          ? data.studyItemId.value
          : this.studyItemId,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      selectedOptionId: data.selectedOptionId.present
          ? data.selectedOptionId.value
          : this.selectedOptionId,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      quality: data.quality.present ? data.quality.value : this.quality,
      elapsedMs: data.elapsedMs.present ? data.elapsedMs.value : this.elapsedMs,
      studyMode: data.studyMode.present ? data.studyMode.value : this.studyMode,
      answeredAtMs: data.answeredAtMs.present
          ? data.answeredAtMs.value
          : this.answeredAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewEvent(')
          ..write('id: $id, ')
          ..write('studyItemId: $studyItemId, ')
          ..write('questionId: $questionId, ')
          ..write('selectedOptionId: $selectedOptionId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('quality: $quality, ')
          ..write('elapsedMs: $elapsedMs, ')
          ..write('studyMode: $studyMode, ')
          ..write('answeredAtMs: $answeredAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyItemId,
    questionId,
    selectedOptionId,
    isCorrect,
    quality,
    elapsedMs,
    studyMode,
    answeredAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewEvent &&
          other.id == this.id &&
          other.studyItemId == this.studyItemId &&
          other.questionId == this.questionId &&
          other.selectedOptionId == this.selectedOptionId &&
          other.isCorrect == this.isCorrect &&
          other.quality == this.quality &&
          other.elapsedMs == this.elapsedMs &&
          other.studyMode == this.studyMode &&
          other.answeredAtMs == this.answeredAtMs);
}

class ReviewEventsCompanion extends UpdateCompanion<ReviewEvent> {
  final Value<String> id;
  final Value<String> studyItemId;
  final Value<String?> questionId;
  final Value<String?> selectedOptionId;
  final Value<int?> isCorrect;
  final Value<int?> quality;
  final Value<int?> elapsedMs;
  final Value<String> studyMode;
  final Value<int> answeredAtMs;
  final Value<int> rowid;
  const ReviewEventsCompanion({
    this.id = const Value.absent(),
    this.studyItemId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.selectedOptionId = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.quality = const Value.absent(),
    this.elapsedMs = const Value.absent(),
    this.studyMode = const Value.absent(),
    this.answeredAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewEventsCompanion.insert({
    required String id,
    required String studyItemId,
    this.questionId = const Value.absent(),
    this.selectedOptionId = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.quality = const Value.absent(),
    this.elapsedMs = const Value.absent(),
    required String studyMode,
    required int answeredAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyItemId = Value(studyItemId),
       studyMode = Value(studyMode),
       answeredAtMs = Value(answeredAtMs);
  static Insertable<ReviewEvent> custom({
    Expression<String>? id,
    Expression<String>? studyItemId,
    Expression<String>? questionId,
    Expression<String>? selectedOptionId,
    Expression<int>? isCorrect,
    Expression<int>? quality,
    Expression<int>? elapsedMs,
    Expression<String>? studyMode,
    Expression<int>? answeredAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyItemId != null) 'study_item_id': studyItemId,
      if (questionId != null) 'question_id': questionId,
      if (selectedOptionId != null) 'selected_option_id': selectedOptionId,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (quality != null) 'quality': quality,
      if (elapsedMs != null) 'elapsed_ms': elapsedMs,
      if (studyMode != null) 'study_mode': studyMode,
      if (answeredAtMs != null) 'answered_at_ms': answeredAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? studyItemId,
    Value<String?>? questionId,
    Value<String?>? selectedOptionId,
    Value<int?>? isCorrect,
    Value<int?>? quality,
    Value<int?>? elapsedMs,
    Value<String>? studyMode,
    Value<int>? answeredAtMs,
    Value<int>? rowid,
  }) {
    return ReviewEventsCompanion(
      id: id ?? this.id,
      studyItemId: studyItemId ?? this.studyItemId,
      questionId: questionId ?? this.questionId,
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
      isCorrect: isCorrect ?? this.isCorrect,
      quality: quality ?? this.quality,
      elapsedMs: elapsedMs ?? this.elapsedMs,
      studyMode: studyMode ?? this.studyMode,
      answeredAtMs: answeredAtMs ?? this.answeredAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyItemId.present) {
      map['study_item_id'] = Variable<String>(studyItemId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (selectedOptionId.present) {
      map['selected_option_id'] = Variable<String>(selectedOptionId.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<int>(isCorrect.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (elapsedMs.present) {
      map['elapsed_ms'] = Variable<int>(elapsedMs.value);
    }
    if (studyMode.present) {
      map['study_mode'] = Variable<String>(studyMode.value);
    }
    if (answeredAtMs.present) {
      map['answered_at_ms'] = Variable<int>(answeredAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewEventsCompanion(')
          ..write('id: $id, ')
          ..write('studyItemId: $studyItemId, ')
          ..write('questionId: $questionId, ')
          ..write('selectedOptionId: $selectedOptionId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('quality: $quality, ')
          ..write('elapsedMs: $elapsedMs, ')
          ..write('studyMode: $studyMode, ')
          ..write('answeredAtMs: $answeredAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueJsonMeta = const VerificationMeta(
    'valueJson',
  );
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
    'value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, valueJson, updatedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(
        _valueJsonMeta,
        valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      valueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_json'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final String key;
  final String valueJson;
  final int updatedAtMs;
  const UserSetting({
    required this.key,
    required this.valueJson,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      key: Value(key),
      valueJson: Value(valueJson),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory UserSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  UserSetting copyWith({String? key, String? valueJson, int? updatedAtMs}) =>
      UserSetting(
        key: key ?? this.key,
        valueJson: valueJson ?? this.valueJson,
        updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueJson, updatedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.key == this.key &&
          other.valueJson == this.valueJson &&
          other.updatedAtMs == this.updatedAtMs);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<String> key;
  final Value<String> valueJson;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const UserSettingsCompanion({
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    required String key,
    required String valueJson,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       valueJson = Value(valueJson),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<UserSetting> custom({
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? valueJson,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return UserSettingsCompanion(
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationRulesTable extends NotificationRules
    with TableInfo<$NotificationRulesTable, NotificationRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (rule_type IN (\'word\', \'phrase\', \'due_review\', \'quiz\'))',
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<int> enabled = GeneratedColumn<int>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdaysMaskMeta = const VerificationMeta(
    'weekdaysMask',
  );
  @override
  late final GeneratedColumn<int> weekdaysMask = GeneratedColumn<int>(
    'weekdays_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(127),
  );
  static const VerificationMeta _dailyCountMeta = const VerificationMeta(
    'dailyCount',
  );
  @override
  late final GeneratedColumn<int> dailyCount = GeneratedColumn<int>(
    'daily_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _minCefrMeta = const VerificationMeta(
    'minCefr',
  );
  @override
  late final GeneratedColumn<String> minCefr = GeneratedColumn<String>(
    'min_cefr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxCefrMeta = const VerificationMeta(
    'maxCefr',
  );
  @override
  late final GeneratedColumn<String> maxCefr = GeneratedColumn<String>(
    'max_cefr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagFilterIdMeta = const VerificationMeta(
    'tagFilterId',
  );
  @override
  late final GeneratedColumn<String> tagFilterId = GeneratedColumn<String>(
    'tag_filter_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruleType,
    enabled,
    timeOfDay,
    weekdaysMask,
    dailyCount,
    minCefr,
    maxCefr,
    tagFilterId,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    } else if (isInserting) {
      context.missing(_timeOfDayMeta);
    }
    if (data.containsKey('weekdays_mask')) {
      context.handle(
        _weekdaysMaskMeta,
        weekdaysMask.isAcceptableOrUnknown(
          data['weekdays_mask']!,
          _weekdaysMaskMeta,
        ),
      );
    }
    if (data.containsKey('daily_count')) {
      context.handle(
        _dailyCountMeta,
        dailyCount.isAcceptableOrUnknown(data['daily_count']!, _dailyCountMeta),
      );
    }
    if (data.containsKey('min_cefr')) {
      context.handle(
        _minCefrMeta,
        minCefr.isAcceptableOrUnknown(data['min_cefr']!, _minCefrMeta),
      );
    }
    if (data.containsKey('max_cefr')) {
      context.handle(
        _maxCefrMeta,
        maxCefr.isAcceptableOrUnknown(data['max_cefr']!, _maxCefrMeta),
      );
    }
    if (data.containsKey('tag_filter_id')) {
      context.handle(
        _tagFilterIdMeta,
        tagFilterId.isAcceptableOrUnknown(
          data['tag_filter_id']!,
          _tagFilterIdMeta,
        ),
      );
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}enabled'],
      )!,
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      )!,
      weekdaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays_mask'],
      )!,
      dailyCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_count'],
      )!,
      minCefr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}min_cefr'],
      ),
      maxCefr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}max_cefr'],
      ),
      tagFilterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_filter_id'],
      ),
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $NotificationRulesTable createAlias(String alias) {
    return $NotificationRulesTable(attachedDatabase, alias);
  }
}

class NotificationRule extends DataClass
    implements Insertable<NotificationRule> {
  final String id;
  final String ruleType;
  final int enabled;
  final String timeOfDay;
  final int weekdaysMask;
  final int dailyCount;
  final String? minCefr;
  final String? maxCefr;
  final String? tagFilterId;
  final int updatedAtMs;
  const NotificationRule({
    required this.id,
    required this.ruleType,
    required this.enabled,
    required this.timeOfDay,
    required this.weekdaysMask,
    required this.dailyCount,
    this.minCefr,
    this.maxCefr,
    this.tagFilterId,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['rule_type'] = Variable<String>(ruleType);
    map['enabled'] = Variable<int>(enabled);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['weekdays_mask'] = Variable<int>(weekdaysMask);
    map['daily_count'] = Variable<int>(dailyCount);
    if (!nullToAbsent || minCefr != null) {
      map['min_cefr'] = Variable<String>(minCefr);
    }
    if (!nullToAbsent || maxCefr != null) {
      map['max_cefr'] = Variable<String>(maxCefr);
    }
    if (!nullToAbsent || tagFilterId != null) {
      map['tag_filter_id'] = Variable<String>(tagFilterId);
    }
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  NotificationRulesCompanion toCompanion(bool nullToAbsent) {
    return NotificationRulesCompanion(
      id: Value(id),
      ruleType: Value(ruleType),
      enabled: Value(enabled),
      timeOfDay: Value(timeOfDay),
      weekdaysMask: Value(weekdaysMask),
      dailyCount: Value(dailyCount),
      minCefr: minCefr == null && nullToAbsent
          ? const Value.absent()
          : Value(minCefr),
      maxCefr: maxCefr == null && nullToAbsent
          ? const Value.absent()
          : Value(maxCefr),
      tagFilterId: tagFilterId == null && nullToAbsent
          ? const Value.absent()
          : Value(tagFilterId),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory NotificationRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationRule(
      id: serializer.fromJson<String>(json['id']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      enabled: serializer.fromJson<int>(json['enabled']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      weekdaysMask: serializer.fromJson<int>(json['weekdaysMask']),
      dailyCount: serializer.fromJson<int>(json['dailyCount']),
      minCefr: serializer.fromJson<String?>(json['minCefr']),
      maxCefr: serializer.fromJson<String?>(json['maxCefr']),
      tagFilterId: serializer.fromJson<String?>(json['tagFilterId']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ruleType': serializer.toJson<String>(ruleType),
      'enabled': serializer.toJson<int>(enabled),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'weekdaysMask': serializer.toJson<int>(weekdaysMask),
      'dailyCount': serializer.toJson<int>(dailyCount),
      'minCefr': serializer.toJson<String?>(minCefr),
      'maxCefr': serializer.toJson<String?>(maxCefr),
      'tagFilterId': serializer.toJson<String?>(tagFilterId),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  NotificationRule copyWith({
    String? id,
    String? ruleType,
    int? enabled,
    String? timeOfDay,
    int? weekdaysMask,
    int? dailyCount,
    Value<String?> minCefr = const Value.absent(),
    Value<String?> maxCefr = const Value.absent(),
    Value<String?> tagFilterId = const Value.absent(),
    int? updatedAtMs,
  }) => NotificationRule(
    id: id ?? this.id,
    ruleType: ruleType ?? this.ruleType,
    enabled: enabled ?? this.enabled,
    timeOfDay: timeOfDay ?? this.timeOfDay,
    weekdaysMask: weekdaysMask ?? this.weekdaysMask,
    dailyCount: dailyCount ?? this.dailyCount,
    minCefr: minCefr.present ? minCefr.value : this.minCefr,
    maxCefr: maxCefr.present ? maxCefr.value : this.maxCefr,
    tagFilterId: tagFilterId.present ? tagFilterId.value : this.tagFilterId,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  NotificationRule copyWithCompanion(NotificationRulesCompanion data) {
    return NotificationRule(
      id: data.id.present ? data.id.value : this.id,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      weekdaysMask: data.weekdaysMask.present
          ? data.weekdaysMask.value
          : this.weekdaysMask,
      dailyCount: data.dailyCount.present
          ? data.dailyCount.value
          : this.dailyCount,
      minCefr: data.minCefr.present ? data.minCefr.value : this.minCefr,
      maxCefr: data.maxCefr.present ? data.maxCefr.value : this.maxCefr,
      tagFilterId: data.tagFilterId.present
          ? data.tagFilterId.value
          : this.tagFilterId,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationRule(')
          ..write('id: $id, ')
          ..write('ruleType: $ruleType, ')
          ..write('enabled: $enabled, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('dailyCount: $dailyCount, ')
          ..write('minCefr: $minCefr, ')
          ..write('maxCefr: $maxCefr, ')
          ..write('tagFilterId: $tagFilterId, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ruleType,
    enabled,
    timeOfDay,
    weekdaysMask,
    dailyCount,
    minCefr,
    maxCefr,
    tagFilterId,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationRule &&
          other.id == this.id &&
          other.ruleType == this.ruleType &&
          other.enabled == this.enabled &&
          other.timeOfDay == this.timeOfDay &&
          other.weekdaysMask == this.weekdaysMask &&
          other.dailyCount == this.dailyCount &&
          other.minCefr == this.minCefr &&
          other.maxCefr == this.maxCefr &&
          other.tagFilterId == this.tagFilterId &&
          other.updatedAtMs == this.updatedAtMs);
}

class NotificationRulesCompanion extends UpdateCompanion<NotificationRule> {
  final Value<String> id;
  final Value<String> ruleType;
  final Value<int> enabled;
  final Value<String> timeOfDay;
  final Value<int> weekdaysMask;
  final Value<int> dailyCount;
  final Value<String?> minCefr;
  final Value<String?> maxCefr;
  final Value<String?> tagFilterId;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const NotificationRulesCompanion({
    this.id = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.enabled = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    this.dailyCount = const Value.absent(),
    this.minCefr = const Value.absent(),
    this.maxCefr = const Value.absent(),
    this.tagFilterId = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationRulesCompanion.insert({
    required String id,
    required String ruleType,
    this.enabled = const Value.absent(),
    required String timeOfDay,
    this.weekdaysMask = const Value.absent(),
    this.dailyCount = const Value.absent(),
    this.minCefr = const Value.absent(),
    this.maxCefr = const Value.absent(),
    this.tagFilterId = const Value.absent(),
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ruleType = Value(ruleType),
       timeOfDay = Value(timeOfDay),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<NotificationRule> custom({
    Expression<String>? id,
    Expression<String>? ruleType,
    Expression<int>? enabled,
    Expression<String>? timeOfDay,
    Expression<int>? weekdaysMask,
    Expression<int>? dailyCount,
    Expression<String>? minCefr,
    Expression<String>? maxCefr,
    Expression<String>? tagFilterId,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleType != null) 'rule_type': ruleType,
      if (enabled != null) 'enabled': enabled,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (weekdaysMask != null) 'weekdays_mask': weekdaysMask,
      if (dailyCount != null) 'daily_count': dailyCount,
      if (minCefr != null) 'min_cefr': minCefr,
      if (maxCefr != null) 'max_cefr': maxCefr,
      if (tagFilterId != null) 'tag_filter_id': tagFilterId,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? ruleType,
    Value<int>? enabled,
    Value<String>? timeOfDay,
    Value<int>? weekdaysMask,
    Value<int>? dailyCount,
    Value<String?>? minCefr,
    Value<String?>? maxCefr,
    Value<String?>? tagFilterId,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return NotificationRulesCompanion(
      id: id ?? this.id,
      ruleType: ruleType ?? this.ruleType,
      enabled: enabled ?? this.enabled,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      weekdaysMask: weekdaysMask ?? this.weekdaysMask,
      dailyCount: dailyCount ?? this.dailyCount,
      minCefr: minCefr ?? this.minCefr,
      maxCefr: maxCefr ?? this.maxCefr,
      tagFilterId: tagFilterId ?? this.tagFilterId,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<int>(enabled.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (weekdaysMask.present) {
      map['weekdays_mask'] = Variable<int>(weekdaysMask.value);
    }
    if (dailyCount.present) {
      map['daily_count'] = Variable<int>(dailyCount.value);
    }
    if (minCefr.present) {
      map['min_cefr'] = Variable<String>(minCefr.value);
    }
    if (maxCefr.present) {
      map['max_cefr'] = Variable<String>(maxCefr.value);
    }
    if (tagFilterId.present) {
      map['tag_filter_id'] = Variable<String>(tagFilterId.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationRulesCompanion(')
          ..write('id: $id, ')
          ..write('ruleType: $ruleType, ')
          ..write('enabled: $enabled, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('dailyCount: $dailyCount, ')
          ..write('minCefr: $minCefr, ')
          ..write('maxCefr: $maxCefr, ')
          ..write('tagFilterId: $tagFilterId, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HeadwordsTable headwords = $HeadwordsTable(this);
  late final $StudyItemsTable studyItems = $StudyItemsTable(this);
  late final $SensesTable senses = $SensesTable(this);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  late final $PhraseSensesTable phraseSenses = $PhraseSensesTable(this);
  late final $PronunciationsTable pronunciations = $PronunciationsTable(this);
  late final $InflectionsTable inflections = $InflectionsTable(this);
  late final $ContentSourcesTable contentSources = $ContentSourcesTable(this);
  late final $SourceAttributionsTable sourceAttributions =
      $SourceAttributionsTable(this);
  late final $ExamplesTable examples = $ExamplesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $ItemTagsTable itemTags = $ItemTagsTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $QuestionOptionsTable questionOptions = $QuestionOptionsTable(
    this,
  );
  late final $LearningProgressTable learningProgress = $LearningProgressTable(
    this,
  );
  late final $ReviewEventsTable reviewEvents = $ReviewEventsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $NotificationRulesTable notificationRules =
      $NotificationRulesTable(this);
  late final Index idxHeadwordsNormalized = Index(
    'idx_headwords_normalized',
    'CREATE INDEX idx_headwords_normalized ON headwords (normalized_spelling)',
  );
  late final Index idxSensesHeadword = Index(
    'idx_senses_headword',
    'CREATE INDEX idx_senses_headword ON senses (headword_id)',
  );
  late final Index idxSensesCefr = Index(
    'idx_senses_cefr',
    'CREATE INDEX idx_senses_cefr ON senses (cefr_level)',
  );
  late final Index idxSensesPos = Index(
    'idx_senses_pos',
    'CREATE INDEX idx_senses_pos ON senses (part_of_speech)',
  );
  late final Index idxPhrasesNormalized = Index(
    'idx_phrases_normalized',
    'CREATE INDEX idx_phrases_normalized ON phrases (normalized_phrase)',
  );
  late final Index idxPhraseSensesPhrase = Index(
    'idx_phrase_senses_phrase',
    'CREATE INDEX idx_phrase_senses_phrase ON phrase_senses (phrase_id)',
  );
  late final Index idxPhraseSensesCefr = Index(
    'idx_phrase_senses_cefr',
    'CREATE INDEX idx_phrase_senses_cefr ON phrase_senses (cefr_level)',
  );
  late final Index idxExamplesStudyItem = Index(
    'idx_examples_study_item',
    'CREATE INDEX idx_examples_study_item ON examples (study_item_id)',
  );
  late final Index idxItemTagsTag = Index(
    'idx_item_tags_tag',
    'CREATE INDEX idx_item_tags_tag ON item_tags (tag_id)',
  );
  late final Index idxItemTagsItem = Index(
    'idx_item_tags_item',
    'CREATE INDEX idx_item_tags_item ON item_tags (study_item_id)',
  );
  late final Index idxQuestionsTarget = Index(
    'idx_questions_target',
    'CREATE INDEX idx_questions_target ON questions (target_item_id)',
  );
  late final Index idxQuestionOptionsQ = Index(
    'idx_question_options_q',
    'CREATE INDEX idx_question_options_q ON question_options (question_id)',
  );
  late final Index idxProgressDue = Index(
    'idx_progress_due',
    'CREATE INDEX idx_progress_due ON learning_progress (due_at_ms)',
  );
  late final Index idxReviewsItem = Index(
    'idx_reviews_item',
    'CREATE INDEX idx_reviews_item ON review_events (study_item_id)',
  );
  late final Index idxReviewsAnswered = Index(
    'idx_reviews_answered',
    'CREATE INDEX idx_reviews_answered ON review_events (answered_at_ms)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    headwords,
    studyItems,
    senses,
    phrases,
    phraseSenses,
    pronunciations,
    inflections,
    contentSources,
    sourceAttributions,
    examples,
    tags,
    itemTags,
    questions,
    questionOptions,
    learningProgress,
    reviewEvents,
    userSettings,
    notificationRules,
    idxHeadwordsNormalized,
    idxSensesHeadword,
    idxSensesCefr,
    idxSensesPos,
    idxPhrasesNormalized,
    idxPhraseSensesPhrase,
    idxPhraseSensesCefr,
    idxExamplesStudyItem,
    idxItemTagsTag,
    idxItemTagsItem,
    idxQuestionsTarget,
    idxQuestionOptionsQ,
    idxProgressDue,
    idxReviewsItem,
    idxReviewsAnswered,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('senses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'headwords',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('senses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('phrase_senses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'phrases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('phrase_senses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'headwords',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pronunciations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pronunciations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'headwords',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('inflections', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'content_sources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('source_attributions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('examples', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'content_sources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('examples', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('item_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('item_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('questions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('question_options', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('learning_progress', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'question_options',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notification_rules', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$HeadwordsTableCreateCompanionBuilder = HeadwordsCompanion Function({
  required String id,
  required String spelling,
  required String normalizedSpelling,
  Value<int> homographNo,
  Value<String?> cefrLevel,
  Value<String?> notes,
  Value<int> isArchived,
  required int createdAtMs,
  required int updatedAtMs,
  Value<int> rowid,
});
typedef $$HeadwordsTableUpdateCompanionBuilder = HeadwordsCompanion Function({
  Value<String> id,
  Value<String> spelling,
  Value<String> normalizedSpelling,
  Value<int> homographNo,
  Value<String?> cefrLevel,
  Value<String?> notes,
  Value<int> isArchived,
  Value<int> createdAtMs,
  Value<int> updatedAtMs,
  Value<int> rowid,
});

final class $$HeadwordsTableReferences
    extends BaseReferences<_$AppDatabase, $HeadwordsTable, Headword> {
  $$HeadwordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SensesTable, List<Sense>> _sensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.senses,
    aliasName: 'headwords__id__senses__headword_id',
  );

  $$SensesTableProcessedTableManager get sensesRefs {
    final manager = $$SensesTableTableManager(
      $_db,
      $_db.senses,
    ).filter((f) => f.headwordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PronunciationsTable, List<Pronunciation>>
  _pronunciationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pronunciations,
    aliasName: 'headwords__id__pronunciations__headword_id',
  );

  $$PronunciationsTableProcessedTableManager get pronunciationsRefs {
    final manager = $$PronunciationsTableTableManager(
      $_db,
      $_db.pronunciations,
    ).filter((f) => f.headwordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pronunciationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InflectionsTable, List<Inflection>>
  _inflectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inflections,
    aliasName: 'headwords__id__inflections__headword_id',
  );

  $$InflectionsTableProcessedTableManager get inflectionsRefs {
    final manager = $$InflectionsTableTableManager(
      $_db,
      $_db.inflections,
    ).filter((f) => f.headwordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inflectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HeadwordsTableFilterComposer
    extends Composer<_$AppDatabase, $HeadwordsTable> {
  $$HeadwordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spelling => $composableBuilder(
    column: $table.spelling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedSpelling => $composableBuilder(
    column: $table.normalizedSpelling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get homographNo => $composableBuilder(
    column: $table.homographNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sensesRefs(
    Expression<bool> Function($$SensesTableFilterComposer f) f,
  ) {
    final $$SensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.senses,
      getReferencedColumn: (t) => t.headwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensesTableFilterComposer(
            $db: $db,
            $table: $db.senses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pronunciationsRefs(
    Expression<bool> Function($$PronunciationsTableFilterComposer f) f,
  ) {
    final $$PronunciationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pronunciations,
      getReferencedColumn: (t) => t.headwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PronunciationsTableFilterComposer(
            $db: $db,
            $table: $db.pronunciations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inflectionsRefs(
    Expression<bool> Function($$InflectionsTableFilterComposer f) f,
  ) {
    final $$InflectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inflections,
      getReferencedColumn: (t) => t.headwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InflectionsTableFilterComposer(
            $db: $db,
            $table: $db.inflections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HeadwordsTableOrderingComposer
    extends Composer<_$AppDatabase, $HeadwordsTable> {
  $$HeadwordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spelling => $composableBuilder(
    column: $table.spelling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedSpelling => $composableBuilder(
    column: $table.normalizedSpelling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get homographNo => $composableBuilder(
    column: $table.homographNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HeadwordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HeadwordsTable> {
  $$HeadwordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get spelling =>
      $composableBuilder(column: $table.spelling, builder: (column) => column);

  GeneratedColumn<String> get normalizedSpelling => $composableBuilder(
    column: $table.normalizedSpelling,
    builder: (column) => column,
  );

  GeneratedColumn<int> get homographNo => $composableBuilder(
    column: $table.homographNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  Expression<T> sensesRefs<T extends Object>(
    Expression<T> Function($$SensesTableAnnotationComposer a) f,
  ) {
    final $$SensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.senses,
      getReferencedColumn: (t) => t.headwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensesTableAnnotationComposer(
            $db: $db,
            $table: $db.senses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pronunciationsRefs<T extends Object>(
    Expression<T> Function($$PronunciationsTableAnnotationComposer a) f,
  ) {
    final $$PronunciationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pronunciations,
      getReferencedColumn: (t) => t.headwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PronunciationsTableAnnotationComposer(
            $db: $db,
            $table: $db.pronunciations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inflectionsRefs<T extends Object>(
    Expression<T> Function($$InflectionsTableAnnotationComposer a) f,
  ) {
    final $$InflectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inflections,
      getReferencedColumn: (t) => t.headwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InflectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.inflections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HeadwordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HeadwordsTable,
          Headword,
          $$HeadwordsTableFilterComposer,
          $$HeadwordsTableOrderingComposer,
          $$HeadwordsTableAnnotationComposer,
          $$HeadwordsTableCreateCompanionBuilder,
          $$HeadwordsTableUpdateCompanionBuilder,
          (Headword, $$HeadwordsTableReferences),
          Headword,
          PrefetchHooks Function({
            bool sensesRefs,
            bool pronunciationsRefs,
            bool inflectionsRefs,
          })
        > {
  $$HeadwordsTableTableManager(_$AppDatabase db, $HeadwordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HeadwordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HeadwordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HeadwordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> spelling = const Value.absent(),
                Value<String> normalizedSpelling = const Value.absent(),
                Value<int> homographNo = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> isArchived = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HeadwordsCompanion(
                id: id,
                spelling: spelling,
                normalizedSpelling: normalizedSpelling,
                homographNo: homographNo,
                cefrLevel: cefrLevel,
                notes: notes,
                isArchived: isArchived,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String spelling,
                required String normalizedSpelling,
                Value<int> homographNo = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> isArchived = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => HeadwordsCompanion.insert(
                id: id,
                spelling: spelling,
                normalizedSpelling: normalizedSpelling,
                homographNo: homographNo,
                cefrLevel: cefrLevel,
                notes: notes,
                isArchived: isArchived,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HeadwordsTable, Headword>(table),
                  $$HeadwordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sensesRefs = false,
                pronunciationsRefs = false,
                inflectionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sensesRefs) db.senses,
                    if (pronunciationsRefs) db.pronunciations,
                    if (inflectionsRefs) db.inflections,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sensesRefs)
                        await $_getPrefetchedData<
                          Headword,
                          $HeadwordsTable,
                          Sense
                        >(
                          currentTable: table,
                          referencedTable: $$HeadwordsTableReferences
                              ._sensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HeadwordsTableReferences(
                                db,
                                table,
                                p0,
                              ).sensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.headwordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pronunciationsRefs)
                        await $_getPrefetchedData<
                          Headword,
                          $HeadwordsTable,
                          Pronunciation
                        >(
                          currentTable: table,
                          referencedTable: $$HeadwordsTableReferences
                              ._pronunciationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HeadwordsTableReferences(
                                db,
                                table,
                                p0,
                              ).pronunciationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.headwordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inflectionsRefs)
                        await $_getPrefetchedData<
                          Headword,
                          $HeadwordsTable,
                          Inflection
                        >(
                          currentTable: table,
                          referencedTable: $$HeadwordsTableReferences
                              ._inflectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HeadwordsTableReferences(
                                db,
                                table,
                                p0,
                              ).inflectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.headwordId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HeadwordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HeadwordsTable,
      Headword,
      $$HeadwordsTableFilterComposer,
      $$HeadwordsTableOrderingComposer,
      $$HeadwordsTableAnnotationComposer,
      $$HeadwordsTableCreateCompanionBuilder,
      $$HeadwordsTableUpdateCompanionBuilder,
      (Headword, $$HeadwordsTableReferences),
      Headword,
      PrefetchHooks Function({
        bool sensesRefs,
        bool pronunciationsRefs,
        bool inflectionsRefs,
      })
    >;
typedef $$StudyItemsTableCreateCompanionBuilder = StudyItemsCompanion Function({
  required String id,
  required String itemType,
  required int createdAtMs,
  Value<int> rowid,
});
typedef $$StudyItemsTableUpdateCompanionBuilder = StudyItemsCompanion Function({
  Value<String> id,
  Value<String> itemType,
  Value<int> createdAtMs,
  Value<int> rowid,
});

final class $$StudyItemsTableReferences
    extends BaseReferences<_$AppDatabase, $StudyItemsTable, StudyItem> {
  $$StudyItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SensesTable, List<Sense>> _sensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.senses,
    aliasName: 'study_items__id__senses__id',
  );

  $$SensesTableProcessedTableManager get sensesRefs {
    final manager = $$SensesTableTableManager(
      $_db,
      $_db.senses,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhraseSensesTable, List<PhraseSense>>
  _phraseSensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phraseSenses,
    aliasName: 'study_items__id__phrase_senses__id',
  );

  $$PhraseSensesTableProcessedTableManager get phraseSensesRefs {
    final manager = $$PhraseSensesTableTableManager(
      $_db,
      $_db.phraseSenses,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_phraseSensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PronunciationsTable, List<Pronunciation>>
  _pronunciationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pronunciations,
    aliasName: 'study_items__id__pronunciations__sense_id',
  );

  $$PronunciationsTableProcessedTableManager get pronunciationsRefs {
    final manager = $$PronunciationsTableTableManager(
      $_db,
      $_db.pronunciations,
    ).filter((f) => f.senseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pronunciationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamplesTable, List<Example>> _examplesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.examples,
    aliasName: 'study_items__id__examples__study_item_id',
  );

  $$ExamplesTableProcessedTableManager get examplesRefs {
    final manager = $$ExamplesTableTableManager(
      $_db,
      $_db.examples,
    ).filter((f) => f.studyItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examplesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ItemTagsTable, List<ItemTag>> _itemTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.itemTags,
    aliasName: 'study_items__id__item_tags__study_item_id',
  );

  $$ItemTagsTableProcessedTableManager get itemTagsRefs {
    final manager = $$ItemTagsTableTableManager(
      $_db,
      $_db.itemTags,
    ).filter((f) => f.studyItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionsTable, List<Question>>
  _questionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questions,
    aliasName: 'study_items__id__questions__target_item_id',
  );

  $$QuestionsTableProcessedTableManager get questionsRefs {
    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.targetItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LearningProgressTable, List<LearningProgressData>>
  _learningProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.learningProgress,
    aliasName: 'study_items__id__learning_progress__study_item_id',
  );

  $$LearningProgressTableProcessedTableManager get learningProgressRefs {
    final manager = $$LearningProgressTableTableManager(
      $_db,
      $_db.learningProgress,
    ).filter((f) => f.studyItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewEventsTable, List<ReviewEvent>>
  _reviewEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewEvents,
    aliasName: 'study_items__id__review_events__study_item_id',
  );

  $$ReviewEventsTableProcessedTableManager get reviewEventsRefs {
    final manager = $$ReviewEventsTableTableManager(
      $_db,
      $_db.reviewEvents,
    ).filter((f) => f.studyItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudyItemsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyItemsTable> {
  $$StudyItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sensesRefs(
    Expression<bool> Function($$SensesTableFilterComposer f) f,
  ) {
    final $$SensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.senses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensesTableFilterComposer(
            $db: $db,
            $table: $db.senses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phraseSensesRefs(
    Expression<bool> Function($$PhraseSensesTableFilterComposer f) f,
  ) {
    final $$PhraseSensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phraseSenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhraseSensesTableFilterComposer(
            $db: $db,
            $table: $db.phraseSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pronunciationsRefs(
    Expression<bool> Function($$PronunciationsTableFilterComposer f) f,
  ) {
    final $$PronunciationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pronunciations,
      getReferencedColumn: (t) => t.senseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PronunciationsTableFilterComposer(
            $db: $db,
            $table: $db.pronunciations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examplesRefs(
    Expression<bool> Function($$ExamplesTableFilterComposer f) f,
  ) {
    final $$ExamplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examples,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamplesTableFilterComposer(
            $db: $db,
            $table: $db.examples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itemTagsRefs(
    Expression<bool> Function($$ItemTagsTableFilterComposer f) f,
  ) {
    final $$ItemTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemTags,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemTagsTableFilterComposer(
            $db: $db,
            $table: $db.itemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionsRefs(
    Expression<bool> Function($$QuestionsTableFilterComposer f) f,
  ) {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.targetItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> learningProgressRefs(
    Expression<bool> Function($$LearningProgressTableFilterComposer f) f,
  ) {
    final $$LearningProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningProgress,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningProgressTableFilterComposer(
            $db: $db,
            $table: $db.learningProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewEventsRefs(
    Expression<bool> Function($$ReviewEventsTableFilterComposer f) f,
  ) {
    final $$ReviewEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableFilterComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyItemsTable> {
  $$StudyItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyItemsTable> {
  $$StudyItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  Expression<T> sensesRefs<T extends Object>(
    Expression<T> Function($$SensesTableAnnotationComposer a) f,
  ) {
    final $$SensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.senses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensesTableAnnotationComposer(
            $db: $db,
            $table: $db.senses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phraseSensesRefs<T extends Object>(
    Expression<T> Function($$PhraseSensesTableAnnotationComposer a) f,
  ) {
    final $$PhraseSensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phraseSenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhraseSensesTableAnnotationComposer(
            $db: $db,
            $table: $db.phraseSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pronunciationsRefs<T extends Object>(
    Expression<T> Function($$PronunciationsTableAnnotationComposer a) f,
  ) {
    final $$PronunciationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pronunciations,
      getReferencedColumn: (t) => t.senseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PronunciationsTableAnnotationComposer(
            $db: $db,
            $table: $db.pronunciations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> examplesRefs<T extends Object>(
    Expression<T> Function($$ExamplesTableAnnotationComposer a) f,
  ) {
    final $$ExamplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examples,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamplesTableAnnotationComposer(
            $db: $db,
            $table: $db.examples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> itemTagsRefs<T extends Object>(
    Expression<T> Function($$ItemTagsTableAnnotationComposer a) f,
  ) {
    final $$ItemTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemTags,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.itemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionsRefs<T extends Object>(
    Expression<T> Function($$QuestionsTableAnnotationComposer a) f,
  ) {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.targetItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> learningProgressRefs<T extends Object>(
    Expression<T> Function($$LearningProgressTableAnnotationComposer a) f,
  ) {
    final $$LearningProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningProgress,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.learningProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewEventsRefs<T extends Object>(
    Expression<T> Function($$ReviewEventsTableAnnotationComposer a) f,
  ) {
    final $$ReviewEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.studyItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyItemsTable,
          StudyItem,
          $$StudyItemsTableFilterComposer,
          $$StudyItemsTableOrderingComposer,
          $$StudyItemsTableAnnotationComposer,
          $$StudyItemsTableCreateCompanionBuilder,
          $$StudyItemsTableUpdateCompanionBuilder,
          (StudyItem, $$StudyItemsTableReferences),
          StudyItem,
          PrefetchHooks Function({
            bool sensesRefs,
            bool phraseSensesRefs,
            bool pronunciationsRefs,
            bool examplesRefs,
            bool itemTagsRefs,
            bool questionsRefs,
            bool learningProgressRefs,
            bool reviewEventsRefs,
          })
        > {
  $$StudyItemsTableTableManager(_$AppDatabase db, $StudyItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyItemsCompanion(
                id: id,
                itemType: itemType,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemType,
                required int createdAtMs,
                Value<int> rowid = const Value.absent(),
              }) => StudyItemsCompanion.insert(
                id: id,
                itemType: itemType,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyItemsTable, StudyItem>(table),
                  $$StudyItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sensesRefs = false,
                phraseSensesRefs = false,
                pronunciationsRefs = false,
                examplesRefs = false,
                itemTagsRefs = false,
                questionsRefs = false,
                learningProgressRefs = false,
                reviewEventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sensesRefs) db.senses,
                    if (phraseSensesRefs) db.phraseSenses,
                    if (pronunciationsRefs) db.pronunciations,
                    if (examplesRefs) db.examples,
                    if (itemTagsRefs) db.itemTags,
                    if (questionsRefs) db.questions,
                    if (learningProgressRefs) db.learningProgress,
                    if (reviewEventsRefs) db.reviewEvents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sensesRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          Sense
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._sensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).sensesRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (phraseSensesRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          PhraseSense
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._phraseSensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).phraseSensesRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (pronunciationsRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          Pronunciation
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._pronunciationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).pronunciationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.senseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (examplesRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          Example
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._examplesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).examplesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (itemTagsRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          ItemTag
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._itemTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).itemTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionsRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          Question
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._questionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.targetItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (learningProgressRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          LearningProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._learningProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).learningProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reviewEventsRefs)
                        await $_getPrefetchedData<
                          StudyItem,
                          $StudyItemsTable,
                          ReviewEvent
                        >(
                          currentTable: table,
                          referencedTable: $$StudyItemsTableReferences
                              ._reviewEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudyItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyItemsTable,
      StudyItem,
      $$StudyItemsTableFilterComposer,
      $$StudyItemsTableOrderingComposer,
      $$StudyItemsTableAnnotationComposer,
      $$StudyItemsTableCreateCompanionBuilder,
      $$StudyItemsTableUpdateCompanionBuilder,
      (StudyItem, $$StudyItemsTableReferences),
      StudyItem,
      PrefetchHooks Function({
        bool sensesRefs,
        bool phraseSensesRefs,
        bool pronunciationsRefs,
        bool examplesRefs,
        bool itemTagsRefs,
        bool questionsRefs,
        bool learningProgressRefs,
        bool reviewEventsRefs,
      })
    >;
typedef $$SensesTableCreateCompanionBuilder = SensesCompanion Function({
  required String id,
  required String headwordId,
  required int senseNumber,
  required String partOfSpeech,
  required String definitionEn,
  Value<String?> meaningVi,
  Value<String?> cefrLevel,
  Value<String?> registerLabel,
  Value<String?> domainLabel,
  Value<String?> grammarNote,
  Value<String?> usageNote,
  Value<int> isActive,
  Value<int> rowid,
});
typedef $$SensesTableUpdateCompanionBuilder = SensesCompanion Function({
  Value<String> id,
  Value<String> headwordId,
  Value<int> senseNumber,
  Value<String> partOfSpeech,
  Value<String> definitionEn,
  Value<String?> meaningVi,
  Value<String?> cefrLevel,
  Value<String?> registerLabel,
  Value<String?> domainLabel,
  Value<String?> grammarNote,
  Value<String?> usageNote,
  Value<int> isActive,
  Value<int> rowid,
});

final class $$SensesTableReferences
    extends BaseReferences<_$AppDatabase, $SensesTable, Sense> {
  $$SensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyItemsTable _idTable(_$AppDatabase db) =>
      db.studyItems.createAlias('senses__id__study_items__id');

  $$StudyItemsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HeadwordsTable _headwordIdTable(_$AppDatabase db) =>
      db.headwords.createAlias('senses__headword_id__headwords__id');

  $$HeadwordsTableProcessedTableManager get headwordId {
    final $_column = $_itemColumn<String>('headword_id')!;

    final manager = $$HeadwordsTableTableManager(
      $_db,
      $_db.headwords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_headwordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SensesTableFilterComposer
    extends Composer<_$AppDatabase, $SensesTable> {
  $$SensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get senseNumber => $composableBuilder(
    column: $table.senseNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaningVi => $composableBuilder(
    column: $table.meaningVi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registerLabel => $composableBuilder(
    column: $table.registerLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get domainLabel => $composableBuilder(
    column: $table.domainLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usageNote => $composableBuilder(
    column: $table.usageNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyItemsTableFilterComposer get id {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HeadwordsTableFilterComposer get headwordId {
    final $$HeadwordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableFilterComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensesTableOrderingComposer
    extends Composer<_$AppDatabase, $SensesTable> {
  $$SensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get senseNumber => $composableBuilder(
    column: $table.senseNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaningVi => $composableBuilder(
    column: $table.meaningVi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registerLabel => $composableBuilder(
    column: $table.registerLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domainLabel => $composableBuilder(
    column: $table.domainLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usageNote => $composableBuilder(
    column: $table.usageNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyItemsTableOrderingComposer get id {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HeadwordsTableOrderingComposer get headwordId {
    final $$HeadwordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableOrderingComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SensesTable> {
  $$SensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get senseNumber => $composableBuilder(
    column: $table.senseNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meaningVi =>
      $composableBuilder(column: $table.meaningVi, builder: (column) => column);

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get registerLabel => $composableBuilder(
    column: $table.registerLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get domainLabel => $composableBuilder(
    column: $table.domainLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usageNote =>
      $composableBuilder(column: $table.usageNote, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$StudyItemsTableAnnotationComposer get id {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HeadwordsTableAnnotationComposer get headwordId {
    final $$HeadwordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableAnnotationComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SensesTable,
          Sense,
          $$SensesTableFilterComposer,
          $$SensesTableOrderingComposer,
          $$SensesTableAnnotationComposer,
          $$SensesTableCreateCompanionBuilder,
          $$SensesTableUpdateCompanionBuilder,
          (Sense, $$SensesTableReferences),
          Sense,
          PrefetchHooks Function({bool id, bool headwordId})
        > {
  $$SensesTableTableManager(_$AppDatabase db, $SensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> headwordId = const Value.absent(),
                Value<int> senseNumber = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String> definitionEn = const Value.absent(),
                Value<String?> meaningVi = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> registerLabel = const Value.absent(),
                Value<String?> domainLabel = const Value.absent(),
                Value<String?> grammarNote = const Value.absent(),
                Value<String?> usageNote = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SensesCompanion(
                id: id,
                headwordId: headwordId,
                senseNumber: senseNumber,
                partOfSpeech: partOfSpeech,
                definitionEn: definitionEn,
                meaningVi: meaningVi,
                cefrLevel: cefrLevel,
                registerLabel: registerLabel,
                domainLabel: domainLabel,
                grammarNote: grammarNote,
                usageNote: usageNote,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String headwordId,
                required int senseNumber,
                required String partOfSpeech,
                required String definitionEn,
                Value<String?> meaningVi = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> registerLabel = const Value.absent(),
                Value<String?> domainLabel = const Value.absent(),
                Value<String?> grammarNote = const Value.absent(),
                Value<String?> usageNote = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SensesCompanion.insert(
                id: id,
                headwordId: headwordId,
                senseNumber: senseNumber,
                partOfSpeech: partOfSpeech,
                definitionEn: definitionEn,
                meaningVi: meaningVi,
                cefrLevel: cefrLevel,
                registerLabel: registerLabel,
                domainLabel: domainLabel,
                grammarNote: grammarNote,
                usageNote: usageNote,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SensesTable, Sense>(table),
                  $$SensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false, headwordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.id,
                        referencedTable: $$SensesTableReferences._idTable(db),
                        referencedColumn: $$SensesTableReferences
                            ._idTable(db)
                            .id,
                      ) as T;
                    }
                    if (headwordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.headwordId,
                        referencedTable: $$SensesTableReferences
                            ._headwordIdTable(db),
                        referencedColumn: $$SensesTableReferences
                            ._headwordIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SensesTable,
      Sense,
      $$SensesTableFilterComposer,
      $$SensesTableOrderingComposer,
      $$SensesTableAnnotationComposer,
      $$SensesTableCreateCompanionBuilder,
      $$SensesTableUpdateCompanionBuilder,
      (Sense, $$SensesTableReferences),
      Sense,
      PrefetchHooks Function({bool id, bool headwordId})
    >;
typedef $$PhrasesTableCreateCompanionBuilder = PhrasesCompanion Function({
  required String id,
  required String phrase,
  required String normalizedPhrase,
  required String phraseType,
  Value<String?> cefrLevel,
  Value<String?> notes,
  Value<int> isArchived,
  required int createdAtMs,
  required int updatedAtMs,
  Value<int> rowid,
});
typedef $$PhrasesTableUpdateCompanionBuilder = PhrasesCompanion Function({
  Value<String> id,
  Value<String> phrase,
  Value<String> normalizedPhrase,
  Value<String> phraseType,
  Value<String?> cefrLevel,
  Value<String?> notes,
  Value<int> isArchived,
  Value<int> createdAtMs,
  Value<int> updatedAtMs,
  Value<int> rowid,
});

final class $$PhrasesTableReferences
    extends BaseReferences<_$AppDatabase, $PhrasesTable, Phrase> {
  $$PhrasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PhraseSensesTable, List<PhraseSense>>
  _phraseSensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phraseSenses,
    aliasName: 'phrases__id__phrase_senses__phrase_id',
  );

  $$PhraseSensesTableProcessedTableManager get phraseSensesRefs {
    final manager = $$PhraseSensesTableTableManager(
      $_db,
      $_db.phraseSenses,
    ).filter((f) => f.phraseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_phraseSensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PhrasesTableFilterComposer
    extends Composer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phrase => $composableBuilder(
    column: $table.phrase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedPhrase => $composableBuilder(
    column: $table.normalizedPhrase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phraseType => $composableBuilder(
    column: $table.phraseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> phraseSensesRefs(
    Expression<bool> Function($$PhraseSensesTableFilterComposer f) f,
  ) {
    final $$PhraseSensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phraseSenses,
      getReferencedColumn: (t) => t.phraseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhraseSensesTableFilterComposer(
            $db: $db,
            $table: $db.phraseSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PhrasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phrase => $composableBuilder(
    column: $table.phrase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedPhrase => $composableBuilder(
    column: $table.normalizedPhrase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phraseType => $composableBuilder(
    column: $table.phraseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhrasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phrase =>
      $composableBuilder(column: $table.phrase, builder: (column) => column);

  GeneratedColumn<String> get normalizedPhrase => $composableBuilder(
    column: $table.normalizedPhrase,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phraseType => $composableBuilder(
    column: $table.phraseType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  Expression<T> phraseSensesRefs<T extends Object>(
    Expression<T> Function($$PhraseSensesTableAnnotationComposer a) f,
  ) {
    final $$PhraseSensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phraseSenses,
      getReferencedColumn: (t) => t.phraseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhraseSensesTableAnnotationComposer(
            $db: $db,
            $table: $db.phraseSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PhrasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhrasesTable,
          Phrase,
          $$PhrasesTableFilterComposer,
          $$PhrasesTableOrderingComposer,
          $$PhrasesTableAnnotationComposer,
          $$PhrasesTableCreateCompanionBuilder,
          $$PhrasesTableUpdateCompanionBuilder,
          (Phrase, $$PhrasesTableReferences),
          Phrase,
          PrefetchHooks Function({bool phraseSensesRefs})
        > {
  $$PhrasesTableTableManager(_$AppDatabase db, $PhrasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhrasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhrasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhrasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phrase = const Value.absent(),
                Value<String> normalizedPhrase = const Value.absent(),
                Value<String> phraseType = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> isArchived = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhrasesCompanion(
                id: id,
                phrase: phrase,
                normalizedPhrase: normalizedPhrase,
                phraseType: phraseType,
                cefrLevel: cefrLevel,
                notes: notes,
                isArchived: isArchived,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phrase,
                required String normalizedPhrase,
                required String phraseType,
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> isArchived = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => PhrasesCompanion.insert(
                id: id,
                phrase: phrase,
                normalizedPhrase: normalizedPhrase,
                phraseType: phraseType,
                cefrLevel: cefrLevel,
                notes: notes,
                isArchived: isArchived,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhrasesTable, Phrase>(table),
                  $$PhrasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({phraseSensesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (phraseSensesRefs) db.phraseSenses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (phraseSensesRefs)
                    await $_getPrefetchedData<
                      Phrase,
                      $PhrasesTable,
                      PhraseSense
                    >(
                      currentTable: table,
                      referencedTable: $$PhrasesTableReferences
                          ._phraseSensesRefsTable(db),
                      managerFromTypedResult: (p0) => $$PhrasesTableReferences(
                        db,
                        table,
                        p0,
                      ).phraseSensesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.phraseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PhrasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhrasesTable,
      Phrase,
      $$PhrasesTableFilterComposer,
      $$PhrasesTableOrderingComposer,
      $$PhrasesTableAnnotationComposer,
      $$PhrasesTableCreateCompanionBuilder,
      $$PhrasesTableUpdateCompanionBuilder,
      (Phrase, $$PhrasesTableReferences),
      Phrase,
      PrefetchHooks Function({bool phraseSensesRefs})
    >;
typedef $$PhraseSensesTableCreateCompanionBuilder =
    PhraseSensesCompanion Function({
      required String id,
      required String phraseId,
      Value<int> senseNumber,
      Value<String?> partOfSpeech,
      required String definitionEn,
      Value<String?> meaningVi,
      Value<String?> cefrLevel,
      Value<String?> registerLabel,
      Value<String?> domainLabel,
      Value<String?> grammarNote,
      Value<String?> usageNote,
      Value<int> isActive,
      Value<int> rowid,
    });
typedef $$PhraseSensesTableUpdateCompanionBuilder =
    PhraseSensesCompanion Function({
      Value<String> id,
      Value<String> phraseId,
      Value<int> senseNumber,
      Value<String?> partOfSpeech,
      Value<String> definitionEn,
      Value<String?> meaningVi,
      Value<String?> cefrLevel,
      Value<String?> registerLabel,
      Value<String?> domainLabel,
      Value<String?> grammarNote,
      Value<String?> usageNote,
      Value<int> isActive,
      Value<int> rowid,
    });

final class $$PhraseSensesTableReferences
    extends BaseReferences<_$AppDatabase, $PhraseSensesTable, PhraseSense> {
  $$PhraseSensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyItemsTable _idTable(_$AppDatabase db) =>
      db.studyItems.createAlias('phrase_senses__id__study_items__id');

  $$StudyItemsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PhrasesTable _phraseIdTable(_$AppDatabase db) =>
      db.phrases.createAlias('phrase_senses__phrase_id__phrases__id');

  $$PhrasesTableProcessedTableManager get phraseId {
    final $_column = $_itemColumn<String>('phrase_id')!;

    final manager = $$PhrasesTableTableManager(
      $_db,
      $_db.phrases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_phraseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhraseSensesTableFilterComposer
    extends Composer<_$AppDatabase, $PhraseSensesTable> {
  $$PhraseSensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get senseNumber => $composableBuilder(
    column: $table.senseNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaningVi => $composableBuilder(
    column: $table.meaningVi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registerLabel => $composableBuilder(
    column: $table.registerLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get domainLabel => $composableBuilder(
    column: $table.domainLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usageNote => $composableBuilder(
    column: $table.usageNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyItemsTableFilterComposer get id {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PhrasesTableFilterComposer get phraseId {
    final $$PhrasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseId,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableFilterComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhraseSensesTableOrderingComposer
    extends Composer<_$AppDatabase, $PhraseSensesTable> {
  $$PhraseSensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get senseNumber => $composableBuilder(
    column: $table.senseNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaningVi => $composableBuilder(
    column: $table.meaningVi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registerLabel => $composableBuilder(
    column: $table.registerLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domainLabel => $composableBuilder(
    column: $table.domainLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usageNote => $composableBuilder(
    column: $table.usageNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyItemsTableOrderingComposer get id {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PhrasesTableOrderingComposer get phraseId {
    final $$PhrasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseId,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableOrderingComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhraseSensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhraseSensesTable> {
  $$PhraseSensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get senseNumber => $composableBuilder(
    column: $table.senseNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meaningVi =>
      $composableBuilder(column: $table.meaningVi, builder: (column) => column);

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get registerLabel => $composableBuilder(
    column: $table.registerLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get domainLabel => $composableBuilder(
    column: $table.domainLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usageNote =>
      $composableBuilder(column: $table.usageNote, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$StudyItemsTableAnnotationComposer get id {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PhrasesTableAnnotationComposer get phraseId {
    final $$PhrasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phraseId,
      referencedTable: $db.phrases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhrasesTableAnnotationComposer(
            $db: $db,
            $table: $db.phrases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhraseSensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhraseSensesTable,
          PhraseSense,
          $$PhraseSensesTableFilterComposer,
          $$PhraseSensesTableOrderingComposer,
          $$PhraseSensesTableAnnotationComposer,
          $$PhraseSensesTableCreateCompanionBuilder,
          $$PhraseSensesTableUpdateCompanionBuilder,
          (PhraseSense, $$PhraseSensesTableReferences),
          PhraseSense,
          PrefetchHooks Function({bool id, bool phraseId})
        > {
  $$PhraseSensesTableTableManager(_$AppDatabase db, $PhraseSensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhraseSensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhraseSensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhraseSensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phraseId = const Value.absent(),
                Value<int> senseNumber = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                Value<String> definitionEn = const Value.absent(),
                Value<String?> meaningVi = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> registerLabel = const Value.absent(),
                Value<String?> domainLabel = const Value.absent(),
                Value<String?> grammarNote = const Value.absent(),
                Value<String?> usageNote = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhraseSensesCompanion(
                id: id,
                phraseId: phraseId,
                senseNumber: senseNumber,
                partOfSpeech: partOfSpeech,
                definitionEn: definitionEn,
                meaningVi: meaningVi,
                cefrLevel: cefrLevel,
                registerLabel: registerLabel,
                domainLabel: domainLabel,
                grammarNote: grammarNote,
                usageNote: usageNote,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phraseId,
                Value<int> senseNumber = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                required String definitionEn,
                Value<String?> meaningVi = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String?> registerLabel = const Value.absent(),
                Value<String?> domainLabel = const Value.absent(),
                Value<String?> grammarNote = const Value.absent(),
                Value<String?> usageNote = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhraseSensesCompanion.insert(
                id: id,
                phraseId: phraseId,
                senseNumber: senseNumber,
                partOfSpeech: partOfSpeech,
                definitionEn: definitionEn,
                meaningVi: meaningVi,
                cefrLevel: cefrLevel,
                registerLabel: registerLabel,
                domainLabel: domainLabel,
                grammarNote: grammarNote,
                usageNote: usageNote,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhraseSensesTable, PhraseSense>(table),
                  $$PhraseSensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false, phraseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.id,
                        referencedTable: $$PhraseSensesTableReferences._idTable(
                          db,
                        ),
                        referencedColumn: $$PhraseSensesTableReferences
                            ._idTable(db)
                            .id,
                      ) as T;
                    }
                    if (phraseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.phraseId,
                        referencedTable: $$PhraseSensesTableReferences
                            ._phraseIdTable(db),
                        referencedColumn: $$PhraseSensesTableReferences
                            ._phraseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PhraseSensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhraseSensesTable,
      PhraseSense,
      $$PhraseSensesTableFilterComposer,
      $$PhraseSensesTableOrderingComposer,
      $$PhraseSensesTableAnnotationComposer,
      $$PhraseSensesTableCreateCompanionBuilder,
      $$PhraseSensesTableUpdateCompanionBuilder,
      (PhraseSense, $$PhraseSensesTableReferences),
      PhraseSense,
      PrefetchHooks Function({bool id, bool phraseId})
    >;
typedef $$PronunciationsTableCreateCompanionBuilder =
    PronunciationsCompanion Function({
      required String id,
      Value<String?> headwordId,
      Value<String?> senseId,
      required String accent,
      Value<String?> ipa,
      Value<String?> audioAssetKey,
      Value<String?> sourceNote,
      Value<String?> licenceNote,
      Value<int> rowid,
    });
typedef $$PronunciationsTableUpdateCompanionBuilder =
    PronunciationsCompanion Function({
      Value<String> id,
      Value<String?> headwordId,
      Value<String?> senseId,
      Value<String> accent,
      Value<String?> ipa,
      Value<String?> audioAssetKey,
      Value<String?> sourceNote,
      Value<String?> licenceNote,
      Value<int> rowid,
    });

final class $$PronunciationsTableReferences
    extends BaseReferences<_$AppDatabase, $PronunciationsTable, Pronunciation> {
  $$PronunciationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HeadwordsTable _headwordIdTable(_$AppDatabase db) =>
      db.headwords.createAlias('pronunciations__headword_id__headwords__id');

  $$HeadwordsTableProcessedTableManager? get headwordId {
    final $_column = $_itemColumn<String>('headword_id');
    if ($_column == null) return null;
    final manager = $$HeadwordsTableTableManager(
      $_db,
      $_db.headwords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_headwordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudyItemsTable _senseIdTable(_$AppDatabase db) =>
      db.studyItems.createAlias('pronunciations__sense_id__study_items__id');

  $$StudyItemsTableProcessedTableManager? get senseId {
    final $_column = $_itemColumn<String>('sense_id');
    if ($_column == null) return null;
    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_senseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PronunciationsTableFilterComposer
    extends Composer<_$AppDatabase, $PronunciationsTable> {
  $$PronunciationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipa => $composableBuilder(
    column: $table.ipa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioAssetKey => $composableBuilder(
    column: $table.audioAssetKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenceNote => $composableBuilder(
    column: $table.licenceNote,
    builder: (column) => ColumnFilters(column),
  );

  $$HeadwordsTableFilterComposer get headwordId {
    final $$HeadwordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableFilterComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyItemsTableFilterComposer get senseId {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senseId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PronunciationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PronunciationsTable> {
  $$PronunciationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipa => $composableBuilder(
    column: $table.ipa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioAssetKey => $composableBuilder(
    column: $table.audioAssetKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenceNote => $composableBuilder(
    column: $table.licenceNote,
    builder: (column) => ColumnOrderings(column),
  );

  $$HeadwordsTableOrderingComposer get headwordId {
    final $$HeadwordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableOrderingComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyItemsTableOrderingComposer get senseId {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senseId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PronunciationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PronunciationsTable> {
  $$PronunciationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<String> get ipa =>
      $composableBuilder(column: $table.ipa, builder: (column) => column);

  GeneratedColumn<String> get audioAssetKey => $composableBuilder(
    column: $table.audioAssetKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licenceNote => $composableBuilder(
    column: $table.licenceNote,
    builder: (column) => column,
  );

  $$HeadwordsTableAnnotationComposer get headwordId {
    final $$HeadwordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableAnnotationComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyItemsTableAnnotationComposer get senseId {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senseId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PronunciationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PronunciationsTable,
          Pronunciation,
          $$PronunciationsTableFilterComposer,
          $$PronunciationsTableOrderingComposer,
          $$PronunciationsTableAnnotationComposer,
          $$PronunciationsTableCreateCompanionBuilder,
          $$PronunciationsTableUpdateCompanionBuilder,
          (Pronunciation, $$PronunciationsTableReferences),
          Pronunciation,
          PrefetchHooks Function({bool headwordId, bool senseId})
        > {
  $$PronunciationsTableTableManager(
    _$AppDatabase db,
    $PronunciationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PronunciationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PronunciationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PronunciationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> headwordId = const Value.absent(),
                Value<String?> senseId = const Value.absent(),
                Value<String> accent = const Value.absent(),
                Value<String?> ipa = const Value.absent(),
                Value<String?> audioAssetKey = const Value.absent(),
                Value<String?> sourceNote = const Value.absent(),
                Value<String?> licenceNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PronunciationsCompanion(
                id: id,
                headwordId: headwordId,
                senseId: senseId,
                accent: accent,
                ipa: ipa,
                audioAssetKey: audioAssetKey,
                sourceNote: sourceNote,
                licenceNote: licenceNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> headwordId = const Value.absent(),
                Value<String?> senseId = const Value.absent(),
                required String accent,
                Value<String?> ipa = const Value.absent(),
                Value<String?> audioAssetKey = const Value.absent(),
                Value<String?> sourceNote = const Value.absent(),
                Value<String?> licenceNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PronunciationsCompanion.insert(
                id: id,
                headwordId: headwordId,
                senseId: senseId,
                accent: accent,
                ipa: ipa,
                audioAssetKey: audioAssetKey,
                sourceNote: sourceNote,
                licenceNote: licenceNote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PronunciationsTable, Pronunciation>(table),
                  $$PronunciationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({headwordId = false, senseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (headwordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.headwordId,
                        referencedTable: $$PronunciationsTableReferences
                            ._headwordIdTable(db),
                        referencedColumn: $$PronunciationsTableReferences
                            ._headwordIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (senseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.senseId,
                        referencedTable: $$PronunciationsTableReferences
                            ._senseIdTable(db),
                        referencedColumn: $$PronunciationsTableReferences
                            ._senseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PronunciationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PronunciationsTable,
      Pronunciation,
      $$PronunciationsTableFilterComposer,
      $$PronunciationsTableOrderingComposer,
      $$PronunciationsTableAnnotationComposer,
      $$PronunciationsTableCreateCompanionBuilder,
      $$PronunciationsTableUpdateCompanionBuilder,
      (Pronunciation, $$PronunciationsTableReferences),
      Pronunciation,
      PrefetchHooks Function({bool headwordId, bool senseId})
    >;
typedef $$InflectionsTableCreateCompanionBuilder =
    InflectionsCompanion Function({
      required String id,
      required String headwordId,
      required String form,
      required String formType,
      Value<int> rowid,
    });
typedef $$InflectionsTableUpdateCompanionBuilder =
    InflectionsCompanion Function({
      Value<String> id,
      Value<String> headwordId,
      Value<String> form,
      Value<String> formType,
      Value<int> rowid,
    });

final class $$InflectionsTableReferences
    extends BaseReferences<_$AppDatabase, $InflectionsTable, Inflection> {
  $$InflectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HeadwordsTable _headwordIdTable(_$AppDatabase db) =>
      db.headwords.createAlias('inflections__headword_id__headwords__id');

  $$HeadwordsTableProcessedTableManager get headwordId {
    final $_column = $_itemColumn<String>('headword_id')!;

    final manager = $$HeadwordsTableTableManager(
      $_db,
      $_db.headwords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_headwordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InflectionsTableFilterComposer
    extends Composer<_$AppDatabase, $InflectionsTable> {
  $$InflectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formType => $composableBuilder(
    column: $table.formType,
    builder: (column) => ColumnFilters(column),
  );

  $$HeadwordsTableFilterComposer get headwordId {
    final $$HeadwordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableFilterComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InflectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InflectionsTable> {
  $$InflectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formType => $composableBuilder(
    column: $table.formType,
    builder: (column) => ColumnOrderings(column),
  );

  $$HeadwordsTableOrderingComposer get headwordId {
    final $$HeadwordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableOrderingComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InflectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InflectionsTable> {
  $$InflectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  GeneratedColumn<String> get formType =>
      $composableBuilder(column: $table.formType, builder: (column) => column);

  $$HeadwordsTableAnnotationComposer get headwordId {
    final $$HeadwordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headwordId,
      referencedTable: $db.headwords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HeadwordsTableAnnotationComposer(
            $db: $db,
            $table: $db.headwords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InflectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InflectionsTable,
          Inflection,
          $$InflectionsTableFilterComposer,
          $$InflectionsTableOrderingComposer,
          $$InflectionsTableAnnotationComposer,
          $$InflectionsTableCreateCompanionBuilder,
          $$InflectionsTableUpdateCompanionBuilder,
          (Inflection, $$InflectionsTableReferences),
          Inflection,
          PrefetchHooks Function({bool headwordId})
        > {
  $$InflectionsTableTableManager(_$AppDatabase db, $InflectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InflectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InflectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InflectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> headwordId = const Value.absent(),
                Value<String> form = const Value.absent(),
                Value<String> formType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InflectionsCompanion(
                id: id,
                headwordId: headwordId,
                form: form,
                formType: formType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String headwordId,
                required String form,
                required String formType,
                Value<int> rowid = const Value.absent(),
              }) => InflectionsCompanion.insert(
                id: id,
                headwordId: headwordId,
                form: form,
                formType: formType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InflectionsTable, Inflection>(table),
                  $$InflectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({headwordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (headwordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.headwordId,
                        referencedTable: $$InflectionsTableReferences
                            ._headwordIdTable(db),
                        referencedColumn: $$InflectionsTableReferences
                            ._headwordIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InflectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InflectionsTable,
      Inflection,
      $$InflectionsTableFilterComposer,
      $$InflectionsTableOrderingComposer,
      $$InflectionsTableAnnotationComposer,
      $$InflectionsTableCreateCompanionBuilder,
      $$InflectionsTableUpdateCompanionBuilder,
      (Inflection, $$InflectionsTableReferences),
      Inflection,
      PrefetchHooks Function({bool headwordId})
    >;
typedef $$ContentSourcesTableCreateCompanionBuilder =
    ContentSourcesCompanion Function({
      required String id,
      required String name,
      Value<String?> licence,
      Value<String?> url,
      Value<int> rowid,
    });
typedef $$ContentSourcesTableUpdateCompanionBuilder =
    ContentSourcesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> licence,
      Value<String?> url,
      Value<int> rowid,
    });

final class $$ContentSourcesTableReferences
    extends BaseReferences<_$AppDatabase, $ContentSourcesTable, ContentSource> {
  $$ContentSourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SourceAttributionsTable, List<SourceAttribution>>
  _sourceAttributionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sourceAttributions,
        aliasName: 'content_sources__id__source_attributions__source_id',
      );

  $$SourceAttributionsTableProcessedTableManager get sourceAttributionsRefs {
    final manager = $$SourceAttributionsTableTableManager(
      $_db,
      $_db.sourceAttributions,
    ).filter((f) => f.sourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sourceAttributionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamplesTable, List<Example>> _examplesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.examples,
    aliasName: 'content_sources__id__examples__source_id',
  );

  $$ExamplesTableProcessedTableManager get examplesRefs {
    final manager = $$ExamplesTableTableManager(
      $_db,
      $_db.examples,
    ).filter((f) => f.sourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examplesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContentSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $ContentSourcesTable> {
  $$ContentSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licence => $composableBuilder(
    column: $table.licence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sourceAttributionsRefs(
    Expression<bool> Function($$SourceAttributionsTableFilterComposer f) f,
  ) {
    final $$SourceAttributionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sourceAttributions,
      getReferencedColumn: (t) => t.sourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourceAttributionsTableFilterComposer(
            $db: $db,
            $table: $db.sourceAttributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examplesRefs(
    Expression<bool> Function($$ExamplesTableFilterComposer f) f,
  ) {
    final $$ExamplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examples,
      getReferencedColumn: (t) => t.sourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamplesTableFilterComposer(
            $db: $db,
            $table: $db.examples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentSourcesTable> {
  $$ContentSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licence => $composableBuilder(
    column: $table.licence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContentSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentSourcesTable> {
  $$ContentSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get licence =>
      $composableBuilder(column: $table.licence, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  Expression<T> sourceAttributionsRefs<T extends Object>(
    Expression<T> Function($$SourceAttributionsTableAnnotationComposer a) f,
  ) {
    final $$SourceAttributionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sourceAttributions,
          getReferencedColumn: (t) => t.sourceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SourceAttributionsTableAnnotationComposer(
                $db: $db,
                $table: $db.sourceAttributions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> examplesRefs<T extends Object>(
    Expression<T> Function($$ExamplesTableAnnotationComposer a) f,
  ) {
    final $$ExamplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examples,
      getReferencedColumn: (t) => t.sourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamplesTableAnnotationComposer(
            $db: $db,
            $table: $db.examples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentSourcesTable,
          ContentSource,
          $$ContentSourcesTableFilterComposer,
          $$ContentSourcesTableOrderingComposer,
          $$ContentSourcesTableAnnotationComposer,
          $$ContentSourcesTableCreateCompanionBuilder,
          $$ContentSourcesTableUpdateCompanionBuilder,
          (ContentSource, $$ContentSourcesTableReferences),
          ContentSource,
          PrefetchHooks Function({
            bool sourceAttributionsRefs,
            bool examplesRefs,
          })
        > {
  $$ContentSourcesTableTableManager(
    _$AppDatabase db,
    $ContentSourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> licence = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentSourcesCompanion(
                id: id,
                name: name,
                licence: licence,
                url: url,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> licence = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentSourcesCompanion.insert(
                id: id,
                name: name,
                licence: licence,
                url: url,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ContentSourcesTable, ContentSource>(table),
                  $$ContentSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sourceAttributionsRefs = false, examplesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sourceAttributionsRefs) db.sourceAttributions,
                    if (examplesRefs) db.examples,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sourceAttributionsRefs)
                        await $_getPrefetchedData<
                          ContentSource,
                          $ContentSourcesTable,
                          SourceAttribution
                        >(
                          currentTable: table,
                          referencedTable: $$ContentSourcesTableReferences
                              ._sourceAttributionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentSourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).sourceAttributionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (examplesRefs)
                        await $_getPrefetchedData<
                          ContentSource,
                          $ContentSourcesTable,
                          Example
                        >(
                          currentTable: table,
                          referencedTable: $$ContentSourcesTableReferences
                              ._examplesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentSourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).examplesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ContentSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentSourcesTable,
      ContentSource,
      $$ContentSourcesTableFilterComposer,
      $$ContentSourcesTableOrderingComposer,
      $$ContentSourcesTableAnnotationComposer,
      $$ContentSourcesTableCreateCompanionBuilder,
      $$ContentSourcesTableUpdateCompanionBuilder,
      (ContentSource, $$ContentSourcesTableReferences),
      ContentSource,
      PrefetchHooks Function({bool sourceAttributionsRefs, bool examplesRefs})
    >;
typedef $$SourceAttributionsTableCreateCompanionBuilder =
    SourceAttributionsCompanion Function({
      required String id,
      required String sourceId,
      required String entityType,
      required String entityId,
      Value<int> rowid,
    });
typedef $$SourceAttributionsTableUpdateCompanionBuilder =
    SourceAttributionsCompanion Function({
      Value<String> id,
      Value<String> sourceId,
      Value<String> entityType,
      Value<String> entityId,
      Value<int> rowid,
    });

final class $$SourceAttributionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SourceAttributionsTable,
          SourceAttribution
        > {
  $$SourceAttributionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ContentSourcesTable _sourceIdTable(_$AppDatabase db) => db
      .contentSources
      .createAlias('source_attributions__source_id__content_sources__id');

  $$ContentSourcesTableProcessedTableManager get sourceId {
    final $_column = $_itemColumn<String>('source_id')!;

    final manager = $$ContentSourcesTableTableManager(
      $_db,
      $_db.contentSources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SourceAttributionsTableFilterComposer
    extends Composer<_$AppDatabase, $SourceAttributionsTable> {
  $$SourceAttributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  $$ContentSourcesTableFilterComposer get sourceId {
    final $$ContentSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.contentSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentSourcesTableFilterComposer(
            $db: $db,
            $table: $db.contentSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SourceAttributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SourceAttributionsTable> {
  $$SourceAttributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContentSourcesTableOrderingComposer get sourceId {
    final $$ContentSourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.contentSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentSourcesTableOrderingComposer(
            $db: $db,
            $table: $db.contentSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SourceAttributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SourceAttributionsTable> {
  $$SourceAttributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  $$ContentSourcesTableAnnotationComposer get sourceId {
    final $$ContentSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.contentSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.contentSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SourceAttributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SourceAttributionsTable,
          SourceAttribution,
          $$SourceAttributionsTableFilterComposer,
          $$SourceAttributionsTableOrderingComposer,
          $$SourceAttributionsTableAnnotationComposer,
          $$SourceAttributionsTableCreateCompanionBuilder,
          $$SourceAttributionsTableUpdateCompanionBuilder,
          (SourceAttribution, $$SourceAttributionsTableReferences),
          SourceAttribution,
          PrefetchHooks Function({bool sourceId})
        > {
  $$SourceAttributionsTableTableManager(
    _$AppDatabase db,
    $SourceAttributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SourceAttributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SourceAttributionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SourceAttributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SourceAttributionsCompanion(
                id: id,
                sourceId: sourceId,
                entityType: entityType,
                entityId: entityId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceId,
                required String entityType,
                required String entityId,
                Value<int> rowid = const Value.absent(),
              }) => SourceAttributionsCompanion.insert(
                id: id,
                sourceId: sourceId,
                entityType: entityType,
                entityId: entityId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SourceAttributionsTable, SourceAttribution>(
                    table,
                  ),
                  $$SourceAttributionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sourceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sourceId,
                        referencedTable: $$SourceAttributionsTableReferences
                            ._sourceIdTable(db),
                        referencedColumn: $$SourceAttributionsTableReferences
                            ._sourceIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SourceAttributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SourceAttributionsTable,
      SourceAttribution,
      $$SourceAttributionsTableFilterComposer,
      $$SourceAttributionsTableOrderingComposer,
      $$SourceAttributionsTableAnnotationComposer,
      $$SourceAttributionsTableCreateCompanionBuilder,
      $$SourceAttributionsTableUpdateCompanionBuilder,
      (SourceAttribution, $$SourceAttributionsTableReferences),
      SourceAttribution,
      PrefetchHooks Function({bool sourceId})
    >;
typedef $$ExamplesTableCreateCompanionBuilder = ExamplesCompanion Function({
  required String id,
  required String studyItemId,
  required String englishText,
  Value<String?> vietnameseText,
  Value<String?> note,
  Value<String?> audioAssetKey,
  Value<int> sortOrder,
  Value<String?> sourceId,
  Value<int> rowid,
});
typedef $$ExamplesTableUpdateCompanionBuilder = ExamplesCompanion Function({
  Value<String> id,
  Value<String> studyItemId,
  Value<String> englishText,
  Value<String?> vietnameseText,
  Value<String?> note,
  Value<String?> audioAssetKey,
  Value<int> sortOrder,
  Value<String?> sourceId,
  Value<int> rowid,
});

final class $$ExamplesTableReferences
    extends BaseReferences<_$AppDatabase, $ExamplesTable, Example> {
  $$ExamplesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyItemsTable _studyItemIdTable(_$AppDatabase db) =>
      db.studyItems.createAlias('examples__study_item_id__study_items__id');

  $$StudyItemsTableProcessedTableManager get studyItemId {
    final $_column = $_itemColumn<String>('study_item_id')!;

    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContentSourcesTable _sourceIdTable(_$AppDatabase db) =>
      db.contentSources.createAlias('examples__source_id__content_sources__id');

  $$ContentSourcesTableProcessedTableManager? get sourceId {
    final $_column = $_itemColumn<String>('source_id');
    if ($_column == null) return null;
    final manager = $$ContentSourcesTableTableManager(
      $_db,
      $_db.contentSources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExamplesTableFilterComposer
    extends Composer<_$AppDatabase, $ExamplesTable> {
  $$ExamplesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get englishText => $composableBuilder(
    column: $table.englishText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vietnameseText => $composableBuilder(
    column: $table.vietnameseText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioAssetKey => $composableBuilder(
    column: $table.audioAssetKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyItemsTableFilterComposer get studyItemId {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentSourcesTableFilterComposer get sourceId {
    final $$ContentSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.contentSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentSourcesTableFilterComposer(
            $db: $db,
            $table: $db.contentSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamplesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamplesTable> {
  $$ExamplesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get englishText => $composableBuilder(
    column: $table.englishText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vietnameseText => $composableBuilder(
    column: $table.vietnameseText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioAssetKey => $composableBuilder(
    column: $table.audioAssetKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyItemsTableOrderingComposer get studyItemId {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentSourcesTableOrderingComposer get sourceId {
    final $$ContentSourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.contentSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentSourcesTableOrderingComposer(
            $db: $db,
            $table: $db.contentSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamplesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamplesTable> {
  $$ExamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get englishText => $composableBuilder(
    column: $table.englishText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vietnameseText => $composableBuilder(
    column: $table.vietnameseText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get audioAssetKey => $composableBuilder(
    column: $table.audioAssetKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$StudyItemsTableAnnotationComposer get studyItemId {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentSourcesTableAnnotationComposer get sourceId {
    final $$ContentSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.contentSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.contentSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamplesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamplesTable,
          Example,
          $$ExamplesTableFilterComposer,
          $$ExamplesTableOrderingComposer,
          $$ExamplesTableAnnotationComposer,
          $$ExamplesTableCreateCompanionBuilder,
          $$ExamplesTableUpdateCompanionBuilder,
          (Example, $$ExamplesTableReferences),
          Example,
          PrefetchHooks Function({bool studyItemId, bool sourceId})
        > {
  $$ExamplesTableTableManager(_$AppDatabase db, $ExamplesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyItemId = const Value.absent(),
                Value<String> englishText = const Value.absent(),
                Value<String?> vietnameseText = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> audioAssetKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamplesCompanion(
                id: id,
                studyItemId: studyItemId,
                englishText: englishText,
                vietnameseText: vietnameseText,
                note: note,
                audioAssetKey: audioAssetKey,
                sortOrder: sortOrder,
                sourceId: sourceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyItemId,
                required String englishText,
                Value<String?> vietnameseText = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> audioAssetKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamplesCompanion.insert(
                id: id,
                studyItemId: studyItemId,
                englishText: englishText,
                vietnameseText: vietnameseText,
                note: note,
                audioAssetKey: audioAssetKey,
                sortOrder: sortOrder,
                sourceId: sourceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamplesTable, Example>(table),
                  $$ExamplesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studyItemId = false, sourceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (studyItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studyItemId,
                        referencedTable: $$ExamplesTableReferences
                            ._studyItemIdTable(db),
                        referencedColumn: $$ExamplesTableReferences
                            ._studyItemIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (sourceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sourceId,
                        referencedTable: $$ExamplesTableReferences
                            ._sourceIdTable(db),
                        referencedColumn: $$ExamplesTableReferences
                            ._sourceIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExamplesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamplesTable,
      Example,
      $$ExamplesTableFilterComposer,
      $$ExamplesTableOrderingComposer,
      $$ExamplesTableAnnotationComposer,
      $$ExamplesTableCreateCompanionBuilder,
      $$ExamplesTableUpdateCompanionBuilder,
      (Example, $$ExamplesTableReferences),
      Example,
      PrefetchHooks Function({bool studyItemId, bool sourceId})
    >;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  required String id,
  required String slug,
  required String name,
  required String category,
  Value<String?> description,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> slug,
  Value<String> name,
  Value<String> category,
  Value<String?> description,
  Value<int> rowid,
});

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemTagsTable, List<ItemTag>> _itemTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.itemTags,
    aliasName: 'tags__id__item_tags__tag_id',
  );

  $$ItemTagsTableProcessedTableManager get itemTagsRefs {
    final manager = $$ItemTagsTableTableManager(
      $_db,
      $_db.itemTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotificationRulesTable, List<NotificationRule>>
  _notificationRulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.notificationRules,
        aliasName: 'tags__id__notification_rules__tag_filter_id',
      );

  $$NotificationRulesTableProcessedTableManager get notificationRulesRefs {
    final manager = $$NotificationRulesTableTableManager(
      $_db,
      $_db.notificationRules,
    ).filter((f) => f.tagFilterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _notificationRulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> itemTagsRefs(
    Expression<bool> Function($$ItemTagsTableFilterComposer f) f,
  ) {
    final $$ItemTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemTagsTableFilterComposer(
            $db: $db,
            $table: $db.itemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notificationRulesRefs(
    Expression<bool> Function($$NotificationRulesTableFilterComposer f) f,
  ) {
    final $$NotificationRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notificationRules,
      getReferencedColumn: (t) => t.tagFilterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationRulesTableFilterComposer(
            $db: $db,
            $table: $db.notificationRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> itemTagsRefs<T extends Object>(
    Expression<T> Function($$ItemTagsTableAnnotationComposer a) f,
  ) {
    final $$ItemTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.itemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notificationRulesRefs<T extends Object>(
    Expression<T> Function($$NotificationRulesTableAnnotationComposer a) f,
  ) {
    final $$NotificationRulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.notificationRules,
          getReferencedColumn: (t) => t.tagFilterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NotificationRulesTableAnnotationComposer(
                $db: $db,
                $table: $db.notificationRules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({
            bool itemTagsRefs,
            bool notificationRulesRefs,
          })
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                slug: slug,
                name: name,
                category: category,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String slug,
                required String name,
                required String category,
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                category: category,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({itemTagsRefs = false, notificationRulesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (itemTagsRefs) db.itemTags,
                    if (notificationRulesRefs) db.notificationRules,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (itemTagsRefs)
                        await $_getPrefetchedData<Tag, $TagsTable, ItemTag>(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._itemTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TagsTableReferences(db, table, p0).itemTagsRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.tagId == item.id),
                          typedResults: items,
                        ),
                      if (notificationRulesRefs)
                        await $_getPrefetchedData<
                          Tag,
                          $TagsTable,
                          NotificationRule
                        >(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._notificationRulesRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).notificationRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagFilterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool itemTagsRefs, bool notificationRulesRefs})
    >;
typedef $$ItemTagsTableCreateCompanionBuilder = ItemTagsCompanion Function({
  required String studyItemId,
  required String tagId,
  Value<int> rowid,
});
typedef $$ItemTagsTableUpdateCompanionBuilder = ItemTagsCompanion Function({
  Value<String> studyItemId,
  Value<String> tagId,
  Value<int> rowid,
});

final class $$ItemTagsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemTagsTable, ItemTag> {
  $$ItemTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyItemsTable _studyItemIdTable(_$AppDatabase db) =>
      db.studyItems.createAlias('item_tags__study_item_id__study_items__id');

  $$StudyItemsTableProcessedTableManager get studyItemId {
    final $_column = $_itemColumn<String>('study_item_id')!;

    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('item_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItemTagsTableFilterComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$StudyItemsTableFilterComposer get studyItemId {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$StudyItemsTableOrderingComposer get studyItemId {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$StudyItemsTableAnnotationComposer get studyItemId {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemTagsTable,
          ItemTag,
          $$ItemTagsTableFilterComposer,
          $$ItemTagsTableOrderingComposer,
          $$ItemTagsTableAnnotationComposer,
          $$ItemTagsTableCreateCompanionBuilder,
          $$ItemTagsTableUpdateCompanionBuilder,
          (ItemTag, $$ItemTagsTableReferences),
          ItemTag,
          PrefetchHooks Function({bool studyItemId, bool tagId})
        > {
  $$ItemTagsTableTableManager(_$AppDatabase db, $ItemTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> studyItemId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemTagsCompanion(
                studyItemId: studyItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String studyItemId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => ItemTagsCompanion.insert(
                studyItemId: studyItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ItemTagsTable, ItemTag>(table),
                  $$ItemTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studyItemId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (studyItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studyItemId,
                        referencedTable: $$ItemTagsTableReferences
                            ._studyItemIdTable(db),
                        referencedColumn: $$ItemTagsTableReferences
                            ._studyItemIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (tagId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagId,
                        referencedTable: $$ItemTagsTableReferences._tagIdTable(
                          db,
                        ),
                        referencedColumn: $$ItemTagsTableReferences
                            ._tagIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItemTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemTagsTable,
      ItemTag,
      $$ItemTagsTableFilterComposer,
      $$ItemTagsTableOrderingComposer,
      $$ItemTagsTableAnnotationComposer,
      $$ItemTagsTableCreateCompanionBuilder,
      $$ItemTagsTableUpdateCompanionBuilder,
      (ItemTag, $$ItemTagsTableReferences),
      ItemTag,
      PrefetchHooks Function({bool studyItemId, bool tagId})
    >;
typedef $$QuestionsTableCreateCompanionBuilder = QuestionsCompanion Function({
  required String id,
  Value<String?> targetItemId,
  required String questionType,
  required String prompt,
  Value<String?> explanation,
  Value<String?> cefrLevel,
  required String contentOrigin,
  Value<int> isActive,
  required int createdAtMs,
  Value<int> rowid,
});
typedef $$QuestionsTableUpdateCompanionBuilder = QuestionsCompanion Function({
  Value<String> id,
  Value<String?> targetItemId,
  Value<String> questionType,
  Value<String> prompt,
  Value<String?> explanation,
  Value<String?> cefrLevel,
  Value<String> contentOrigin,
  Value<int> isActive,
  Value<int> createdAtMs,
  Value<int> rowid,
});

final class $$QuestionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionsTable, Question> {
  $$QuestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyItemsTable _targetItemIdTable(_$AppDatabase db) =>
      db.studyItems.createAlias('questions__target_item_id__study_items__id');

  $$StudyItemsTableProcessedTableManager? get targetItemId {
    final $_column = $_itemColumn<String>('target_item_id');
    if ($_column == null) return null;
    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$QuestionOptionsTable, List<QuestionOption>>
  _questionOptionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionOptions,
    aliasName: 'questions__id__question_options__question_id',
  );

  $$QuestionOptionsTableProcessedTableManager get questionOptionsRefs {
    final manager = $$QuestionOptionsTableTableManager(
      $_db,
      $_db.questionOptions,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionOptionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewEventsTable, List<ReviewEvent>>
  _reviewEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewEvents,
    aliasName: 'questions__id__review_events__question_id',
  );

  $$ReviewEventsTableProcessedTableManager get reviewEventsRefs {
    final manager = $$ReviewEventsTableTableManager(
      $_db,
      $_db.reviewEvents,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentOrigin => $composableBuilder(
    column: $table.contentOrigin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyItemsTableFilterComposer get targetItemId {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> questionOptionsRefs(
    Expression<bool> Function($$QuestionOptionsTableFilterComposer f) f,
  ) {
    final $$QuestionOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionOptions,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionOptionsTableFilterComposer(
            $db: $db,
            $table: $db.questionOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewEventsRefs(
    Expression<bool> Function($$ReviewEventsTableFilterComposer f) f,
  ) {
    final $$ReviewEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableFilterComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentOrigin => $composableBuilder(
    column: $table.contentOrigin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyItemsTableOrderingComposer get targetItemId {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get contentOrigin => $composableBuilder(
    column: $table.contentOrigin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  $$StudyItemsTableAnnotationComposer get targetItemId {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> questionOptionsRefs<T extends Object>(
    Expression<T> Function($$QuestionOptionsTableAnnotationComposer a) f,
  ) {
    final $$QuestionOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionOptions,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questionOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewEventsRefs<T extends Object>(
    Expression<T> Function($$ReviewEventsTableAnnotationComposer a) f,
  ) {
    final $$ReviewEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionsTable,
          Question,
          $$QuestionsTableFilterComposer,
          $$QuestionsTableOrderingComposer,
          $$QuestionsTableAnnotationComposer,
          $$QuestionsTableCreateCompanionBuilder,
          $$QuestionsTableUpdateCompanionBuilder,
          (Question, $$QuestionsTableReferences),
          Question,
          PrefetchHooks Function({
            bool targetItemId,
            bool questionOptionsRefs,
            bool reviewEventsRefs,
          })
        > {
  $$QuestionsTableTableManager(_$AppDatabase db, $QuestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> targetItemId = const Value.absent(),
                Value<String> questionType = const Value.absent(),
                Value<String> prompt = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                Value<String> contentOrigin = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion(
                id: id,
                targetItemId: targetItemId,
                questionType: questionType,
                prompt: prompt,
                explanation: explanation,
                cefrLevel: cefrLevel,
                contentOrigin: contentOrigin,
                isActive: isActive,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> targetItemId = const Value.absent(),
                required String questionType,
                required String prompt,
                Value<String?> explanation = const Value.absent(),
                Value<String?> cefrLevel = const Value.absent(),
                required String contentOrigin,
                Value<int> isActive = const Value.absent(),
                required int createdAtMs,
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion.insert(
                id: id,
                targetItemId: targetItemId,
                questionType: questionType,
                prompt: prompt,
                explanation: explanation,
                cefrLevel: cefrLevel,
                contentOrigin: contentOrigin,
                isActive: isActive,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionsTable, Question>(table),
                  $$QuestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                targetItemId = false,
                questionOptionsRefs = false,
                reviewEventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (questionOptionsRefs) db.questionOptions,
                    if (reviewEventsRefs) db.reviewEvents,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (targetItemId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.targetItemId,
                            referencedTable: $$QuestionsTableReferences
                                ._targetItemIdTable(db),
                            referencedColumn: $$QuestionsTableReferences
                                ._targetItemIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (questionOptionsRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          QuestionOption
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionOptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionOptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reviewEventsRefs)
                        await $_getPrefetchedData<
                          Question,
                          $QuestionsTable,
                          ReviewEvent
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._reviewEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$QuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionsTable,
      Question,
      $$QuestionsTableFilterComposer,
      $$QuestionsTableOrderingComposer,
      $$QuestionsTableAnnotationComposer,
      $$QuestionsTableCreateCompanionBuilder,
      $$QuestionsTableUpdateCompanionBuilder,
      (Question, $$QuestionsTableReferences),
      Question,
      PrefetchHooks Function({
        bool targetItemId,
        bool questionOptionsRefs,
        bool reviewEventsRefs,
      })
    >;
typedef $$QuestionOptionsTableCreateCompanionBuilder =
    QuestionOptionsCompanion Function({
      required String id,
      required String questionId,
      required String optionText,
      required int sortOrder,
      required int isCorrect,
      Value<int> rowid,
    });
typedef $$QuestionOptionsTableUpdateCompanionBuilder =
    QuestionOptionsCompanion Function({
      Value<String> id,
      Value<String> questionId,
      Value<String> optionText,
      Value<int> sortOrder,
      Value<int> isCorrect,
      Value<int> rowid,
    });

final class $$QuestionOptionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $QuestionOptionsTable, QuestionOption> {
  $$QuestionOptionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('question_options__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReviewEventsTable, List<ReviewEvent>>
  _reviewEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewEvents,
    aliasName: 'question_options__id__review_events__selected_option_id',
  );

  $$ReviewEventsTableProcessedTableManager get reviewEventsRefs {
    final manager = $$ReviewEventsTableTableManager($_db, $_db.reviewEvents)
        .filter(
          (f) => f.selectedOptionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_reviewEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestionOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionOptionsTable> {
  $$QuestionOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reviewEventsRefs(
    Expression<bool> Function($$ReviewEventsTableFilterComposer f) f,
  ) {
    final $$ReviewEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.selectedOptionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableFilterComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionOptionsTable> {
  $$QuestionOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionOptionsTable> {
  $$QuestionOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> reviewEventsRefs<T extends Object>(
    Expression<T> Function($$ReviewEventsTableAnnotationComposer a) f,
  ) {
    final $$ReviewEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.selectedOptionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionOptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionOptionsTable,
          QuestionOption,
          $$QuestionOptionsTableFilterComposer,
          $$QuestionOptionsTableOrderingComposer,
          $$QuestionOptionsTableAnnotationComposer,
          $$QuestionOptionsTableCreateCompanionBuilder,
          $$QuestionOptionsTableUpdateCompanionBuilder,
          (QuestionOption, $$QuestionOptionsTableReferences),
          QuestionOption,
          PrefetchHooks Function({bool questionId, bool reviewEventsRefs})
        > {
  $$QuestionOptionsTableTableManager(
    _$AppDatabase db,
    $QuestionOptionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> optionText = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> isCorrect = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionOptionsCompanion(
                id: id,
                questionId: questionId,
                optionText: optionText,
                sortOrder: sortOrder,
                isCorrect: isCorrect,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String questionId,
                required String optionText,
                required int sortOrder,
                required int isCorrect,
                Value<int> rowid = const Value.absent(),
              }) => QuestionOptionsCompanion.insert(
                id: id,
                questionId: questionId,
                optionText: optionText,
                sortOrder: sortOrder,
                isCorrect: isCorrect,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionOptionsTable, QuestionOption>(table),
                  $$QuestionOptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({questionId = false, reviewEventsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (reviewEventsRefs) db.reviewEvents,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (questionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.questionId,
                            referencedTable: $$QuestionOptionsTableReferences
                                ._questionIdTable(db),
                            referencedColumn: $$QuestionOptionsTableReferences
                                ._questionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (reviewEventsRefs)
                        await $_getPrefetchedData<
                          QuestionOption,
                          $QuestionOptionsTable,
                          ReviewEvent
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionOptionsTableReferences
                              ._reviewEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionOptionsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.selectedOptionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$QuestionOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionOptionsTable,
      QuestionOption,
      $$QuestionOptionsTableFilterComposer,
      $$QuestionOptionsTableOrderingComposer,
      $$QuestionOptionsTableAnnotationComposer,
      $$QuestionOptionsTableCreateCompanionBuilder,
      $$QuestionOptionsTableUpdateCompanionBuilder,
      (QuestionOption, $$QuestionOptionsTableReferences),
      QuestionOption,
      PrefetchHooks Function({bool questionId, bool reviewEventsRefs})
    >;
typedef $$LearningProgressTableCreateCompanionBuilder =
    LearningProgressCompanion Function({
      required String studyItemId,
      required String status,
      Value<int> repetitionCount,
      Value<double> intervalDays,
      Value<double> easeFactor,
      Value<int> lapses,
      Value<int?> dueAtMs,
      Value<int?> lastReviewedAtMs,
      Value<int> totalCorrect,
      Value<int> totalIncorrect,
      Value<int> isFavorite,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$LearningProgressTableUpdateCompanionBuilder =
    LearningProgressCompanion Function({
      Value<String> studyItemId,
      Value<String> status,
      Value<int> repetitionCount,
      Value<double> intervalDays,
      Value<double> easeFactor,
      Value<int> lapses,
      Value<int?> dueAtMs,
      Value<int?> lastReviewedAtMs,
      Value<int> totalCorrect,
      Value<int> totalIncorrect,
      Value<int> isFavorite,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

final class $$LearningProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LearningProgressTable,
          LearningProgressData
        > {
  $$LearningProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudyItemsTable _studyItemIdTable(_$AppDatabase db) => db.studyItems
      .createAlias('learning_progress__study_item_id__study_items__id');

  $$StudyItemsTableProcessedTableManager get studyItemId {
    final $_column = $_itemColumn<String>('study_item_id')!;

    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LearningProgressTableFilterComposer
    extends Composer<_$AppDatabase, $LearningProgressTable> {
  $$LearningProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitionCount => $composableBuilder(
    column: $table.repetitionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueAtMs => $composableBuilder(
    column: $table.dueAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReviewedAtMs => $composableBuilder(
    column: $table.lastReviewedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCorrect => $composableBuilder(
    column: $table.totalCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalIncorrect => $composableBuilder(
    column: $table.totalIncorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyItemsTableFilterComposer get studyItemId {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningProgressTable> {
  $$LearningProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitionCount => $composableBuilder(
    column: $table.repetitionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueAtMs => $composableBuilder(
    column: $table.dueAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReviewedAtMs => $composableBuilder(
    column: $table.lastReviewedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCorrect => $composableBuilder(
    column: $table.totalCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalIncorrect => $composableBuilder(
    column: $table.totalIncorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyItemsTableOrderingComposer get studyItemId {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningProgressTable> {
  $$LearningProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get repetitionCount => $composableBuilder(
    column: $table.repetitionCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  GeneratedColumn<int> get dueAtMs =>
      $composableBuilder(column: $table.dueAtMs, builder: (column) => column);

  GeneratedColumn<int> get lastReviewedAtMs => $composableBuilder(
    column: $table.lastReviewedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCorrect => $composableBuilder(
    column: $table.totalCorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalIncorrect => $composableBuilder(
    column: $table.totalIncorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  $$StudyItemsTableAnnotationComposer get studyItemId {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningProgressTable,
          LearningProgressData,
          $$LearningProgressTableFilterComposer,
          $$LearningProgressTableOrderingComposer,
          $$LearningProgressTableAnnotationComposer,
          $$LearningProgressTableCreateCompanionBuilder,
          $$LearningProgressTableUpdateCompanionBuilder,
          (LearningProgressData, $$LearningProgressTableReferences),
          LearningProgressData,
          PrefetchHooks Function({bool studyItemId})
        > {
  $$LearningProgressTableTableManager(
    _$AppDatabase db,
    $LearningProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> studyItemId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> repetitionCount = const Value.absent(),
                Value<double> intervalDays = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int?> dueAtMs = const Value.absent(),
                Value<int?> lastReviewedAtMs = const Value.absent(),
                Value<int> totalCorrect = const Value.absent(),
                Value<int> totalIncorrect = const Value.absent(),
                Value<int> isFavorite = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningProgressCompanion(
                studyItemId: studyItemId,
                status: status,
                repetitionCount: repetitionCount,
                intervalDays: intervalDays,
                easeFactor: easeFactor,
                lapses: lapses,
                dueAtMs: dueAtMs,
                lastReviewedAtMs: lastReviewedAtMs,
                totalCorrect: totalCorrect,
                totalIncorrect: totalIncorrect,
                isFavorite: isFavorite,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String studyItemId,
                required String status,
                Value<int> repetitionCount = const Value.absent(),
                Value<double> intervalDays = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int?> dueAtMs = const Value.absent(),
                Value<int?> lastReviewedAtMs = const Value.absent(),
                Value<int> totalCorrect = const Value.absent(),
                Value<int> totalIncorrect = const Value.absent(),
                Value<int> isFavorite = const Value.absent(),
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => LearningProgressCompanion.insert(
                studyItemId: studyItemId,
                status: status,
                repetitionCount: repetitionCount,
                intervalDays: intervalDays,
                easeFactor: easeFactor,
                lapses: lapses,
                dueAtMs: dueAtMs,
                lastReviewedAtMs: lastReviewedAtMs,
                totalCorrect: totalCorrect,
                totalIncorrect: totalIncorrect,
                isFavorite: isFavorite,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningProgressTable, LearningProgressData>(
                    table,
                  ),
                  $$LearningProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studyItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (studyItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studyItemId,
                        referencedTable: $$LearningProgressTableReferences
                            ._studyItemIdTable(db),
                        referencedColumn: $$LearningProgressTableReferences
                            ._studyItemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LearningProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningProgressTable,
      LearningProgressData,
      $$LearningProgressTableFilterComposer,
      $$LearningProgressTableOrderingComposer,
      $$LearningProgressTableAnnotationComposer,
      $$LearningProgressTableCreateCompanionBuilder,
      $$LearningProgressTableUpdateCompanionBuilder,
      (LearningProgressData, $$LearningProgressTableReferences),
      LearningProgressData,
      PrefetchHooks Function({bool studyItemId})
    >;
typedef $$ReviewEventsTableCreateCompanionBuilder =
    ReviewEventsCompanion Function({
      required String id,
      required String studyItemId,
      Value<String?> questionId,
      Value<String?> selectedOptionId,
      Value<int?> isCorrect,
      Value<int?> quality,
      Value<int?> elapsedMs,
      required String studyMode,
      required int answeredAtMs,
      Value<int> rowid,
    });
typedef $$ReviewEventsTableUpdateCompanionBuilder =
    ReviewEventsCompanion Function({
      Value<String> id,
      Value<String> studyItemId,
      Value<String?> questionId,
      Value<String?> selectedOptionId,
      Value<int?> isCorrect,
      Value<int?> quality,
      Value<int?> elapsedMs,
      Value<String> studyMode,
      Value<int> answeredAtMs,
      Value<int> rowid,
    });

final class $$ReviewEventsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewEventsTable, ReviewEvent> {
  $$ReviewEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyItemsTable _studyItemIdTable(_$AppDatabase db) => db.studyItems
      .createAlias('review_events__study_item_id__study_items__id');

  $$StudyItemsTableProcessedTableManager get studyItemId {
    final $_column = $_itemColumn<String>('study_item_id')!;

    final manager = $$StudyItemsTableTableManager(
      $_db,
      $_db.studyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('review_events__question_id__questions__id');

  $$QuestionsTableProcessedTableManager? get questionId {
    final $_column = $_itemColumn<String>('question_id');
    if ($_column == null) return null;
    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $QuestionOptionsTable _selectedOptionIdTable(_$AppDatabase db) => db
      .questionOptions
      .createAlias('review_events__selected_option_id__question_options__id');

  $$QuestionOptionsTableProcessedTableManager? get selectedOptionId {
    final $_column = $_itemColumn<String>('selected_option_id');
    if ($_column == null) return null;
    final manager = $$QuestionOptionsTableTableManager(
      $_db,
      $_db.questionOptions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_selectedOptionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedMs => $composableBuilder(
    column: $table.elapsedMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studyMode => $composableBuilder(
    column: $table.studyMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get answeredAtMs => $composableBuilder(
    column: $table.answeredAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyItemsTableFilterComposer get studyItemId {
    final $$StudyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionOptionsTableFilterComposer get selectedOptionId {
    final $$QuestionOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.selectedOptionId,
      referencedTable: $db.questionOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionOptionsTableFilterComposer(
            $db: $db,
            $table: $db.questionOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedMs => $composableBuilder(
    column: $table.elapsedMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studyMode => $composableBuilder(
    column: $table.studyMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get answeredAtMs => $composableBuilder(
    column: $table.answeredAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyItemsTableOrderingComposer get studyItemId {
    final $$StudyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionOptionsTableOrderingComposer get selectedOptionId {
    final $$QuestionOptionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.selectedOptionId,
      referencedTable: $db.questionOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionOptionsTableOrderingComposer(
            $db: $db,
            $table: $db.questionOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<int> get elapsedMs =>
      $composableBuilder(column: $table.elapsedMs, builder: (column) => column);

  GeneratedColumn<String> get studyMode =>
      $composableBuilder(column: $table.studyMode, builder: (column) => column);

  GeneratedColumn<int> get answeredAtMs => $composableBuilder(
    column: $table.answeredAtMs,
    builder: (column) => column,
  );

  $$StudyItemsTableAnnotationComposer get studyItemId {
    final $$StudyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyItemId,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionOptionsTableAnnotationComposer get selectedOptionId {
    final $$QuestionOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.selectedOptionId,
      referencedTable: $db.questionOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questionOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewEventsTable,
          ReviewEvent,
          $$ReviewEventsTableFilterComposer,
          $$ReviewEventsTableOrderingComposer,
          $$ReviewEventsTableAnnotationComposer,
          $$ReviewEventsTableCreateCompanionBuilder,
          $$ReviewEventsTableUpdateCompanionBuilder,
          (ReviewEvent, $$ReviewEventsTableReferences),
          ReviewEvent,
          PrefetchHooks Function({
            bool studyItemId,
            bool questionId,
            bool selectedOptionId,
          })
        > {
  $$ReviewEventsTableTableManager(_$AppDatabase db, $ReviewEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyItemId = const Value.absent(),
                Value<String?> questionId = const Value.absent(),
                Value<String?> selectedOptionId = const Value.absent(),
                Value<int?> isCorrect = const Value.absent(),
                Value<int?> quality = const Value.absent(),
                Value<int?> elapsedMs = const Value.absent(),
                Value<String> studyMode = const Value.absent(),
                Value<int> answeredAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewEventsCompanion(
                id: id,
                studyItemId: studyItemId,
                questionId: questionId,
                selectedOptionId: selectedOptionId,
                isCorrect: isCorrect,
                quality: quality,
                elapsedMs: elapsedMs,
                studyMode: studyMode,
                answeredAtMs: answeredAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyItemId,
                Value<String?> questionId = const Value.absent(),
                Value<String?> selectedOptionId = const Value.absent(),
                Value<int?> isCorrect = const Value.absent(),
                Value<int?> quality = const Value.absent(),
                Value<int?> elapsedMs = const Value.absent(),
                required String studyMode,
                required int answeredAtMs,
                Value<int> rowid = const Value.absent(),
              }) => ReviewEventsCompanion.insert(
                id: id,
                studyItemId: studyItemId,
                questionId: questionId,
                selectedOptionId: selectedOptionId,
                isCorrect: isCorrect,
                quality: quality,
                elapsedMs: elapsedMs,
                studyMode: studyMode,
                answeredAtMs: answeredAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewEventsTable, ReviewEvent>(table),
                  $$ReviewEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyItemId = false,
                questionId = false,
                selectedOptionId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studyItemId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studyItemId,
                            referencedTable: $$ReviewEventsTableReferences
                                ._studyItemIdTable(db),
                            referencedColumn: $$ReviewEventsTableReferences
                                ._studyItemIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (questionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.questionId,
                            referencedTable: $$ReviewEventsTableReferences
                                ._questionIdTable(db),
                            referencedColumn: $$ReviewEventsTableReferences
                                ._questionIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (selectedOptionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.selectedOptionId,
                            referencedTable: $$ReviewEventsTableReferences
                                ._selectedOptionIdTable(db),
                            referencedColumn: $$ReviewEventsTableReferences
                                ._selectedOptionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ReviewEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewEventsTable,
      ReviewEvent,
      $$ReviewEventsTableFilterComposer,
      $$ReviewEventsTableOrderingComposer,
      $$ReviewEventsTableAnnotationComposer,
      $$ReviewEventsTableCreateCompanionBuilder,
      $$ReviewEventsTableUpdateCompanionBuilder,
      (ReviewEvent, $$ReviewEventsTableReferences),
      ReviewEvent,
      PrefetchHooks Function({
        bool studyItemId,
        bool questionId,
        bool selectedOptionId,
      })
    >;
typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      required String key,
      required String valueJson,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<String> key,
      Value<String> valueJson,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTable,
          UserSetting,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSetting,
            BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
          ),
          UserSetting,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> valueJson = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion(
                key: key,
                valueJson: valueJson,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String valueJson,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                key: key,
                valueJson: valueJson,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserSettingsTable, UserSetting>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserSettingsTable,
                    UserSetting
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTable,
      UserSetting,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSetting,
        BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
      ),
      UserSetting,
      PrefetchHooks Function()
    >;
typedef $$NotificationRulesTableCreateCompanionBuilder =
    NotificationRulesCompanion Function({
      required String id,
      required String ruleType,
      Value<int> enabled,
      required String timeOfDay,
      Value<int> weekdaysMask,
      Value<int> dailyCount,
      Value<String?> minCefr,
      Value<String?> maxCefr,
      Value<String?> tagFilterId,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$NotificationRulesTableUpdateCompanionBuilder =
    NotificationRulesCompanion Function({
      Value<String> id,
      Value<String> ruleType,
      Value<int> enabled,
      Value<String> timeOfDay,
      Value<int> weekdaysMask,
      Value<int> dailyCount,
      Value<String?> minCefr,
      Value<String?> maxCefr,
      Value<String?> tagFilterId,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

final class $$NotificationRulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NotificationRulesTable,
          NotificationRule
        > {
  $$NotificationRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TagsTable _tagFilterIdTable(_$AppDatabase db) =>
      db.tags.createAlias('notification_rules__tag_filter_id__tags__id');

  $$TagsTableProcessedTableManager? get tagFilterId {
    final $_column = $_itemColumn<String>('tag_filter_id');
    if ($_column == null) return null;
    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagFilterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotificationRulesTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationRulesTable> {
  $$NotificationRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyCount => $composableBuilder(
    column: $table.dailyCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get minCefr => $composableBuilder(
    column: $table.minCefr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maxCefr => $composableBuilder(
    column: $table.maxCefr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$TagsTableFilterComposer get tagFilterId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagFilterId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationRulesTable> {
  $$NotificationRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyCount => $composableBuilder(
    column: $table.dailyCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get minCefr => $composableBuilder(
    column: $table.minCefr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maxCefr => $composableBuilder(
    column: $table.maxCefr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$TagsTableOrderingComposer get tagFilterId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagFilterId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationRulesTable> {
  $$NotificationRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<int> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyCount => $composableBuilder(
    column: $table.dailyCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get minCefr =>
      $composableBuilder(column: $table.minCefr, builder: (column) => column);

  GeneratedColumn<String> get maxCefr =>
      $composableBuilder(column: $table.maxCefr, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  $$TagsTableAnnotationComposer get tagFilterId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagFilterId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationRulesTable,
          NotificationRule,
          $$NotificationRulesTableFilterComposer,
          $$NotificationRulesTableOrderingComposer,
          $$NotificationRulesTableAnnotationComposer,
          $$NotificationRulesTableCreateCompanionBuilder,
          $$NotificationRulesTableUpdateCompanionBuilder,
          (NotificationRule, $$NotificationRulesTableReferences),
          NotificationRule,
          PrefetchHooks Function({bool tagFilterId})
        > {
  $$NotificationRulesTableTableManager(
    _$AppDatabase db,
    $NotificationRulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationRulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<int> enabled = const Value.absent(),
                Value<String> timeOfDay = const Value.absent(),
                Value<int> weekdaysMask = const Value.absent(),
                Value<int> dailyCount = const Value.absent(),
                Value<String?> minCefr = const Value.absent(),
                Value<String?> maxCefr = const Value.absent(),
                Value<String?> tagFilterId = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationRulesCompanion(
                id: id,
                ruleType: ruleType,
                enabled: enabled,
                timeOfDay: timeOfDay,
                weekdaysMask: weekdaysMask,
                dailyCount: dailyCount,
                minCefr: minCefr,
                maxCefr: maxCefr,
                tagFilterId: tagFilterId,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ruleType,
                Value<int> enabled = const Value.absent(),
                required String timeOfDay,
                Value<int> weekdaysMask = const Value.absent(),
                Value<int> dailyCount = const Value.absent(),
                Value<String?> minCefr = const Value.absent(),
                Value<String?> maxCefr = const Value.absent(),
                Value<String?> tagFilterId = const Value.absent(),
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => NotificationRulesCompanion.insert(
                id: id,
                ruleType: ruleType,
                enabled: enabled,
                timeOfDay: timeOfDay,
                weekdaysMask: weekdaysMask,
                dailyCount: dailyCount,
                minCefr: minCefr,
                maxCefr: maxCefr,
                tagFilterId: tagFilterId,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationRulesTable, NotificationRule>(table),
                  $$NotificationRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tagFilterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tagFilterId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagFilterId,
                        referencedTable: $$NotificationRulesTableReferences
                            ._tagFilterIdTable(db),
                        referencedColumn: $$NotificationRulesTableReferences
                            ._tagFilterIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotificationRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationRulesTable,
      NotificationRule,
      $$NotificationRulesTableFilterComposer,
      $$NotificationRulesTableOrderingComposer,
      $$NotificationRulesTableAnnotationComposer,
      $$NotificationRulesTableCreateCompanionBuilder,
      $$NotificationRulesTableUpdateCompanionBuilder,
      (NotificationRule, $$NotificationRulesTableReferences),
      NotificationRule,
      PrefetchHooks Function({bool tagFilterId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HeadwordsTableTableManager get headwords =>
      $$HeadwordsTableTableManager(_db, _db.headwords);
  $$StudyItemsTableTableManager get studyItems =>
      $$StudyItemsTableTableManager(_db, _db.studyItems);
  $$SensesTableTableManager get senses =>
      $$SensesTableTableManager(_db, _db.senses);
  $$PhrasesTableTableManager get phrases =>
      $$PhrasesTableTableManager(_db, _db.phrases);
  $$PhraseSensesTableTableManager get phraseSenses =>
      $$PhraseSensesTableTableManager(_db, _db.phraseSenses);
  $$PronunciationsTableTableManager get pronunciations =>
      $$PronunciationsTableTableManager(_db, _db.pronunciations);
  $$InflectionsTableTableManager get inflections =>
      $$InflectionsTableTableManager(_db, _db.inflections);
  $$ContentSourcesTableTableManager get contentSources =>
      $$ContentSourcesTableTableManager(_db, _db.contentSources);
  $$SourceAttributionsTableTableManager get sourceAttributions =>
      $$SourceAttributionsTableTableManager(_db, _db.sourceAttributions);
  $$ExamplesTableTableManager get examples =>
      $$ExamplesTableTableManager(_db, _db.examples);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$ItemTagsTableTableManager get itemTags =>
      $$ItemTagsTableTableManager(_db, _db.itemTags);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$QuestionOptionsTableTableManager get questionOptions =>
      $$QuestionOptionsTableTableManager(_db, _db.questionOptions);
  $$LearningProgressTableTableManager get learningProgress =>
      $$LearningProgressTableTableManager(_db, _db.learningProgress);
  $$ReviewEventsTableTableManager get reviewEvents =>
      $$ReviewEventsTableTableManager(_db, _db.reviewEvents);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$NotificationRulesTableTableManager get notificationRules =>
      $$NotificationRulesTableTableManager(_db, _db.notificationRules);
}
