import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/responsive.dart';
import '../data/vocabulary_repository.dart';
import '../domain/models/vocabulary_models.dart';

class HeadwordFormScreen extends StatefulWidget {
  final VocabularyRepository vocabRepo;
  final HeadwordDetail? initialDetail;

  const HeadwordFormScreen({
    super.key,
    required this.vocabRepo,
    this.initialDetail,
  });

  @override
  State<HeadwordFormScreen> createState() => _HeadwordFormScreenState();
}

class _SenseFormItem {
  String id;
  String partOfSpeech;
  String? cefrLevel;
  final TextEditingController definitionEnCtrl;
  final TextEditingController meaningViCtrl;
  final TextEditingController grammarNoteCtrl;
  final List<_ExampleFormItem> examples;

  _SenseFormItem({
    required this.id,
    required this.partOfSpeech,
    this.cefrLevel,
    required String definitionEn,
    String? meaningVi,
    String? grammarNote,
    List<_ExampleFormItem>? examples,
  }) : definitionEnCtrl = TextEditingController(text: definitionEn),
       meaningViCtrl = TextEditingController(text: meaningVi ?? ''),
       grammarNoteCtrl = TextEditingController(text: grammarNote ?? ''),
       examples = examples ?? [_ExampleFormItem()];

  void dispose() {
    definitionEnCtrl.dispose();
    meaningViCtrl.dispose();
    grammarNoteCtrl.dispose();
    for (final ex in examples) {
      ex.dispose();
    }
  }
}

class _ExampleFormItem {
  String id;
  final TextEditingController englishCtrl;
  final TextEditingController vietnameseCtrl;

  _ExampleFormItem({this.id = '', String english = '', String vietnamese = ''})
    : englishCtrl = TextEditingController(text: english),
      vietnameseCtrl = TextEditingController(text: vietnamese);

  void dispose() {
    englishCtrl.dispose();
    vietnameseCtrl.dispose();
  }
}

