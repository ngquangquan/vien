import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/widgets/cefr_badge.dart';
import '../data/phrases_repository.dart';
import '../domain/models/phrase_models.dart';
import 'phrase_detail_screen.dart';
import 'phrase_form_screen.dart';

class PhrasesListScreen extends StatefulWidget {
  final PhrasesRepository phrasesRepo;

  const PhrasesListScreen({super.key, required this.phrasesRepo});

  @override
  State<PhrasesListScreen> createState() => _PhrasesListScreenState();
}

class _PhrasesListScreenState extends State<PhrasesListScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String? _selectedType;
  bool _onlyArchived = false;

  final List<String> _types = [
    'idiom',
    'collocation',
    'phrasal_verb',
    'slang',
    'expression',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  PhraseFilter _buildFilter() {
    return PhraseFilter(
      query: _searchQuery,
      phraseTypes: _selectedType != null ? [_selectedType!] : const [],
      onlyArchived: _onlyArchived,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = _buildFilter();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thành ngữ & Cụm từ'),
        actions: [
          IconButton(
            icon: Icon(
              _onlyArchived ? Icons.archive : Icons.archive_outlined,
              color: _onlyArchived ? AppTheme.primaryColor : null,
            ),
            tooltip: _onlyArchived
                ? 'Xem cụm từ đang học'
                : 'Xem mục đã lưu trữ',
            onPressed: () => setState(() => _onlyArchived = !_onlyArchived),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm thành ngữ, phrasal verb...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),

          // Types Filter Pills
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FilterChip(
                  label: const Text('Tất cả'),
                  selected: _selectedType == null,
                  onSelected: (_) => setState(() => _selectedType = null),
                ),
                const SizedBox(width: 8),
                ..._types.map((t) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(t.toUpperCase()),
                      selected: _selectedType == t,
                      onSelected: (sel) =>
                          setState(() => _selectedType = sel ? t : null),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: StreamBuilder<List<Phrase>>(
              stream: widget.phrasesRepo.watchPhrases(filter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.format_quote_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          filter.hasActiveFilter
                              ? 'Không tìm thấy cụm từ nào phù hợp.'
                              : 'Chưa có thành ngữ nào.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final phr = items[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => PhraseDetailScreen(
                                phraseId: phr.id,
                                phrasesRepo: widget.phrasesRepo,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          phr.phrase,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (phr.cefrLevel != null) ...[
                                          const SizedBox(width: 8),
                                          CefrBadge(level: phr.cefrLevel),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.accentColor.withValues(
                                          alpha: 0.12,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        phr.phraseType.toUpperCase(),
                                        style: const TextStyle(
                                          color: AppTheme.accentColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) =>
                  PhraseFormScreen(phrasesRepo: widget.phrasesRepo),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Thêm cụm từ'),
      ),
    );
  }
}
