import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class UserPreferences {
  final int dailyGoal;
  final List<String> preferredCefr;
  final List<String> preferredTags;
  final bool darkTheme;

  const UserPreferences({
    this.dailyGoal = 10,
    this.preferredCefr = const [],
    this.preferredTags = const [],
    this.darkTheme = false,
  });

  Map<String, dynamic> toJson() => {
    'dailyGoal': dailyGoal,
    'preferredCefr': preferredCefr,
    'preferredTags': preferredTags,
    'darkTheme': darkTheme,
  };

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      dailyGoal: json['dailyGoal'] as int? ?? 10,
      preferredCefr:
          (json['preferredCefr'] as List<dynamic>?)?.cast<String>() ?? const [],
      preferredTags:
          (json['preferredTags'] as List<dynamic>?)?.cast<String>() ?? const [],
      darkTheme: json['darkTheme'] as bool? ?? false,
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
