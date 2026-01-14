import 'package:flutter/material.dart';
import '../../app/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的 👤')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 用户信息卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppTheme.accentColor,
                      child: const Icon(Icons.person, size: 40, color: AppTheme.primaryColor),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('铲屎官', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('点击登录/注册', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 统计卡片
            Row(
              children: [
                Expanded(child: _StatCard(icon: Icons.alarm, label: '提醒次数', value: '0')),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.favorite, label: '收藏', value: '0')),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.pets, label: '打卡天数', value: '0')),
              ],
            ),
            const SizedBox(height: 24),
            // 设置列表
            Card(
              child: Column(
                children: [
                  _SettingItem(icon: Icons.notifications_outlined, title: '通知设置', onTap: () {}),
                  const Divider(height: 1),
                  _SettingItem(icon: Icons.color_lens_outlined, title: '主题设置', onTap: () {}),
                  const Divider(height: 1),
                  _SettingItem(icon: Icons.help_outline, title: '帮助与反馈', onTap: () {}),
                  const Divider(height: 1),
                  _SettingItem(icon: Icons.info_outline, title: '关于撸了么', onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
