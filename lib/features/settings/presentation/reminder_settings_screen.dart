import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/notifications/cron_parser.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/responsive.dart';
import '../data/settings_repository.dart';

class ReminderSettingsScreen extends StatefulWidget {
  final SettingsRepository settingsRepo;
  final NotificationService notifService;

  const ReminderSettingsScreen({
    super.key,
    required this.settingsRepo,
    required this.notifService,
  });

  @override
  State<ReminderSettingsScreen> createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  UserPreferences _prefs = const UserPreferences();
  bool _isLoading = true;
  bool _isSaving = false;

  // Active form state
  late bool _enabled;
  late String _mode; // 'fixed', 'interval', 'cron'
  late List<TimeOfDay> _fixedTimes;
  late int _intervalMinutes;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late TextEditingController _cronController;
  late List<int> _weekdays;

  String? _cronValidationError;
  String _vietnameseExplanation = '';
  List<DateTime> _upcomingOccurrences = [];

  final List<int> _intervalOptions = [15, 30, 45, 60, 90, 120, 180, 240];

  final List<Map<String, String>> _cronPresets = [
    {
      'name': 'Sáng & Tối (8h, 20h)',
      'cron': '0 8,20 * * *',
    },
    {
      'name': 'Sáng, Trưa & Tối (8h, 12h, 20h)',
      'cron': '0 8,12,20 * * *',
    },
    {
      'name': 'Mỗi 2 giờ (8h - 22h)',
      'cron': '0 8-22/2 * * *',
    },
    {
      'name': 'Mỗi 1 giờ (8h - 21h)',
      'cron': '0 8-21 * * *',
    },
    {
      'name': 'Mỗi 3 giờ (9h - 21h)',
      'cron': '0 9-21/3 * * *',
    },
    {
      'name': 'Mỗi 30 phút giờ học (8h-20h, T2-T6)',
      'cron': '*/30 8-20 * * 1-5',
    },
    {
      'name': '9:00 sáng ngày đi làm (T2-T6)',
      'cron': '0 9 * * 1-5',
    },
    {
      'name': 'T2, T4, T6 lúc 20:00',
      'cron': '0 20 * * 1,3,5',
    },
    {
      'name': 'T3, T5, T7 lúc 19:30',
      'cron': '30 19 * * 2,4,6',
    },
    {
      'name': 'Cuối tuần 10:00 sáng',
      'cron': '0 10 * * 6,7',
    },
  ];

