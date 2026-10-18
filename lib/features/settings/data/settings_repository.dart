import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class UserPreferences {
  final int dailyGoal;
  final List<String> preferredCefr;
  final List<String> preferredTags;
  final bool darkTheme;

  // Study Reminder Settings
  final bool reminderEnabled;
  final String reminderMode; // 'fixed' | 'interval' | 'cron'
  final List<String> reminderFixedTimes; // e.g. ['08:00', '20:00']
  final int reminderIntervalMinutes; // e.g. 120 (2h)
  final String reminderStartTime; // '08:00'
  final String reminderEndTime; // '22:00'
  final String reminderCronExpression; // '0 8,20 * * *'
  final List<int> reminderWeekdays; // 1 = Mon ... 7 = Sun

  const UserPreferences({
    this.dailyGoal = 10,
    this.preferredCefr = const [],
    this.preferredTags = const [],
    this.darkTheme = false,
    this.reminderEnabled = true,
    this.reminderMode = 'fixed',
    this.reminderFixedTimes = const ['08:00', '20:00'],
    this.reminderIntervalMinutes = 120,
    this.reminderStartTime = '08:00',
    this.reminderEndTime = '22:00',
    this.reminderCronExpression = '0 8,20 * * *',
    this.reminderWeekdays = const [1, 2, 3, 4, 5, 6, 7],
  });

  UserPreferences copyWith({
    int? dailyGoal,
    List<String>? preferredCefr,
    List<String>? preferredTags,
    bool? darkTheme,
    bool? reminderEnabled,
    String? reminderMode,
    List<String>? reminderFixedTimes,
    int? reminderIntervalMinutes,
    String? reminderStartTime,
    String? reminderEndTime,
    String? reminderCronExpression,
    List<int>? reminderWeekdays,
  }) {
    return UserPreferences(
      dailyGoal: dailyGoal ?? this.dailyGoal,
      preferredCefr: preferredCefr ?? this.preferredCefr,
      preferredTags: preferredTags ?? this.preferredTags,
      darkTheme: darkTheme ?? this.darkTheme,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderMode: reminderMode ?? this.reminderMode,
      reminderFixedTimes: reminderFixedTimes ?? this.reminderFixedTimes,
      reminderIntervalMinutes:
          reminderIntervalMinutes ?? this.reminderIntervalMinutes,
      reminderStartTime: reminderStartTime ?? this.reminderStartTime,
      reminderEndTime: reminderEndTime ?? this.reminderEndTime,
      reminderCronExpression:
          reminderCronExpression ?? this.reminderCronExpression,
      reminderWeekdays: reminderWeekdays ?? this.reminderWeekdays,
    );
  }

  Map<String, dynamic> toJson() => {
    'dailyGoal': dailyGoal,
    'preferredCefr': preferredCefr,
    'preferredTags': preferredTags,
    'darkTheme': darkTheme,
    'reminderEnabled': reminderEnabled,
    'reminderMode': reminderMode,
    'reminderFixedTimes': reminderFixedTimes,
    'reminderIntervalMinutes': reminderIntervalMinutes,
    'reminderStartTime': reminderStartTime,
    'reminderEndTime': reminderEndTime,
    'reminderCronExpression': reminderCronExpression,
    'reminderWeekdays': reminderWeekdays,
  };

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      dailyGoal: json['dailyGoal'] as int? ?? 10,
      preferredCefr:
          (json['preferredCefr'] as List<dynamic>?)?.cast<String>() ?? const [],
      preferredTags:
          (json['preferredTags'] as List<dynamic>?)?.cast<String>() ?? const [],
      darkTheme: json['darkTheme'] as bool? ?? false,
      reminderEnabled: json['reminderEnabled'] as bool? ?? true,
      reminderMode: json['reminderMode'] as String? ?? 'fixed',
      reminderFixedTimes:
          (json['reminderFixedTimes'] as List<dynamic>?)?.cast<String>() ??
          const ['08:00', '20:00'],
      reminderIntervalMinutes: json['reminderIntervalMinutes'] as int? ?? 120,
      reminderStartTime: json['reminderStartTime'] as String? ?? '08:00',
      reminderEndTime: json['reminderEndTime'] as String? ?? '22:00',
      reminderCronExpression:
          json['reminderCronExpression'] as String? ?? '0 8,20 * * *',
      reminderWeekdays:
          (json['reminderWeekdays'] as List<dynamic>?)?.cast<int>() ??
          const [1, 2, 3, 4, 5, 6, 7],
    );
  }
}

class SettingsRepository {
  final AppDatabase db;
  final _uuid = const Uuid();

  SettingsRepository(this.db);

  static const String _prefKey = 'user_preferences';

  Future<UserPreferences> getPreferences() async {
    final row = await (db.select(
      db.userSettings,
    )..where((s) => s.key.equals(_prefKey))).getSingleOrNull();
    if (row == null) return const UserPreferences();

    try {
      final jsonMap = json.decode(row.valueJson) as Map<String, dynamic>;
      return UserPreferences.fromJson(jsonMap);
    } catch (_) {
      return const UserPreferences();
    }
  }

  Future<void> savePreferences(UserPreferences prefs) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await db
        .into(db.userSettings)
        .insertOnConflictUpdate(
          UserSettingsCompanion.insert(
            key: _prefKey,
            valueJson: json.encode(prefs.toJson()),
            updatedAtMs: now,
          ),
        );
  }

  Stream<List<NotificationRule>> watchNotificationRules() {
    return db.select(db.notificationRules).watch();
  }

  Future<List<NotificationRule>> getNotificationRules() {
    return db.select(db.notificationRules).get();
  }

  Future<void> saveNotificationRule(NotificationRule rule) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final ruleId = rule.id.trim().isEmpty ? _uuid.v4() : rule.id;

    await db
        .into(db.notificationRules)
        .insertOnConflictUpdate(
          NotificationRulesCompanion.insert(
            id: ruleId,
            ruleType: rule.ruleType,
            enabled: Value(rule.enabled),
            timeOfDay: rule.timeOfDay,
            weekdaysMask: Value(rule.weekdaysMask),
            dailyCount: Value(rule.dailyCount),
            minCefr: Value(rule.minCefr),
            maxCefr: Value(rule.maxCefr),
            tagFilterId: Value(rule.tagFilterId),
            updatedAtMs: now,
          ),
        );
  }

  Future<int> deleteNotificationRule(String id) {
    return (db.delete(
      db.notificationRules,
    )..where((r) => r.id.equals(id))).go();
  }
}
