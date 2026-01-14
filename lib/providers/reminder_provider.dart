import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/reminder.dart';
import '../services/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  List<Reminder> _reminders = [];
  List<Reminder> get reminders => _reminders;

  static const _storageKey = 'reminders';
  final _uuid = const Uuid();

  ReminderProvider() {
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_storageKey) ?? [];
    _reminders = data.map((e) => Reminder.fromJson(jsonDecode(e))).toList();
    notifyListeners();
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _reminders.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_storageKey, data);
  }

  Future<void> addReminder({
    required String title,
    required String message,
    required DateTime time,
    List<int> repeatDays = const [],
  }) async {
    final reminder = Reminder(
      id: _uuid.v4(),
      title: title,
      message: message,
      time: time,
      repeatDays: repeatDays,
    );
    _reminders.add(reminder);
    await _saveReminders();
    await NotificationService.instance.scheduleReminder(reminder);
    notifyListeners();
  }

  Future<void> updateReminder(Reminder reminder) async {
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
      await _saveReminders();
      await NotificationService.instance.cancelReminder(reminder.id);
      if (reminder.isEnabled) {
        await NotificationService.instance.scheduleReminder(reminder);
      }
      notifyListeners();
    }
  }

  Future<void> toggleReminder(String id) async {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      final reminder = _reminders[index];
      _reminders[index] = reminder.copyWith(isEnabled: !reminder.isEnabled);
      await _saveReminders();
      if (_reminders[index].isEnabled) {
        await NotificationService.instance.scheduleReminder(_reminders[index]);
      } else {
        await NotificationService.instance.cancelReminder(id);
      }
      notifyListeners();
    }
  }

  Future<void> deleteReminder(String id) async {
    _reminders.removeWhere((r) => r.id == id);
    await _saveReminders();
    await NotificationService.instance.cancelReminder(id);
    notifyListeners();
  }
}
