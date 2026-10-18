import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/responsive.dart';
import '../data/tags_repository.dart';

class TagsScreen extends StatefulWidget {
  final TagsRepository tagsRepo;

  const TagsScreen({super.key, required this.tagsRepo});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  void _showAddTagDialog() {
    final nameCtrl = TextEditingController();
    final slugCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String category = 'topic';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('Thêm thẻ chủ đề mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Tên thẻ *',
                    hintText: 'Du lịch, Động vật...',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: category,
                  decoration: const InputDecoration(labelText: 'Thể loại *'),
                  items: const [
                    DropdownMenuItem(
                      value: 'topic',
                      child: Text('Chủ đề (Topic)'),
                    ),
                    DropdownMenuItem(
                      value: 'grammar',
                      child: Text('Ngữ pháp (Grammar)'),
                    ),
                    DropdownMenuItem(
                      value: 'exam',
                      child: Text('Kỳ thi (IELTS, TOEIC...)'),
                    ),
                    DropdownMenuItem(
                      value: 'register',
                      child: Text('Văn phong (Register)'),
                    ),
                    DropdownMenuItem(
                      value: 'custom',
                      child: Text('Tùy chỉnh (Custom)'),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) setDialogState(() => category = v);
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Mô tả (Tùy chọn)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) return;

                final messenger = ScaffoldMessenger.of(context);
                final nav = Navigator.of(ctx);

                try {
                  await widget.tagsRepo.createTag(
                    name: name,
                    category: category,
                    slug: slugCtrl.text.trim().isEmpty
                        ? null
                        : slugCtrl.text.trim(),
                    description: descCtrl.text.trim().isEmpty
                        ? null
                        : descCtrl.text.trim(),
                  );
                  nav.pop();
                } catch (e) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý thẻ (Tags)')),
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 800,
          expand: true,
          padding: EdgeInsets.zero,
          child: StreamBuilder<List<Tag>>(
            stream: widget.tagsRepo.watchAllTags(),
            builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tags = snapshot.data ?? [];
          if (tags.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.label_outline,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text('Chưa có thẻ nào.'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tags.length,
            itemBuilder: (context, index) {
              final t = tags[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.withValues(alpha: 0.1),
                    child: const Icon(Icons.tag, color: Colors.blue, size: 20),
                  ),
                  title: Text(
                    t.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${t.category.toUpperCase()}${t.description != null ? ' • ${t.description}' : ''}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Xóa thẻ'),
                          content: Text(
                            'Bạn có chắc muốn xóa thẻ "${t.name}"?',
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
                        await widget.tagsRepo.deleteTag(t.id);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
  ),
  floatingActionButton: FloatingActionButton(
        onPressed: _showAddTagDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
