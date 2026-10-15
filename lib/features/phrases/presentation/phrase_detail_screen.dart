import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/widgets/cefr_badge.dart';
import '../data/phrases_repository.dart';
import '../domain/models/phrase_models.dart';
import 'phrase_form_screen.dart';

class PhraseDetailScreen extends StatefulWidget {
  final String phraseId;
  final PhrasesRepository phrasesRepo;

  const PhraseDetailScreen({
    super.key,
    required this.phraseId,
    required this.phrasesRepo,
  });

  @override
  State<PhraseDetailScreen> createState() => _PhraseDetailScreenState();
}

class _PhraseDetailScreenState extends State<PhraseDetailScreen> {
  late Future<PhraseDetail?> _detailFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() {
      _detailFuture = widget.phrasesRepo.getPhraseDetail(widget.phraseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PhraseDetail?>(
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
            body: const Center(child: Text('Không tìm thấy cụm từ này.')),
          );
        }

        final phr = detail.phrase;

        return Scaffold(
          appBar: AppBar(
            title: Text(phr.phrase),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Chỉnh sửa',
                onPressed: () async {
                  final updated = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => PhraseFormScreen(
                        phrasesRepo: widget.phrasesRepo,
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
                    final shouldArchive = phr.isArchived == 0;
                    await widget.phrasesRepo.archivePhrase(
                      phr.id,
                      shouldArchive,
                    );
                    if (!mounted) return;
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          shouldArchive ? 'Đã lưu trữ.' : 'Đã bỏ lưu trữ.',
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
                          'Bạn có chắc chắn muốn xóa "${phr.phrase}"?',
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
                      await widget.phrasesRepo.deletePhrase(phr.id);
                      if (!mounted) return;
                      messenger.showSnackBar(
                        const SnackBar(content: Text('Đã xóa cụm từ.')),
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
                          phr.isArchived == 1
                              ? Icons.unarchive_outlined
                              : Icons.archive_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(phr.isArchived == 1 ? 'Bỏ lưu trữ' : 'Lưu trữ'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text('Xóa cụm từ', style: TextStyle(color: Colors.red)),
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
                              phr.phrase,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CefrBadge(level: phr.cefrLevel, fontSize: 14),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          phr.phraseType.toUpperCase(),
                          style: const TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (phr.notes != null && phr.notes!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          phr.notes!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'Ý nghĩa & Ví dụ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ...detail.senses.map((s) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (s.sense.partOfSpeech != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F172A),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  s.sense.partOfSpeech!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            if (s.sense.partOfSpeech != null)
                              const SizedBox(width: 8),
                            CefrBadge(level: s.sense.cefrLevel),
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
                        if (s.sense.meaningVi != null) ...[
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
                        if (s.sense.usageNote != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Ghi chú: ${s.sense.usageNote}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
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
                                    ),
                                  ),
                                  if (ex.vietnameseText != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        ex.vietnameseText!,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
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
