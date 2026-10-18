import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/responsive.dart';
import '../data/phrases_repository.dart';
import '../domain/models/phrase_models.dart';

class PhraseFormScreen extends StatefulWidget {
  final PhrasesRepository phrasesRepo;
  final PhraseDetail? initialDetail;

  const PhraseFormScreen({
    super.key,
    required this.phrasesRepo,
    this.initialDetail,
  });

  @override
  State<PhraseFormScreen> createState() => _PhraseFormScreenState();
}

class _PhraseSenseFormItem {
  String id;
  String? partOfSpeech;
  String? cefrLevel;
  final TextEditingController definitionEnCtrl;
  final TextEditingController meaningViCtrl;
  final List<_ExampleItem> examples;

  _PhraseSenseFormItem({
    required this.id,
    this.partOfSpeech,
    this.cefrLevel,
    required String definitionEn,
    String? meaningVi,
    List<_ExampleItem>? examples,
  }) : definitionEnCtrl = TextEditingController(text: definitionEn),
       meaningViCtrl = TextEditingController(text: meaningVi ?? ''),
       examples = examples ?? [_ExampleItem()];

  void dispose() {
    definitionEnCtrl.dispose();
    meaningViCtrl.dispose();
    for (final ex in examples) {
      ex.dispose();
    }
  }
}

class _ExampleItem {
  String id;
  final TextEditingController englishCtrl;
  final TextEditingController vietnameseCtrl;

  _ExampleItem({this.id = '', String english = '', String vietnamese = ''})
    : englishCtrl = TextEditingController(text: english),
      vietnameseCtrl = TextEditingController(text: vietnamese);

  void dispose() {
    englishCtrl.dispose();
    vietnameseCtrl.dispose();
  }
}

class _PhraseFormScreenState extends State<PhraseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phraseCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _phraseType = 'idiom';
  String? _overallCefr;
  final List<_PhraseSenseFormItem> _senses = [];
  bool _isSaving = false;

  final List<String> _phraseTypes = [
    'idiom',
    'collocation',
    'phrasal_verb',
    'slang',
    'expression',
    'other',
  ];

  final List<String> _cefrOptions = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  @override
  void initState() {
    super.initState();
    if (widget.initialDetail != null) {
      final p = widget.initialDetail!.phrase;
      _phraseCtrl.text = p.phrase;
      _phraseType = p.phraseType;
      _notesCtrl.text = p.notes ?? '';
      _overallCefr = p.cefrLevel;

      for (final s in widget.initialDetail!.senses) {
        _senses.add(
          _PhraseSenseFormItem(
            id: s.sense.id,
            partOfSpeech: s.sense.partOfSpeech,
            cefrLevel: s.sense.cefrLevel,
            definitionEn: s.sense.definitionEn,
            meaningVi: s.sense.meaningVi,
            examples: s.examples
                .map(
                  (e) => _ExampleItem(
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
      _senses.add(_PhraseSenseFormItem(id: '', definitionEn: ''));
    }
  }

  @override
  void dispose() {
    _phraseCtrl.dispose();
    _notesCtrl.dispose();
    for (final s in _senses) {
      s.dispose();
    }
    super.dispose();
  }

  void _addSense() {
    setState(() {
      _senses.add(_PhraseSenseFormItem(id: '', definitionEn: ''));
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

        return PhraseSenseDetail(
          sense: PhraseSense(
            id: s.id,
            phraseId: widget.initialDetail?.phrase.id ?? '',
            senseNumber: idx + 1,
            partOfSpeech: s.partOfSpeech,
            definitionEn: s.definitionEnCtrl.text.trim(),
            meaningVi: s.meaningViCtrl.text.trim().isEmpty
                ? null
                : s.meaningViCtrl.text.trim(),
            cefrLevel: s.cefrLevel,
            registerLabel: null,
            domainLabel: null,
            grammarNote: null,
            usageNote: null,
            isActive: 1,
          ),
          examples: examples,
        );
      }).toList();

      final detail = PhraseDetail(
        phrase: Phrase(
          id: widget.initialDetail?.phrase.id ?? '',
          phrase: _phraseCtrl.text.trim(),
          normalizedPhrase: _phraseCtrl.text.trim().toLowerCase(),
          phraseType: _phraseType,
          cefrLevel: _overallCefr,
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          isArchived: widget.initialDetail?.phrase.isArchived ?? 0,
          createdAtMs: widget.initialDetail?.phrase.createdAtMs ?? 0,
          updatedAtMs: 0,
        ),
        senses: sensesDetail,
      );

      await widget.phrasesRepo.savePhrase(detail);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã lưu cụm từ thành công!')),
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
        title: Text(isEditing ? 'Chỉnh sửa cụm từ' : 'Thêm cụm từ / thành ngữ'),
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
                      'Thông tin cụm từ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phraseCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Cụm từ / Thành ngữ *',
                        hintText: 'Ví dụ: break a leg, take care of',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Vui lòng nhập cụm từ'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _phraseType,
                            decoration: const InputDecoration(
                              labelText: 'Loại cụm từ *',
                            ),
                            items: _phraseTypes
                                .map(
                                  (t) => DropdownMenuItem(
                                    value: t,
                                    child: Text(t.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              if (v != null) setState(() => _phraseType = v);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _overallCefr,
                            decoration: const InputDecoration(
                              labelText: 'CEFR chung',
                            ),
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('None'),
                              ),
                              ..._cefrOptions.map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              ),
                            ],
                            onChanged: (v) => setState(() => _overallCefr = v),
                          ),
                        ),
                      ],
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
                  'Nét nghĩa & Ví dụ',
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
              final idx = entry.key;
              final s = entry.value;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Nghĩa #${idx + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          if (_senses.length > 1)
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  final rem = _senses.removeAt(idx);
                                  rem.dispose();
                                });
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: s.definitionEnCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Định nghĩa tiếng Anh *',
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
                          labelText: 'Nghĩa tiếng Việt',
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
                            onPressed: () =>
                                setState(() => s.examples.add(_ExampleItem())),
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
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: ex.englishCtrl,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Ví dụ tiếng Anh #${exIdx + 1}',
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

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Lưu cụm từ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
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

