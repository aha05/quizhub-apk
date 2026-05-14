import 'package:flutter/material.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';

class ProfileCard extends StatelessWidget {
  final UserActivity userActivity;
  static const _primary = Color(0xFF6C63FF);

  const ProfileCard({super.key, required this.userActivity});

  @override
  Widget build(BuildContext context) {
    final progress = userActivity.completed / userActivity.totalQuizzes;
    final lastBadge = userActivity.badges.isNotEmpty
        ? userActivity.badges.last
        : HomePresentationConstants.noBadgesLabel;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF9B5DE5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.28),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'AR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userActivity.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          _Chip(
                            label: userActivity.level,
                            bg: Colors.white.withOpacity(0.2),
                            fg: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          _Chip(
                            label: '★  #${userActivity.leaderboard}',
                            bg: const Color(0xFFFFD700).withOpacity(0.22),
                            fg: const Color(0xFFFFD700),
                          ),
                          // Last badge chip
                          if (lastBadge != null) ...[
                            const SizedBox(width: 6),
                            _Chip(
                              label: lastBadge,
                              bg: Colors.white.withOpacity(0.15),
                              fg: Colors.white,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${userActivity.completed}/${userActivity.totalQuizzes} quizzes completed',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.white.withOpacity(0.22),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const _Chip({required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700),
    ),
  );
}