  @override
  void initState() {
    super.initState();
    _cronController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {
    _cronController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await widget.settingsRepo.getPreferences();
    _prefs = prefs;

    _enabled = prefs.reminderEnabled;
    _mode = prefs.reminderMode;
    if (_mode != 'fixed' && _mode != 'interval' && _mode != 'cron') {
      _mode = 'fixed';
    }
    _fixedTimes = prefs.reminderFixedTimes.map(_parseTimeOfDay).toList();
    if (_fixedTimes.isEmpty) {
      _fixedTimes = [
        const TimeOfDay(hour: 8, minute: 0),
        const TimeOfDay(hour: 20, minute: 0),
      ];
    }
    _intervalMinutes = prefs.reminderIntervalMinutes;
    _startTime = _parseTimeOfDay(prefs.reminderStartTime);
    _endTime = _parseTimeOfDay(prefs.reminderEndTime);
    _weekdays = List<int>.from(prefs.reminderWeekdays);
    if (_weekdays.isEmpty) {
      _weekdays = [1, 2, 3, 4, 5, 6, 7];
    }

    _cronController.text = prefs.reminderCronExpression;

    _updateCronStateFromCurrentMode();

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  String _formatUpcomingDateTime(DateTime dt) {
    const days = {
      1: 'Thứ 2',
      2: 'Thứ 3',
      3: 'Thứ 4',
      4: 'Thứ 5',
      5: 'Thứ 6',
      6: 'Thứ 7',
      7: 'Chủ nhật',
    };
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final dow = days[dt.weekday] ?? 'T${dt.weekday}';
    return '$hour:$minute - $dow, $day/$month';
  }

  TimeOfDay _parseTimeOfDay(String str) {
    try {
      final parts = str.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {
      return const TimeOfDay(hour: 8, minute: 0);
    }
  }

  String _formatTimeOfDay(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  void _updateCronStateFromCurrentMode() {
    String currentCron = '';

    if (_mode == 'fixed') {
      currentCron = CronParser.buildFixedTimesCron(
        _fixedTimes,
        weekdays: _weekdays,
      );
    } else if (_mode == 'interval') {
      currentCron = CronParser.buildIntervalCron(
        intervalMinutes: _intervalMinutes,
        startTime: _startTime,
        endTime: _endTime,
        weekdays: _weekdays,
      );
    } else {
      currentCron = _cronController.text.trim();
    }

    _cronController.text = currentCron;

    final err = CronParser.validate(currentCron);
    _cronValidationError = err;

    if (err == null) {
      _vietnameseExplanation = CronParser.toVietnamese(currentCron);
      final parser = CronParser.tryParse(currentCron);
      if (parser != null) {
        _upcomingOccurrences = parser.getNextOccurrences(count: 5);
      } else {
        _upcomingOccurrences = [];
      }
    } else {
      _vietnameseExplanation = 'Cú pháp chưa đúng: $err';
      _upcomingOccurrences = [];
    }
  }

  Future<void> _pickFixedTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
    );

    if (picked != null) {
      // Avoid duplicate times
      final exists = _fixedTimes.any(
        (t) => t.hour == picked.hour && t.minute == picked.minute,
      );
      if (!exists) {
        setState(() {
          _fixedTimes.add(picked);
          _fixedTimes.sort(
            (a, b) => (a.hour * 60 + a.minute).compareTo(b.hour * 60 + b.minute),
          );
          _updateCronStateFromCurrentMode();
        });
      }
    }
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
        _updateCronStateFromCurrentMode();
      });
    }
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
        _updateCronStateFromCurrentMode();
      });
    }
  }

  void _toggleWeekday(int day) {
    setState(() {
      if (_weekdays.contains(day)) {
        if (_weekdays.length > 1) {
          _weekdays.remove(day);
        }
      } else {
        _weekdays.add(day);
      }
      _weekdays.sort();
      _updateCronStateFromCurrentMode();
    });
  }

  Future<void> _sendTestNotification() async {
    await widget.notifService.requestPermission();
    await widget.notifService.sendTestNotification(
      title: 'Kiểm tra thông báo học tập',
      body:
          'Hệ thống nhắc nhở của Vien đang hoạt động tốt. Hãy sẵn sàng ôn từ vựng hôm nay!',
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã gửi thông báo kiểm tra! Vui lòng kiểm tra thanh thông báo.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _saveAndApply() async {
    if (_cronValidationError != null && _enabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: $_cronValidationError'),
          backgroundColor: AppTheme.redColor,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final finalCron = _cronController.text.trim();

      final updated = _prefs.copyWith(
        reminderEnabled: _enabled,
        reminderMode: _mode,
        reminderFixedTimes: _fixedTimes.map(_formatTimeOfDay).toList(),
        reminderIntervalMinutes: _intervalMinutes,
        reminderStartTime: _formatTimeOfDay(_startTime),
        reminderEndTime: _formatTimeOfDay(_endTime),
        reminderCronExpression: finalCron,
        reminderWeekdays: _weekdays,
      );

      await widget.settingsRepo.savePreferences(updated);

      if (_enabled) {
        await widget.notifService.requestPermission();
        final scheduled = await widget.notifService.scheduleFromCron(
          cronExpression: finalCron,
          title: 'Đã đến giờ học từ vựng!',
          body: 'Dành vài phút ôn tập từ vựng và làm trắc nghiệm hôm nay nhé.',
          payload: '/review',
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Đã lưu và lên lịch $scheduled mốc thông báo học tập!',
              ),
              backgroundColor: AppTheme.greenColor,
            ),
          );
        }
      } else {
        await widget.notifService.cancelAll();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đã tắt toàn bộ nhắc nhở học tập.')),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi lưu cài đặt: $e'),
            backgroundColor: AppTheme.redColor,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
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

    final daysLabels = {
      1: 'T2',
      2: 'T3',
      3: 'T4',
      4: 'T5',
      5: 'T6',
      6: 'T7',
      7: 'CN',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt nhắc nhở học tập'),
        actions: [
          TextButton.icon(
            onPressed: _isSaving ? null : _saveAndApply,
            icon: _isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            label: const Text('Lưu'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ResponsiveContainer(
              maxWidth: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Master Switch Card
                  Card(
                    child: SwitchListTile(
                      title: const Text(
                        'Bật nhắc nhở học tập',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        _enabled
                            ? 'Ứng dụng sẽ thông báo tự động theo lịch đã chọn'
                            : 'Đang tắt nhắc nhở',
                      ),
                      value: _enabled,
                      onChanged: (val) {
                        setState(() {
                          _enabled = val;
                          if (val) _updateCronStateFromCurrentMode();
                        });
                      },
                    ),
                  ),

                  if (_enabled) ...[
                    const SizedBox(height: 16),

                    // Mode Selection (Segmented Control)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hình thức nhắc nhở',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SegmentedButton<String>(
                              segments: const [
                                ButtonSegment<String>(
                                  value: 'fixed',
                                  label: Text('Mốc giờ'),
                                  icon: Icon(Icons.alarm),
                                ),
                                ButtonSegment<String>(
                                  value: 'interval',
                                  label: Text('Chu kỳ'),
                                  icon: Icon(Icons.timelapse),
                                ),
                                ButtonSegment<String>(
                                  value: 'cron',
                                  label: Text('Cron'),
                                  icon: Icon(Icons.code),
                                ),
                              ],
                              selected: {_mode},
                              onSelectionChanged: (set) {
                                setState(() {
                                  _mode = set.first;
                                  _updateCronStateFromCurrentMode();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Mode 1: Fixed times
                    if (_mode == 'fixed') ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Các mốc giờ nhắc trong ngày',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: _pickFixedTime,
                                    icon: const Icon(Icons.add, size: 18),
                                    label: const Text('Thêm giờ'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _fixedTimes.map((t) {
                                  return Chip(
                                    avatar: const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: AppTheme.primaryColor,
                                    ),
                                    label: Text(
                                      _formatTimeOfDay(t),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onDeleted: _fixedTimes.length > 1
                                        ? () {
                                            setState(() {
                                              _fixedTimes.remove(t);
                                              _updateCronStateFromCurrentMode();
                                            });
                                          }
                                        : null,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Mode 2: Interval within time window
                    if (_mode == 'interval') ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tần suất lặp lại (Chu kỳ)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _intervalOptions.map((mins) {
                                  final isSelected = _intervalMinutes == mins;
                                  final label = mins < 60
                                      ? '$mins phút'
                                      : '${mins ~/ 60} giờ';
                                  return ChoiceChip(
                                    label: Text('Mỗi $label'),
                                    selected: isSelected,
                                    onSelected: (_) {
                                      setState(() {
                                        _intervalMinutes = mins;
                                        _updateCronStateFromCurrentMode();
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const Divider(height: 32),
                              const Text(
                                'Khung giờ hoạt động',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _pickStartTime,
                                      icon: const Icon(Icons.wb_sunny_outlined),
                                      label: Text(
                                        'Từ ${_formatTimeOfDay(_startTime)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _pickEndTime,
                                      icon: const Icon(Icons.bedtime_outlined),
                                      label: Text(
                                        'Đến ${_formatTimeOfDay(_endTime)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Mode 3: Custom Cron
                    if (_mode == 'cron') ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Biểu thức Cron (5 trường tiêu chuẩn)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '[phút: 0-59] [giờ: 0-23] [ngày: 1-31] [tháng: 1-12] [thứ: 1-7]',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _cronController,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'ví dụ: 0 8-22/2 * * *',
                                  prefixIcon: const Icon(Icons.terminal),
                                  errorText: _cronValidationError,
                                ),
                                onChanged: (_) {
                                  setState(() {
                                    final cur = _cronController.text.trim();
                                    final err = CronParser.validate(cur);
                                    _cronValidationError = err;
                                    if (err == null) {
                                      _vietnameseExplanation =
                                          CronParser.toVietnamese(cur);
                                      final parser =
                                          CronParser.tryParse(cur);
                                      _upcomingOccurrences = parser != null
                                          ? parser.getNextOccurrences(count: 5)
                                          : [];
                                    } else {
                                      _vietnameseExplanation =
                                          'Cú pháp chưa đúng: $err';
                                      _upcomingOccurrences = [];
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Mẫu biểu thức gợi ý (Presets):',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _cronPresets.map((preset) {
                                  return ActionChip(
                                    label: Text(preset['name']!),
                                    onPressed: () {
                                      setState(() {
                                        _cronController.text = preset['cron']!;
                                        _updateCronStateFromCurrentMode();
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Weekdays Filter (for fixed and interval modes)
                    if (_mode != 'cron') ...[
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Các ngày áp dụng trong tuần',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [1, 2, 3, 4, 5, 6, 7].map((d) {
                                  final isSelected = _weekdays.contains(d);
                                  return FilterChip(
                                    label: Text(daysLabels[d]!),
                                    selected: isSelected,
                                    onSelected: (_) => _toggleWeekday(d),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Summary & Vietnamese explanation card
                    Card(
                      color: AppTheme.primaryColor.withValues(alpha: 0.08),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: AppTheme.primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Tóm tắt lịch nhắc nhở',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _cronController.text,
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _vietnameseExplanation,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_upcomingOccurrences.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.event_available,
                                    color: AppTheme.greenColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '5 lần thông báo sắp tới',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ..._upcomingOccurrences.map((dt) {
                                final timeStr = _formatUpcomingDateTime(dt);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.notifications_active_outlined,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        timeStr,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Test notification button
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _sendTestNotification,
                      icon: const Icon(Icons.send_outlined),
                      label: const Text(
                        'Gửi thông báo kiểm tra ngay lập tức',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
