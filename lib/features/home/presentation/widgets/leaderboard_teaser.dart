import 'package:flutter/material.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';
import 'package:quizhub/features/home/presentation/utils/home_user_session.dart';
import 'package:quizhub/features/home/presentation/widgets/leader_row.dart';
import 'package:quizhub/features/leaderboard/presentation/screens/leaderboard_screen.dart';

class LeaderboardTeaser extends StatelessWidget {
  final User? user;
  const LeaderboardTeaser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final currentUser = user;
    final userId = HomeUserSession.userId(currentUser);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HomeColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: HomeColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🏆  Leaderboard',
                style: TextStyle(
                  color: HomeColors.textDark,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LeaderboardScreen(currentUserId: userId),
                  ),
                ),
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: HomeColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LeaderRow(rank: 1, name: 'Mia Chen', score: 98.2),
          LeaderRow(rank: 2, name: 'Jordan Lee', score: 95.7),
          LeaderRow(rank: 3, name: 'Sam Park', score: 91.3),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: HomeColors.border),
          ),
          LeaderRow(rank: 7, name: 'You (Alex)', score: 78.4, isMe: true),
        ],
      ),
    );
  }
}
