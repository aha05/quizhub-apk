import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';

class ProfileBadgesCard extends StatelessWidget {
  final List<String> badges;

  const ProfileBadgesCard({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ProfilePresentationConstants.surfaceColor,
        borderRadius: BorderRadius.circular(
          ProfilePresentationConstants.cardRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ProfilePresentationConstants.badgesEarnedLabel,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: badges.map((badge) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ProfilePresentationConstants.badgeBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ProfilePresentationConstants.badgeTextColor
                        .withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ProfilePresentationConstants.badgeTextColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
