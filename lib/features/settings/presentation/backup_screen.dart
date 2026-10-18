import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/backup/backup_service.dart';
import '../../../core/utils/responsive.dart';

class BackupScreen extends StatefulWidget {
  final BackupService backupService;

  const BackupScreen({super.key, required this.backupService});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  final _importCtrl = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _importCtrl.dispose();
    super.dispose();
  }

  Future<void> _exportBackup() async {
    setState(() => _isProcessing = true);
    try {
      final jsonStr = await widget.backupService.exportToJsonString();

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Xuất dữ liệu thành công'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dữ liệu đã được tạo ở định dạng JSON chuẩn. Bạn có thể sao chép vào bộ nhớ tạm:',
              ),
              const SizedBox(height: 12),
              Container(
                height: 140,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    jsonStr,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Đóng'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: jsonStr));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã sao chép vào bộ nhớ tạm!')),
                );
                Navigator.pop(ctx);
              },
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Sao chép JSON'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi xuất dữ liệu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _previewAndRestore() async {
    final text = _importCtrl.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng dán nội dung JSON sao lưu')),
      );
      return;
    }

    try {
      final preview = widget.backupService.previewBackup(text);

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Xem trước dữ liệu sao lưu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• Từ vựng: ${preview.headwordsCount}'),
              Text('• Cụm từ: ${preview.phrasesCount}'),
              Text('• Thẻ chủ đề: ${preview.tagsCount}'),
              Text('• Câu hỏi: ${preview.questionsCount}'),
              Text('• Tiến trình học: ${preview.progressCount}'),
              if (preview.warnings.isNotEmpty) ...[
                const SizedBox(height: 8),
                ...preview.warnings.map(
                  (w) => Text(
                    'Cảnh báo: $w',
                    style: const TextStyle(color: Colors.orange, fontSize: 12),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              const Text(
                'Chọn chế độ khôi phục:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pop(ctx, true), // Merge mode
              child: const Text('Hợp nhất (Merge)'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Navigator.pop(ctx);
                final replaceConfirm = await showDialog<bool>(
                  context: context,
                  builder: (c) => AlertDialog(
                    title: const Text('Cảnh báo ghi đè'),
                    content: const Text(
                      'Chế độ Thay thế (Replace) sẽ xóa toàn bộ dữ liệu hiện tại trước khi khôi phục. Tiếp tục?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(c, false),
                        child: const Text('Hủy'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => Navigator.pop(c, true),
                        child: const Text('Xác nhận Thay thế'),
                      ),
                    ],
                  ),
                );

                if (replaceConfirm == true) {
                  await _applyRestore(text, replaceMode: true);
                }
              },
              child: const Text('Thay thế (Replace)'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await _applyRestore(text, replaceMode: false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nội dung JSON không hợp lệ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _applyRestore(
    String jsonStr, {
    required bool replaceMode,
  }) async {
    setState(() => _isProcessing = true);
    try {
      await widget.backupService.restoreFromJsonString(
        jsonStr,
        replaceMode: replaceMode,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              replaceMode
                  ? 'Đã thay thế toàn bộ dữ liệu thành công!'
                  : 'Đã hợp nhất dữ liệu thành công!',
            ),
            backgroundColor: Colors.green,
          ),
        );
        _importCtrl.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi khôi phục: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sao lưu & Khôi phục')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ResponsiveContainer(
              maxWidth: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Export Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Xuất dữ liệu (Export)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Lưu trữ toàn bộ từ vựng, cụm từ, thẻ, câu hỏi và tiến trình học thành file JSON để sao lưu ngoại tuyến.',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _isProcessing ? null : _exportBackup,
                            icon: const Icon(Icons.download),
                            label: const Text('Tạo bản sao lưu JSON'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Import Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Khôi phục dữ liệu (Import)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Dán mã JSON sao lưu vào ô bên dưới để khôi phục hoặc hợp nhất với từ điển hiện có.',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _importCtrl,
                            maxLines: 6,
                            decoration: const InputDecoration(
                              hintText: 'Dán chuỗi JSON sao lưu vào đây...',
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _isProcessing ? null : _previewAndRestore,
                            icon: const Icon(Icons.upload),
                            label: const Text('Xem trước & Khôi phục'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
