import 'package:flutter/material.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/core/theme/app_palette.dart';
import 'package:quizhub/core/utils/show_snackbar.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';
import 'package:quizhub/features/home/presentation/utils/home_user_session.dart';
import 'package:quizhub/features/leaderboard/leaderboard_screen.dart';
import 'package:quizhub/features/profile/profile_screen.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/screens/quiz_history_screen.dart';

class HomeDrawer extends StatelessWidget {
  final UserActivity userActivity;
  final User? user;
  final VoidCallback onLogout;

  const HomeDrawer({
    super.key,
    required this.userActivity,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppPallete.gradient1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppPallete.whiteColor,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  userActivity.name,
                  style: const TextStyle(
                    color: AppPallete.whiteColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  userActivity.level,
                  style: TextStyle(
                    color: AppPallete.whiteColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              final currentUser = user;
              final userId = HomeUserSession.userId(currentUser);

              if (currentUser != null && userId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProfileScreen(userId: userId, email: currentUser.email),
                  ),
                );
              } else {
                showSnackBar(
                  context,
                  HomePresentationConstants.invalidUserSessionMessage,
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text("My Quizzes"),
            onTap: () {
              final currentUser = user;
              final userId = HomeUserSession.userId(currentUser);

              if (currentUser != null && userId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizHistoryScreen(userId: userId),
                  ),
                );
              } else {
                showSnackBar(
                  context,
                  HomePresentationConstants.invalidUserSessionMessage,
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard),
            title: const Text("Leaderboard"),
            onTap: () {
              final userId = HomeUserSession.userId(user);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LeaderboardScreen(currentUserId: userId),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppPallete.errorColor),
            title: const Text(
              "Sign Out",
              style: TextStyle(color: AppPallete.errorColor),
            ),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