class _HeadwordFormScreenState extends State<HeadwordFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _spellingCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String? _overallCefr;
  final List<_SenseFormItem> _senses = [];
  bool _isSaving = false;

  final List<String> _posOptions = [
    'noun',
    'verb',
    'adjective',
    'adverb',
    'preposition',
    'pronoun',
    'conjunction',
    'interjection',
    'idiom',
    'other',
  ];

  final List<String> _cefrOptions = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  @override
  void initState() {
    super.initState();
    if (widget.initialDetail != null) {
      final hw = widget.initialDetail!.headword;
      _spellingCtrl.text = hw.spelling;
      _notesCtrl.text = hw.notes ?? '';
      _overallCefr = hw.cefrLevel;

      for (final s in widget.initialDetail!.senses) {
        _senses.add(
          _SenseFormItem(
            id: s.sense.id,
            partOfSpeech: s.sense.partOfSpeech,
            cefrLevel: s.sense.cefrLevel,
            definitionEn: s.sense.definitionEn,
            meaningVi: s.sense.meaningVi,
            grammarNote: s.sense.grammarNote,
            examples: s.examples
                .map(
                  (e) => _ExampleFormItem(
                    id: e.id,
                    english: e.englishText,
                    vietnamese: e.vietnameseText ?? '',
                  ),
                )
                .toList(),
          ),
        );
      }
    } else {
      _senses.add(
        _SenseFormItem(id: '', partOfSpeech: 'noun', definitionEn: ''),
      );
    }
  }

  @override
  void dispose() {
    _spellingCtrl.dispose();
    _notesCtrl.dispose();
    for (final s in _senses) {
      s.dispose();
    }
    super.dispose();
  }

  void _addSense() {
    setState(() {
      _senses.add(
        _SenseFormItem(id: '', partOfSpeech: 'noun', definitionEn: ''),
      );
    });
  }

  void _removeSense(int index) {
    if (_senses.length <= 1) return;
    setState(() {
      final removed = _senses.removeAt(index);
      removed.dispose();
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final sensesDetail = _senses.asMap().entries.map((entry) {
        final idx = entry.key;
        final s = entry.value;

        final examples = s.examples
            .where((e) => e.englishCtrl.text.trim().isNotEmpty)
            .map(
              (e) => Example(
                id: e.id,
                studyItemId: s.id,
                englishText: e.englishCtrl.text.trim(),
                vietnameseText: e.vietnameseCtrl.text.trim().isEmpty
                    ? null
                    : e.vietnameseCtrl.text.trim(),
                note: null,
                audioAssetKey: null,
                sortOrder: 1,
                sourceId: null,
              ),
            )
            .toList();

        return SenseDetail(
          sense: Sense(
            id: s.id,
            headwordId: widget.initialDetail?.headword.id ?? '',
            senseNumber: idx + 1,
            partOfSpeech: s.partOfSpeech,
            definitionEn: s.definitionEnCtrl.text.trim(),
            meaningVi: s.meaningViCtrl.text.trim().isEmpty
                ? null
                : s.meaningViCtrl.text.trim(),
            cefrLevel: s.cefrLevel,
            registerLabel: null,
            domainLabel: null,
            grammarNote: s.grammarNoteCtrl.text.trim().isEmpty
                ? null
                : s.grammarNoteCtrl.text.trim(),
            usageNote: null,
            isActive: 1,
          ),
          examples: examples,
        );
      }).toList();

      final detail = HeadwordDetail(
        headword: Headword(
          id: widget.initialDetail?.headword.id ?? '',
          spelling: _spellingCtrl.text.trim(),
          normalizedSpelling: _spellingCtrl.text.trim().toLowerCase(),
          homographNo: widget.initialDetail?.headword.homographNo ?? 1,
          cefrLevel: _overallCefr,
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          isArchived: widget.initialDetail?.headword.isArchived ?? 0,
          createdAtMs: widget.initialDetail?.headword.createdAtMs ?? 0,
          updatedAtMs: 0,
        ),
        senses: sensesDetail,
      );

      await widget.vocabRepo.saveHeadword(detail);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã lưu từ vựng thành công!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialDetail != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Chỉnh sửa từ vựng' : 'Thêm từ vựng mới'),
        actions: [
          IconButton(
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            onPressed: _isSaving ? null : _save,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ResponsiveContainer(
              maxWidth: 800,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thông tin chung từ vựng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _spellingCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Từ vựng (Spelling) *',
                        hintText: 'Ví dụ: apple, run, challenge',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Vui lòng nhập từ vựng'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _overallCefr,
                      decoration: const InputDecoration(
                        labelText: 'Cấp độ CEFR chung (Tùy chọn)',
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Không chỉ định'),
                        ),
                        ..._cefrOptions.map(
                          (c) => DropdownMenuItem(value: c, child: Text(c)),
                        ),
                      ],
                      onChanged: (v) => setState(() => _overallCefr = v),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Ghi chú thêm (Tùy chọn)',
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nét nghĩa (Senses)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _addSense,
                  icon: const Icon(Icons.add),
                  label: const Text('Thêm nghĩa'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ..._senses.asMap().entries.map((entry) {
              final sIdx = entry.key;
              final s = entry.value;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.blue.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue,
                            child: Text(
                              '${sIdx + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Nghĩa #${sIdx + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          if (_senses.length > 1)
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () => _removeSense(sIdx),
                            ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: s.partOfSpeech,
                              decoration: const InputDecoration(
                                labelText: 'Từ loại (POS) *',
                              ),
                              items: _posOptions
                                  .map(
                                    (p) => DropdownMenuItem(
                                      value: p,
                                      child: Text(p.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => s.partOfSpeech = v);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: s.cefrLevel,
                              decoration: const InputDecoration(
                                labelText: 'CEFR nghĩa',
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: null,
                                  child: Text('None'),
                                ),
                                ..._cefrOptions.map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(c),
                                  ),
                                ),
                              ],
                              onChanged: (v) => setState(() => s.cefrLevel = v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: s.definitionEnCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Định nghĩa tiếng Anh (definition_en) *',
                          hintText: 'Learner definition in English',
                        ),
                        maxLines: 2,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Vui lòng nhập định nghĩa tiếng Anh'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: s.meaningViCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nghĩa tiếng Việt (meaning_vi)',
                          hintText: 'Bản dịch tiếng Việt',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: s.grammarNoteCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Ghi chú ngữ pháp (tùy chọn)',
                          hintText: 'transitive, countable, etc.',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ví dụ (Examples)',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                s.examples.add(_ExampleFormItem());
                              });
                            },
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Thêm ví dụ'),
                          ),
                        ],
                      ),
                      ...s.examples.asMap().entries.map((exEntry) {
                        final exIdx = exEntry.key;
                        final ex = exEntry.value;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: ex.englishCtrl,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Ví dụ tiếng Anh #${exIdx + 1}',
                                        hintText: 'She runs every morning.',
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller: ex.vietnameseCtrl,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Dịch tiếng Việt #${exIdx + 1}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (s.examples.length > 1)
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      final rem = s.examples.removeAt(exIdx);
                                      rem.dispose();
                                    });
                                  },
                                ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Lưu từ vựng',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

