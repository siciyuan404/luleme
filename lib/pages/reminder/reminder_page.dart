import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/reminder_provider.dart';
import '../../models/reminder.dart';
import '../../app/theme.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('撸猫提醒 ⏰')),
      body: Consumer<ReminderProvider>(
        builder: (context, provider, _) {
          if (provider.reminders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.alarm_off, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('还没有设置提醒哦', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text('点击右下角添加撸猫提醒', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.reminders.length,
            itemBuilder: (context, index) {
              final reminder = provider.reminders[index];
              return _ReminderCard(reminder: reminder);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddReminderDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => const _AddReminderSheet(),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final Reminder reminder;
  const _ReminderCard({required this.reminder});

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: reminder.isEnabled ? AppTheme.accentColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.pets, color: reminder.isEnabled ? AppTheme.primaryColor : Colors.grey),
        ),
        title: Text(reminder.title, style: TextStyle(fontWeight: FontWeight.w600, color: reminder.isEnabled ? null : Colors.grey)),
        subtitle: Text(timeFormat.format(reminder.time), style: TextStyle(color: reminder.isEnabled ? AppTheme.primaryColor : Colors.grey)),
        trailing: Switch(
          value: reminder.isEnabled,
          onChanged: (_) => context.read<ReminderProvider>().toggleReminder(reminder.id),
          activeColor: AppTheme.primaryColor,
        ),
      ),
    );
  }
}

class _AddReminderSheet extends StatefulWidget {
  const _AddReminderSheet();
  @override
  State<_AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<_AddReminderSheet> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _titleController = TextEditingController(text: '撸猫时间到！');
  final _messageController = TextEditingController(text: '快去撸猫吧，毛孩子在等你呢~ 🐱');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('添加撸猫提醒', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.access_time, color: AppTheme.primaryColor),
            title: const Text('提醒时间'),
            trailing: Text('${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.primaryColor)),
            onTap: () async {
              final time = await showTimePicker(context: context, initialTime: _selectedTime);
              if (time != null) setState(() => _selectedTime = time);
            },
          ),
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: '提醒标题', prefixIcon: Icon(Icons.title))),
          const SizedBox(height: 12),
          TextField(controller: _messageController, decoration: const InputDecoration(labelText: '提醒内容', prefixIcon: Icon(Icons.message)), maxLines: 2),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final now = DateTime.now();
                context.read<ReminderProvider>().addReminder(
                  title: _titleController.text,
                  message: _messageController.text,
                  time: DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('保存提醒', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
