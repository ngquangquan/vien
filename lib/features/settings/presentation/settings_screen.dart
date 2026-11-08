import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/backup/backup_service.dart';
import '../../../core/notifications/cron_parser.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/tts/tts_service.dart';
import '../../../core/utils/responsive.dart';
import '../../tags/data/tags_repository.dart';
import '../../tags/presentation/tags_screen.dart';
import '../data/settings_repository.dart';
import 'backup_screen.dart';
import 'reminder_settings_screen.dart';

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
    final updated = _prefs.copyWith(dailyGoal: goal);
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

    final updated = _prefs.copyWith(preferredCefr: list);
    await widget.settingsRepo.savePreferences(updated);
    setState(() => _prefs = updated);
  }



  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: SafeArea(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final reminderDesc = _prefs.reminderEnabled
        ? CronParser.toVietnamese(_prefs.reminderCronExpression)
        : 'Đang tắt thông báo nhắc nhở';

    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt & Tùy chọn')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ResponsiveContainer(
              maxWidth: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
                              final isSelected =
                                  _prefs.preferredCefr.contains(c);
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
                            'Nhắc nhở học tập (Thông báo)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            reminderDesc,
                            style: TextStyle(
                              color: _prefs.reminderEnabled
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: _prefs.reminderEnabled,
                          onChanged: (val) async {
                            final updated = _prefs.copyWith(reminderEnabled: val);
                            await widget.settingsRepo.savePreferences(updated);
                            setState(() => _prefs = updated);
                            if (val) {
                              await widget.notifService.requestPermission();
                              await widget.notifService.scheduleFromCron(
                                cronExpression: updated.reminderCronExpression,
                                title: 'Đã đến giờ ôn tập tiếng Anh!',
                                body:
                                    'Dành vài phút hoàn thành mục tiêu ${updated.dailyGoal} từ hôm nay nhé.',
                                payload: '/review',
                              );
                            } else {
                              await widget.notifService.cancelAll();
                            }
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(
                            Icons.alarm_on,
                            color: AppTheme.primaryColor,
                          ),
                          title: const Text('Cấu hình lịch & chu kỳ nhắc nhở'),
                          subtitle: Text(
                            'Mốc giờ • Chu kỳ lặp • Biểu thức Cron: ${_prefs.reminderCronExpression}',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            final changed = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => ReminderSettingsScreen(
                                  settingsRepo: widget.settingsRepo,
                                  notifService: widget.notifService,
                                ),
                              ),
                            );
                            if (changed == true) {
                              _load();
                            }
                          },
                        ),
                        if (_prefs.reminderEnabled) ...[
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(
                              Icons.notifications_active_outlined,
                              color: AppTheme.accentColor,
                            ),
                            title: const Text('Thử gửi thông báo ngay bây giờ'),
                            subtitle: const Text('Kiểm tra âm thanh và hiển thị'),
                            trailing: const Icon(Icons.send, size: 18),
                            onTap: () async {
                              await widget.notifService.requestPermission();
                              await widget.notifService.sendTestNotification();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Đã gửi thông báo kiểm tra!'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // TTS Voice Settings
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.record_voice_over_outlined, color: AppTheme.primaryColor),
                              SizedBox(width: 8),
                              Text(
                                'Giọng đọc & Phát âm (Offline TTS)',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sử dụng công nghệ Text-to-Speech của thiết bị, phát âm chuẩn mọi từ và câu ví dụ mà không cần kết nối mạng.',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              const Text('Tốc độ đọc:', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(width: 8),
                              Text('${(TtsService().speechRate * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                            ],
                          ),
                          Slider(
                            value: TtsService().speechRate,
                            min: 0.2,
                            max: 1.0,
                            divisions: 8,
                            label: '${(TtsService().speechRate * 100).toInt()}%',
                            onChanged: (val) {
                              setState(() {
                                TtsService().setSpeechRate(val);
                              });
                            },
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    TtsService().speak(
                                      'Hello! Welcome to English vocabulary learning.',
                                      accent: TtsAccent.us,
                                    );
                                  },
                                  icon: const Icon(Icons.volume_up, size: 18),
                                  label: const Text('Thử giọng US'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    TtsService().speak(
                                      'Hello! Welcome to English vocabulary learning.',
                                      accent: TtsAccent.uk,
                                    );
                                  },
                                  icon: const Icon(Icons.volume_up, size: 18),
                                  label: const Text('Thử giọng UK'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                                builder: (ctx) =>
                                    TagsScreen(tagsRepo: widget.tagsRepo),
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
                                builder: (ctx) => BackupScreen(
                                  backupService: widget.backupService,
                                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
