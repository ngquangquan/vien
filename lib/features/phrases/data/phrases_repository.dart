import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/models/phrase_models.dart';

class PhrasesRepository {
  final AppDatabase db;
  final _uuid = const Uuid();

  PhrasesRepository(this.db);

  Stream<List<Phrase>> watchPhrases(PhraseFilter filter) {
    return _buildPhrasesQuery(filter).watch();
  }

  Future<List<Phrase>> searchPhrases(PhraseFilter filter) {
    return _buildPhrasesQuery(filter).get();
  }

  SimpleSelectStatement<$PhrasesTable, Phrase> _buildPhrasesQuery(
    PhraseFilter filter,
  ) {
    final query = db.select(db.phrases);

    query.where((tbl) {
      final List<Expression<bool>> predicates = [];

      predicates.add(tbl.isArchived.equals(filter.onlyArchived ? 1 : 0));

      if (filter.phraseTypes.isNotEmpty) {
        predicates.add(tbl.phraseType.isIn(filter.phraseTypes));
      }

      if (filter.query != null && filter.query!.trim().isNotEmpty) {
        final rawTerm = filter.query!.trim().toLowerCase();
        final searchPattern = '%$rawTerm%';

        final matchingSensePhraseIds = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(
            db.phraseSenses.definitionEn.lower().like(searchPattern) |
                db.phraseSenses.meaningVi.lower().like(searchPattern),
          );

        predicates.add(
          tbl.normalizedPhrase.like(searchPattern) |
              tbl.id.isInQuery(matchingSensePhraseIds),
        );
      }

      if (filter.cefrLevels.isNotEmpty) {
        final phraseMatchingCefr = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(db.phraseSenses.cefrLevel.isIn(filter.cefrLevels));

        predicates.add(tbl.id.isInQuery(phraseMatchingCefr));
      }

      if (filter.tagIds.isNotEmpty) {
        final senseIdsWithTags = db.selectOnly(db.itemTags)
          ..addColumns([db.itemTags.studyItemId])
          ..where(db.itemTags.tagId.isIn(filter.tagIds));

        final phrasesWithTags = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(db.phraseSenses.id.isInQuery(senseIdsWithTags));

        predicates.add(tbl.id.isInQuery(phrasesWithTags));
      }

      if (filter.isFavorite != null) {
        final favSenseIds = db.selectOnly(db.learningProgress)
          ..addColumns([db.learningProgress.studyItemId])
          ..where(
            db.learningProgress.isFavorite.equals(filter.isFavorite! ? 1 : 0),
          );

        final phrasesWithFav = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(db.phraseSenses.id.isInQuery(favSenseIds));

        predicates.add(tbl.id.isInQuery(phrasesWithFav));
      }

      return Expression.and(predicates);
    });

    query.orderBy([(tbl) => OrderingTerm(expression: tbl.phrase)]);
    return query;
  }

  Future<PhraseDetail?> getPhraseDetail(String id) async {
    final phrase = await (db.select(
      db.phrases,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (phrase == null) return null;

    final sensesRows =
        await (db.select(db.phraseSenses)
              ..where((tbl) => tbl.phraseId.equals(id))
              ..orderBy([(s) => OrderingTerm(expression: s.senseNumber)]))
            .get();

    final List<PhraseSenseDetail> senseDetails = [];

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
        PhraseSenseDetail(
          sense: s,
          examples: examples,
          tags: tags,
          progress: progress,
        ),
      );
    }

    return PhraseDetail(phrase: phrase, senses: senseDetails);
  }

  Future<String> savePhrase(PhraseDetail detail) async {
    final text = detail.phrase.phrase.trim();
    if (text.isEmpty) {
      throw ArgumentError('Cụm từ / thành ngữ không được để trống.');
    }
    final normalized = text.toLowerCase();
    final now = DateTime.now().millisecondsSinceEpoch;
    final phraseId = detail.phrase.id.trim().isEmpty
        ? _uuid.v4()
        : detail.phrase.id;

    if (detail.senses.isEmpty) {
      throw ArgumentError('Mỗi cụm từ phải có ít nhất một định nghĩa.');
    }

    for (final s in detail.senses) {
      if (s.sense.definitionEn.trim().isEmpty) {
        throw ArgumentError(
          'Định nghĩa tiếng Anh (definition_en) là bắt buộc cho mỗi nghĩa.',
        );
      }
    }

    await db.transaction(() async {
      await db
          .into(db.phrases)
          .insertOnConflictUpdate(
            PhrasesCompanion.insert(
              id: phraseId,
              phrase: text,
              normalizedPhrase: normalized,
              phraseType: detail.phrase.phraseType,
              cefrLevel: Value(detail.phrase.cefrLevel),
              notes: Value(detail.phrase.notes),
              isArchived: Value(detail.phrase.isArchived),
              createdAtMs: detail.phrase.createdAtMs == 0
                  ? now
                  : detail.phrase.createdAtMs,
              updatedAtMs: now,
            ),
          );

      // Senses handling
      final existingSenses = await (db.select(
        db.phraseSenses,
      )..where((s) => s.phraseId.equals(phraseId))).get();
      final existingSenseIds = existingSenses.map((s) => s.id).toSet();
      final newSenseIds = detail.senses
          .map((s) => s.sense.id)
          .where((id) => id.isNotEmpty)
          .toSet();

      final sensesToDelete = existingSenseIds.difference(newSenseIds);
      for (final senseId in sensesToDelete) {
        await (db.delete(
          db.phraseSenses,
        )..where((s) => s.id.equals(senseId))).go();
      }

      int senseNumber = 1;
      for (final s in detail.senses) {
        final senseId = s.sense.id.trim().isEmpty ? _uuid.v4() : s.sense.id;

        await db
            .into(db.studyItems)
            .insertOnConflictUpdate(
              StudyItemsCompanion.insert(
                id: senseId,
                itemType: 'phrase_sense',
                createdAtMs: now,
              ),
            );

        await db
            .into(db.phraseSenses)
            .insertOnConflictUpdate(
              PhraseSensesCompanion.insert(
                id: senseId,
                phraseId: phraseId,
                senseNumber: Value(senseNumber++),
                partOfSpeech: Value(s.sense.partOfSpeech?.trim()),
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

    return phraseId;
  }

  Future<void> archivePhrase(String id, bool archive) async {
    await (db.update(db.phrases)..where((p) => p.id.equals(id))).write(
      PhrasesCompanion(
        isArchived: Value(archive ? 1 : 0),
        updatedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<int> deletePhrase(String id) async {
    return (db.delete(db.phrases)..where((p) => p.id.equals(id))).go();
  }
}
