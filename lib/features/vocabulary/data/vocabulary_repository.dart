import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/models/vocabulary_models.dart';

class VocabularyRepository {
  final AppDatabase db;
  final _uuid = const Uuid();

  VocabularyRepository(this.db);

  Stream<List<Headword>> watchHeadwords(VocabularyFilter filter) {
    return _buildHeadwordsQuery(filter).watch();
  }

  Future<List<Headword>> searchHeadwords(VocabularyFilter filter) {
    return _buildHeadwordsQuery(filter).get();
  }

  SimpleSelectStatement<$HeadwordsTable, Headword> _buildHeadwordsQuery(
    VocabularyFilter filter,
  ) {
    final query = db.select(db.headwords);

    query.where((tbl) {
      final List<Expression<bool>> predicates = [];

      predicates.add(tbl.isArchived.equals(filter.onlyArchived ? 1 : 0));

      if (filter.query != null && filter.query!.trim().isNotEmpty) {
        final rawTerm = filter.query!.trim().toLowerCase();
        final searchPattern = '%$rawTerm%';

        // Subquery: matching senses definition_en or meaning_vi
        final matchingSenseHwIds = db.selectOnly(db.senses)
          ..addColumns([db.senses.headwordId])
          ..where(
            db.senses.definitionEn.lower().like(searchPattern) |
                db.senses.meaningVi.lower().like(searchPattern),
          );

        predicates.add(
          tbl.normalizedSpelling.like(searchPattern) |
              tbl.id.isInQuery(matchingSenseHwIds),
        );
      }

      if (filter.cefrLevels.isNotEmpty) {
        final hwMatchingCefr = db.selectOnly(db.senses)
          ..addColumns([db.senses.headwordId])
          ..where(db.senses.cefrLevel.isIn(filter.cefrLevels));

        predicates.add(tbl.id.isInQuery(hwMatchingCefr));
      }

      if (filter.partsOfSpeech.isNotEmpty) {
        final hwMatchingPos = db.selectOnly(db.senses)
          ..addColumns([db.senses.headwordId])
          ..where(db.senses.partOfSpeech.isIn(filter.partsOfSpeech));

        predicates.add(tbl.id.isInQuery(hwMatchingPos));
      }

      if (filter.tagIds.isNotEmpty) {
        final senseIdsWithTags = db.selectOnly(db.itemTags)
          ..addColumns([db.itemTags.studyItemId])
          ..where(db.itemTags.tagId.isIn(filter.tagIds));

        final hwWithTags = db.selectOnly(db.senses)
          ..addColumns([db.senses.headwordId])
          ..where(db.senses.id.isInQuery(senseIdsWithTags));

        predicates.add(tbl.id.isInQuery(hwWithTags));
      }

      if (filter.isFavorite != null) {
        final favSenseIds = db.selectOnly(db.learningProgress)
          ..addColumns([db.learningProgress.studyItemId])
          ..where(
            db.learningProgress.isFavorite.equals(filter.isFavorite! ? 1 : 0),
          );

        final hwWithFav = db.selectOnly(db.senses)
          ..addColumns([db.senses.headwordId])
          ..where(db.senses.id.isInQuery(favSenseIds));

        predicates.add(tbl.id.isInQuery(hwWithFav));
      }

      return Expression.and(predicates);
    });

    query.orderBy([(tbl) => OrderingTerm(expression: tbl.spelling)]);
    return query;
  }

