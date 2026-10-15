import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/backup/backup_service.dart';
import '../../../core/notifications/notification_service.dart';
import '../../tags/data/tags_repository.dart';
import '../../tags/presentation/tags_screen.dart';
import '../data/settings_repository.dart';
import 'backup_screen.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsRepository settingsRepo;
  final TagsRepository tagsRepo;
  final BackupService backupService;
  final NotificationService notifService;

  const SettingsScreen({
    super.key,
    required this.settingsRepo,
    required this.tagsRepo,
    required this.backupService,
    required this.notifService,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserPreferences _prefs = const UserPreferences();
  bool _isLoading = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);
  bool _notifEnabled = true;

  final List<String> _cefrOptions = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await widget.settingsRepo.getPreferences();
    setState(() {
      _prefs = prefs;
      _isLoading = false;
    });
  }

  Future<void> _updateDailyGoal(int goal) async {
    final updated = UserPreferences(
      dailyGoal: goal,
      preferredCefr: _prefs.preferredCefr,
      preferredTags: _prefs.preferredTags,
      darkTheme: _prefs.darkTheme,
    );
    await widget.settingsRepo.savePreferences(updated);
    setState(() => _prefs = updated);
  }

  Future<void> _toggleCefr(String level) async {
    final list = List<String>.from(_prefs.preferredCefr);
    if (list.contains(level)) {
      list.remove(level);
    } else {
      list.add(level);
    }

    final updated = UserPreferences(
      dailyGoal: _prefs.dailyGoal,
      preferredCefr: list,
      preferredTags: _prefs.preferredTags,
      darkTheme: _prefs.darkTheme,
    );
    await widget.settingsRepo.savePreferences(updated);
    setState(() => _prefs = updated);
  }

  Future<void> _pickReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );

    if (picked != null) {
      setState(() => _reminderTime = picked);
      await widget.notifService.requestPermission();
      await widget.notifService.scheduleDailyReminder(
        id: 1,
        title: 'Đã đến giờ ôn tập tiếng Anh!',
        body:
            'Mở ứng dụng để hoàn thành mục tiêu ${_prefs.dailyGoal} từ hôm nay nhé.',
        hour: picked.hour,
        minute: picked.minute,
        payload: '/review',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Đã cập nhật giờ nhắc nhở lúc ${picked.format(context)}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt & Tùy chọn')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Daily Study Goal
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mục tiêu ôn tập hàng ngày',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_prefs.dailyGoal} từ / ngày',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: _prefs.dailyGoal.toDouble(),
                    min: 5,
                    max: 50,
                    divisions: 9,
                    label: '${_prefs.dailyGoal}',
                    onChanged: (val) => _updateDailyGoal(val.round()),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Preferred CEFR Levels
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cấp độ CEFR ưu tiên ôn tập',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Thuật toán SM-2 sẽ tăng trọng số ưu tiên cho các từ thuộc cấp độ bạn chọn:',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: _cefrOptions.map((c) {
                      final isSelected = _prefs.preferredCefr.contains(c);
                      return FilterChip(
                        label: Text(c),
                        selected: isSelected,
                        selectedColor: AppTheme.getCefrColor(c)
                            .withValues(alpha: 0.2),
                        onSelected: (_) => _toggleCefr(c),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Notification Reminder
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    'Nhắc nhở học tập hàng ngày',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Thông báo lúc ${_reminderTime.format(context)}',
                  ),
                  value: _notifEnabled,
                  onChanged: (val) {
                    setState(() => _notifEnabled = val);
                    if (!val) {
                      widget.notifService.cancelReminder(1);
                    } else {
                      _pickReminderTime();
                    }
                  },
                ),
                if (_notifEnabled) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Đổi thời gian nhắc nhở'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _pickReminderTime,
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Tools & Management
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.label_outline,
                    color: AppTheme.primaryColor,
                  ),
                  title: const Text('Quản lý thẻ chủ đề (Tags)'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TagsScreen(tagsRepo: widget.tagsRepo),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.cloud_sync_outlined,
                    color: AppTheme.accentColor,
                  ),
                  title: const Text('Sao lưu & Khôi phục dữ liệu'),
                  subtitle: const Text('Xuất / Nhập JSON offline'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) =>
                            BackupScreen(backupService: widget.backupService),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Center(
            child: Text(
              'English Learning App • Hoạt động 100% Offline\nChuẩn CEFR • Thuật toán thích ứng SM-2',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
