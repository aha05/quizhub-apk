import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _soundEffects = true;
  bool _darkMode = false;
  bool _weeklyReport = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.bg,
      appBar: AppBar(
        backgroundColor: HomeColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: HomeColors.textDark,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: HomeColors.textDark,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(color: HomeColors.border, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsSection(
            title: 'Preferences',
            tiles: [
              _SettingsTile(
                icon: Icons.notifications_rounded,
                iconColor: HomeColors.primary,
                label: 'Push Notifications',
                subtitle: 'Get quiz reminders & updates',
                trailing: Switch(
                  value: _notifications,
                  activeColor: HomeColors.primary,
                  onChanged: (v) => setState(() => _notifications = v),
                ),
              ),
              _SettingsTile(
                icon: Icons.volume_up_rounded,
                iconColor: const Color(0xFF2ECC71),
                label: 'Sound Effects',
                subtitle: 'Play sounds during quizzes',
                trailing: Switch(
                  value: _soundEffects,
                  activeColor: HomeColors.primary,
                  onChanged: (v) => setState(() => _soundEffects = v),
                ),
              ),
              _SettingsTile(
                icon: Icons.dark_mode_rounded,
                iconColor: HomeColors.textMid,
                label: 'Dark Mode',
                subtitle: 'Coming soon',
                trailing: Switch(
                  value: _darkMode,
                  activeColor: HomeColors.primary,
                  onChanged: (v) => setState(() => _darkMode = v),
                ),
              ),
              _SettingsTile(
                icon: Icons.bar_chart_rounded,
                iconColor: const Color(0xFFFA8231),
                label: 'Weekly Progress Report',
                subtitle: 'Receive a weekly email summary',
                trailing: Switch(
                  value: _weeklyReport,
                  activeColor: HomeColors.primary,
                  onChanged: (v) => setState(() => _weeklyReport = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: 'Account',
            tiles: [
              _SettingsTile(
                icon: Icons.person_rounded,
                iconColor: HomeColors.primary,
                label: 'Edit Profile',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: HomeColors.textLight,
                ),
              ),
              _SettingsTile(
                icon: Icons.lock_rounded,
                iconColor: HomeColors.accent,
                label: 'Change Password',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: HomeColors.textLight,
                ),
              ),
              _SettingsTile(
                icon: Icons.language_rounded,
                iconColor: const Color(0xFF4FACFE),
                label: 'Language',
                subtitle: 'English',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: HomeColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: 'Danger Zone',
            tiles: [
              _SettingsTile(
                icon: Icons.delete_forever_rounded,
                iconColor: HomeColors.accent,
                label: 'Delete Account',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: HomeColors.textLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;
  const _SettingsSection({required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: HomeColors.textMid,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          color: HomeColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: HomeColors.border, width: 1),
        ),
        child: Column(children: tiles),
      ),
    ],
  );
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String? subtitle;
  final Widget trailing;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(icon, color: iconColor, size: 18),
    ),
    title: Text(
      label,
      style: const TextStyle(
        color: HomeColors.textDark,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    ),
    subtitle: subtitle != null
        ? Text(
            subtitle!,
            style: const TextStyle(color: HomeColors.textLight, fontSize: 12),
          )
        : null,
    trailing: trailing,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
  );
}
