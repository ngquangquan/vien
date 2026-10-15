import '../../../../core/database/app_database.dart';

class SenseDetail {
  final Sense sense;
  final List<Example> examples;
  final List<Tag> tags;
  final LearningProgressData? progress;

  const SenseDetail({
    required this.sense,
    this.examples = const [],
    this.tags = const [],
    this.progress,
  });

  SenseDetail copyWith({
    Sense? sense,
    List<Example>? examples,
    List<Tag>? tags,
    LearningProgressData? progress,
  }) {
    return SenseDetail(
      sense: sense ?? this.sense,
      examples: examples ?? this.examples,
      tags: tags ?? this.tags,
      progress: progress ?? this.progress,
    );
  }
}

class HeadwordDetail {
  final Headword headword;
  final List<Pronunciation> pronunciations;
  final List<Inflection> inflections;
  final List<SenseDetail> senses;

  const HeadwordDetail({
    required this.headword,
    this.pronunciations = const [],
    this.inflections = const [],
    this.senses = const [],
  });
}

class VocabularyFilter {
  final String? query;
  final List<String> cefrLevels;
  final List<String> partsOfSpeech;
  final List<String> tagIds;
  final bool? isFavorite;
  final bool onlyArchived;

  const VocabularyFilter({
    this.query,
    this.cefrLevels = const [],
    this.partsOfSpeech = const [],
    this.tagIds = const [],
    this.isFavorite,
    this.onlyArchived = false,
  });

  bool get hasActiveFilter =>
      (query != null && query!.trim().isNotEmpty) ||
      cefrLevels.isNotEmpty ||
      partsOfSpeech.isNotEmpty ||
      tagIds.isNotEmpty ||
      isFavorite != null ||
      onlyArchived;
}
