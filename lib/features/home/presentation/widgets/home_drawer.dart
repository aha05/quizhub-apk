import 'package:flutter/material.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/core/utils/show_snackbar.dart';
import 'package:quizhub/features/help/presentation/screens/help_faq_screen.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';
import 'package:quizhub/features/home/presentation/utils/home_user_session.dart';
import 'package:quizhub/features/leaderboard/presentation/screens/leaderboard_screen.dart';
import 'package:quizhub/features/profile/presentation/screens/profile_screen.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/screens/quiz_history_screen.dart';
import 'package:quizhub/features/settings/presentation/screens/settings_screen.dart';

class HomeDrawer extends StatelessWidget {
  final UserActivity userActivity;
  final User? user;
  final VoidCallback onLogout;
  const HomeDrawer({
    super.key,
    required this.userActivity,
    this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = user;
    final userId = HomeUserSession.userId(currentUser);

    final items = [
      (Icons.home_rounded, 'Home', true, null),
      (
        Icons.person,
        'Profile',
        false,
        (currentUser != null && userId != null)
            ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProfileScreen(userId: userId, email: currentUser.email),
                ),
              )
            : () => showSnackBar(
                context,
                HomePresentationConstants.invalidUserSessionMessage,
              ),
      ),
      (
        Icons.leaderboard_rounded,
        'Leaderboard',
        false,
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LeaderboardScreen(currentUserId: userId),
          ),
        ),
      ),
      (
        Icons.history,
        'My Quizzes',
        false,
        (currentUser != null && userId != null)
            ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizHistoryScreen(userId: userId),
                ),
              )
            : () => showSnackBar(
                context,
                HomePresentationConstants.invalidUserSessionMessage,
              ),
      ),
      (
        Icons.settings_rounded,
        'Settings',
        false,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        ),
      ),
      (
        Icons.help_outline_rounded,
        'Help & FAQ',
        false,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HelpFaqScreen()),
        ),
      ),
    ];

    return Drawer(
      backgroundColor: HomeColors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [HomeColors.primary, Color(0xFF9B5DE5)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'AR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userActivity.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    userActivity.level,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                child: ListTile(
                  leading: Icon(
                    item.$1,
                    color: item.$3 ? HomeColors.primary : HomeColors.textDark,
                    size: 22,
                  ),
                  title: Text(
                    item.$2,
                    style: TextStyle(
                      color: item.$3 ? HomeColors.primary : HomeColors.textDark,
                      fontWeight: item.$3 ? FontWeight.w700 : FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  tileColor: item.$3
                      ? HomeColors.primary.withOpacity(0.07)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    Navigator.pop(context); // close drawer first
                    item.$4?.call(); // then navigate
                  },
                ),
              ),
            ),
            const Spacer(),
            const Divider(color: HomeColors.border, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: HomeColors.accent,
                  size: 22,
                ),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: HomeColors.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: onLogout,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
