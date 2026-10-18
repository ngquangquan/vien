import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/cefr_badge.dart';
import '../data/vocabulary_repository.dart';
import '../domain/models/vocabulary_models.dart';
import 'headword_detail_screen.dart';
import 'headword_form_screen.dart';

class VocabularyListScreen extends StatefulWidget {
  final VocabularyRepository vocabRepo;

  const VocabularyListScreen({super.key, required this.vocabRepo});

  @override
  State<VocabularyListScreen> createState() => _VocabularyListScreenState();
}

class _VocabularyListScreenState extends State<VocabularyListScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String? _selectedCefr;
  String? _selectedPos;
  bool? _isFavorite;
  bool _onlyArchived = false;

  final List<String> _cefrList = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
  final List<String> _posList = [
    'noun',
    'verb',
    'adjective',
    'adverb',
    'idiom',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  VocabularyFilter _buildFilter() {
    return VocabularyFilter(
      query: _searchQuery,
      cefrLevels: _selectedCefr != null ? [_selectedCefr!] : const [],
      partsOfSpeech: _selectedPos != null ? [_selectedPos!] : const [],
      isFavorite: _isFavorite,
      onlyArchived: _onlyArchived,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = _buildFilter();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Từ vựng (Vocabulary)'),
        actions: [
          IconButton(
            icon: Icon(
              _onlyArchived ? Icons.archive : Icons.archive_outlined,
              color: _onlyArchived ? AppTheme.primaryColor : null,
            ),
            tooltip: _onlyArchived ? 'Xem từ đang học' : 'Xem mục đã lưu trữ',
            onPressed: () {
              setState(() => _onlyArchived = !_onlyArchived);
            },
          ),
          IconButton(
            icon: Icon(
              _isFavorite == true ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite == true ? Colors.red : null,
            ),
            tooltip: 'Lọc từ yêu thích',
            onPressed: () {
              setState(() {
                _isFavorite = _isFavorite == true ? null : true;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 1080,
          expand: true,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // Search Bar
              Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm theo từ hoặc nghĩa...',
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
              onChanged: (val) {
                setState(() => _searchQuery = val);
              },
            ),
          ),

          // Filter Pills
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FilterChip(
                  label: const Text('Tất cả cấp độ'),
                  selected: _selectedCefr == null,
                  onSelected: (_) => setState(() => _selectedCefr = null),
                ),
                const SizedBox(width: 8),
                ..._cefrList.map((c) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(c),
                      selected: _selectedCefr == c,
                      selectedColor: AppTheme.getCefrColor(c)
                          .withValues(alpha: 0.2),
                      onSelected: (sel) =>
                          setState(() => _selectedCefr = sel ? c : null),
                    ),
                  );
                }),
                const VerticalDivider(width: 16),
                ..._posList.map((p) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(p),
                      selected: _selectedPos == p,
                      onSelected: (sel) =>
                          setState(() => _selectedPos = sel ? p : null),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // List of Headwords
          Expanded(
            child: StreamBuilder<List<Headword>>(
              stream: widget.vocabRepo.watchHeadwords(filter),
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
                          Icons.menu_book_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          filter.hasActiveFilter
                              ? 'Không tìm thấy từ nào phù hợp.'
                              : 'Chưa có từ vựng nào.',
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
                    final hw = items[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => HeadwordDetailScreen(
                                headwordId: hw.id,
                                vocabRepo: widget.vocabRepo,
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
                                          hw.spelling,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (hw.cefrLevel != null) ...[
                                          const SizedBox(width: 8),
                                          CefrBadge(level: hw.cefrLevel),
                                        ],
                                      ],
                                    ),
                                    if (hw.notes != null &&
                                        hw.notes!.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        hw.notes!,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
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
    ),
  ),
  floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => HeadwordFormScreen(vocabRepo: widget.vocabRepo),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Thêm từ mới'),
      ),
    );
  }
}