  Future<HeadwordDetail?> getHeadwordDetail(String id) async {
    final headword = await (db.select(
      db.headwords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (headword == null) return null;

    final pronunciations = await (db.select(
      db.pronunciations,
    )..where((tbl) => tbl.headwordId.equals(id))).get();
    final inflections = await (db.select(
      db.inflections,
    )..where((tbl) => tbl.headwordId.equals(id))).get();

    final sensesRows =
        await (db.select(db.senses)
              ..where((tbl) => tbl.headwordId.equals(id))
              ..orderBy([(s) => OrderingTerm(expression: s.senseNumber)]))
            .get();

    final List<SenseDetail> senseDetails = [];

    for (final s in sensesRows) {
      final examples =
          await (db.select(db.examples)
                ..where((tbl) => tbl.studyItemId.equals(s.id))
                ..orderBy([(e) => OrderingTerm(expression: e.sortOrder)]))
              .get();

      final itemTagsRows = await (db.select(
        db.itemTags,
      )..where((tbl) => tbl.studyItemId.equals(s.id))).get();
      final tagIds = itemTagsRows.map((it) => it.tagId).toList();

      final tags = tagIds.isEmpty
          ? <Tag>[]
          : await (db.select(
              db.tags,
            )..where((tbl) => tbl.id.isIn(tagIds))).get();

      final progress = await (db.select(
        db.learningProgress,
      )..where((tbl) => tbl.studyItemId.equals(s.id))).getSingleOrNull();

      senseDetails.add(
        SenseDetail(
          sense: s,
          examples: examples,
          tags: tags,
          progress: progress,
        ),
      );
    }

    return HeadwordDetail(
      headword: headword,
      pronunciations: pronunciations,
      inflections: inflections,
      senses: senseDetails,
    );
  }

  Future<String> saveHeadword(HeadwordDetail detail) async {
    final spelling = detail.headword.spelling.trim();
    if (spelling.isEmpty) {
      throw ArgumentError('Từ vựng không được để trống.');
    }
    final normalized = spelling.toLowerCase();
    final now = DateTime.now().millisecondsSinceEpoch;
    final hwId = detail.headword.id.trim().isEmpty
        ? _uuid.v4()
        : detail.headword.id;

    if (detail.senses.isEmpty) {
      throw ArgumentError('Mỗi từ vựng phải có ít nhất một nét nghĩa (sense).');
    }

    for (final s in detail.senses) {
      if (s.sense.partOfSpeech.trim().isEmpty) {
        throw ArgumentError('Mỗi nghĩa phải có từ loại (Part of Speech).');
      }
      if (s.sense.definitionEn.trim().isEmpty) {
        throw ArgumentError(
          'Định nghĩa tiếng Anh (definition_en) là bắt buộc cho mỗi nghĩa.',
        );
      }
    }

    await db.transaction(() async {
      await db
          .into(db.headwords)
          .insertOnConflictUpdate(
            HeadwordsCompanion.insert(
              id: hwId,
              spelling: spelling,
              normalizedSpelling: normalized,
              homographNo: Value(detail.headword.homographNo),
              cefrLevel: Value(detail.headword.cefrLevel),
              notes: Value(detail.headword.notes),
              isArchived: Value(detail.headword.isArchived),
              createdAtMs: detail.headword.createdAtMs == 0
                  ? now
                  : detail.headword.createdAtMs,
              updatedAtMs: now,
            ),
          );

      // Clean existing pronunciations & inflections for full overwrite
      await (db.delete(
        db.pronunciations,
      )..where((p) => p.headwordId.equals(hwId))).go();
      for (final p in detail.pronunciations) {
        await db
            .into(db.pronunciations)
            .insert(
              PronunciationsCompanion.insert(
                id: p.id.trim().isEmpty ? _uuid.v4() : p.id,
                headwordId: Value(hwId),
                accent: p.accent,
                ipa: Value(p.ipa),
                audioAssetKey: Value(p.audioAssetKey),
                sourceNote: Value(p.sourceNote),
                licenceNote: Value(p.licenceNote),
              ),
            );
      }

      await (db.delete(
        db.inflections,
      )..where((inf) => inf.headwordId.equals(hwId))).go();
      for (final inf in detail.inflections) {
        await db
            .into(db.inflections)
            .insert(
              InflectionsCompanion.insert(
                id: inf.id.trim().isEmpty ? _uuid.v4() : inf.id,
                headwordId: hwId,
                form: inf.form.trim(),
                formType: inf.formType.trim(),
              ),
            );
      }

      // Senses handling
      final existingSenses = await (db.select(
        db.senses,
      )..where((s) => s.headwordId.equals(hwId))).get();
      final existingSenseIds = existingSenses.map((s) => s.id).toSet();
      final newSenseIds = detail.senses
          .map((s) => s.sense.id)
          .where((id) => id.isNotEmpty)
          .toSet();

      // Delete removed senses
      final sensesToDelete = existingSenseIds.difference(newSenseIds);
      for (final senseId in sensesToDelete) {
        await (db.delete(db.senses)..where((s) => s.id.equals(senseId))).go();
      }

      int senseNumber = 1;
      for (final s in detail.senses) {
        final senseId = s.sense.id.trim().isEmpty ? _uuid.v4() : s.sense.id;

        // Ensure study item exists
        await db
            .into(db.studyItems)
            .insertOnConflictUpdate(
              StudyItemsCompanion.insert(
                id: senseId,
                itemType: 'sense',
                createdAtMs: now,
              ),
            );

        await db
            .into(db.senses)
            .insertOnConflictUpdate(
              SensesCompanion.insert(
                id: senseId,
                headwordId: hwId,
                senseNumber: senseNumber++,
                partOfSpeech: s.sense.partOfSpeech.trim(),
                definitionEn: s.sense.definitionEn.trim(),
                meaningVi: Value(s.sense.meaningVi?.trim()),
                cefrLevel: Value(s.sense.cefrLevel?.trim()),
                registerLabel: Value(s.sense.registerLabel?.trim()),
                domainLabel: Value(s.sense.domainLabel?.trim()),
                grammarNote: Value(s.sense.grammarNote?.trim()),
                usageNote: Value(s.sense.usageNote?.trim()),
                isActive: Value(s.sense.isActive),
              ),
            );

        // Tags
        await (db.delete(
          db.itemTags,
        )..where((it) => it.studyItemId.equals(senseId))).go();
        for (final tag in s.tags) {
          await db
              .into(db.itemTags)
              .insertOnConflictUpdate(
                ItemTagsCompanion.insert(studyItemId: senseId, tagId: tag.id),
              );
        }

        // Examples
        await (db.delete(
          db.examples,
        )..where((e) => e.studyItemId.equals(senseId))).go();
        int exampleSort = 1;
        for (final ex in s.examples) {
          if (ex.englishText.trim().isEmpty) continue;
          await db
              .into(db.examples)
              .insert(
                ExamplesCompanion.insert(
                  id: ex.id.trim().isEmpty ? _uuid.v4() : ex.id,
                  studyItemId: senseId,
                  englishText: ex.englishText.trim(),
                  vietnameseText: Value(ex.vietnameseText?.trim()),
                  note: Value(ex.note?.trim()),
                  sortOrder: Value(exampleSort++),
                ),
              );
        }

        // Initialize progress if not existing
        final existingProgress = await (db.select(
          db.learningProgress,
        )..where((p) => p.studyItemId.equals(senseId))).getSingleOrNull();
        if (existingProgress == null) {
          await db
              .into(db.learningProgress)
              .insert(
                LearningProgressCompanion.insert(
                  studyItemId: senseId,
                  status: 'new',
                  repetitionCount: const Value(0),
                  intervalDays: const Value(0.0),
                  easeFactor: const Value(2.5),
                  lapses: const Value(0),
                  dueAtMs: const Value(null),
                  lastReviewedAtMs: const Value(null),
                  totalCorrect: const Value(0),
                  totalIncorrect: const Value(0),
                  isFavorite: const Value(0),
                  updatedAtMs: now,
                ),
              );
        }
      }
    });

    return hwId;
  }

  Future<void> archiveHeadword(String id, bool archive) async {
    await (db.update(db.headwords)..where((h) => h.id.equals(id))).write(
      HeadwordsCompanion(
        isArchived: Value(archive ? 1 : 0),
        updatedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<int> deleteHeadword(String id) async {
    return (db.delete(db.headwords)..where((h) => h.id.equals(id))).go();
  }

  Future<void> toggleFavorite(String studyItemId) async {
    final progress = await (db.select(
      db.learningProgress,
    )..where((p) => p.studyItemId.equals(studyItemId))).getSingleOrNull();
    final now = DateTime.now().millisecondsSinceEpoch;

    if (progress == null) {
      await db
          .into(db.learningProgress)
          .insert(
            LearningProgressCompanion.insert(
              studyItemId: studyItemId,
              status: 'new',
              isFavorite: const Value(1),
              updatedAtMs: now,
            ),
          );
    } else {
      final newFav = progress.isFavorite == 1 ? 0 : 1;
      await (db.update(
        db.learningProgress,
      )..where((p) => p.studyItemId.equals(studyItemId))).write(
        LearningProgressCompanion(
          isFavorite: Value(newFav),
          updatedAtMs: Value(now),
        ),
      );
    }
  }
}
