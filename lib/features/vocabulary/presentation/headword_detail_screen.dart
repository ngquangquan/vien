import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/widgets/cefr_badge.dart';
import '../data/vocabulary_repository.dart';
import '../domain/models/vocabulary_models.dart';
import 'headword_form_screen.dart';

class HeadwordDetailScreen extends StatefulWidget {
  final String headwordId;
  final VocabularyRepository vocabRepo;

  const HeadwordDetailScreen({
    super.key,
    required this.headwordId,
    required this.vocabRepo,
  });

  @override
  State<HeadwordDetailScreen> createState() => _HeadwordDetailScreenState();
}

class _HeadwordDetailScreenState extends State<HeadwordDetailScreen> {
  late Future<HeadwordDetail?> _detailFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() {
      _detailFuture = widget.vocabRepo.getHeadwordDetail(widget.headwordId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HeadwordDetail?>(
      future: _detailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final detail = snapshot.data;
        if (detail == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Không tìm thấy từ vựng này.')),
          );
        }

        final hw = detail.headword;

        return Scaffold(
          appBar: AppBar(
            title: Text(hw.spelling),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Chỉnh sửa',
                onPressed: () async {
                  final updated = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HeadwordFormScreen(
                        vocabRepo: widget.vocabRepo,
                        initialDetail: detail,
                      ),
                    ),
                  );
                  if (updated == true) _load();
                },
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  final messenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);

                  if (value == 'archive') {
                    final shouldArchive = hw.isArchived == 0;
                    await widget.vocabRepo.archiveHeadword(
                      hw.id,
                      shouldArchive,
                    );
                    if (!mounted) return;
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          shouldArchive
                              ? 'Đã lưu trữ từ này.'
                              : 'Đã bỏ lưu trữ.',
                        ),
                      ),
                    );
                    navigator.pop(true);
                  } else if (value == 'delete') {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Xác nhận xóa'),
                        content: Text(
                          'Bạn có chắc chắn muốn xóa "${hw.spelling}" cùng toàn bộ nghĩa và ví dụ?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Hủy'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Xóa'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      await widget.vocabRepo.deleteHeadword(hw.id);
                      if (!mounted) return;
                      messenger.showSnackBar(
                        const SnackBar(content: Text('Đã xóa từ vựng.')),
                      );
                      navigator.pop(true);
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'archive',
                    child: Row(
                      children: [
                        Icon(
                          hw.isArchived == 1
                              ? Icons.unarchive_outlined
                              : Icons.archive_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(hw.isArchived == 1 ? 'Bỏ lưu trữ' : 'Lưu trữ'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text('Xóa từ', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              hw.spelling,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CefrBadge(level: hw.cefrLevel, fontSize: 14),
                        ],
                      ),
                      if (detail.pronunciations.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          children: detail.pronunciations.map((p) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  p.accent.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  p.ipa ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                      if (detail.inflections.isNotEmpty) ...[
                        const Divider(height: 24),
                        const Text(
                          'Biến thể từ:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 8,
                          children: detail.inflections.map((inf) {
                            return Chip(
                              label: Text(
                                '${inf.form} (${inf.formType})',
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: const Color(0xFFF1F5F9),
                              padding: EdgeInsets.zero,
                            );
                          }).toList(),
                        ),
                      ],
                      if (hw.notes != null && hw.notes!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          hw.notes!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Các nét nghĩa (Senses)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${detail.senses.length}',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ...detail.senses.map((s) {
                final isFav = s.progress?.isFavorite == 1;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                s.sense.partOfSpeech.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            CefrBadge(level: s.sense.cefrLevel),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                                size: 20,
                              ),
                              onPressed: () async {
                                await widget.vocabRepo.toggleFavorite(
                                  s.sense.id,
                                );
                                _load();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          s.sense.definitionEn,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (s.sense.meaningVi != null &&
                            s.sense.meaningVi!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            s.sense.meaningVi!,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        if (s.sense.grammarNote != null ||
                            s.sense.usageNote != null) ...[
                          const SizedBox(height: 8),
                          if (s.sense.grammarNote != null)
                            Text(
                              'Ngữ pháp: ${s.sense.grammarNote}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          if (s.sense.usageNote != null)
                            Text(
                              'Cách dùng: ${s.sense.usageNote}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                        if (s.tags.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            children: s.tags.map((t) {
                              return Chip(
                                label: Text(
                                  t.name,
                                  style: const TextStyle(fontSize: 11),
                                ),
                                backgroundColor: const Color(0xFFE2E8F0),
                                padding: EdgeInsets.zero,
                              );
                            }).toList(),
                          ),
                        ],
                        if (s.examples.isNotEmpty) ...[
                          const Divider(height: 20),
                          const Text(
                            'Ví dụ minh họa:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...s.examples.map((ex) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• ${ex.englishText}',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (ex.vietnameseText != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        ex.vietnameseText!,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
