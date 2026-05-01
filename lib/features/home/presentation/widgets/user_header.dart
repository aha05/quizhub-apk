import 'package:flutter/material.dart';
import 'package:quizhub/core/theme/app_palette.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';

class UserHeader extends StatelessWidget {
  final UserActivity userActivity;

  const UserHeader({super.key, required this.userActivity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          HomePresentationConstants.cardRadius,
        ),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: AppPallete.gradient1,
              child: Icon(Icons.person, size: 40, color: AppPallete.whiteColor),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userActivity.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userActivity.level,
                  style: const TextStyle(color: AppPallete.greyColor),
                ),
                const SizedBox(height: 5),
                Text(
                  userActivity.badges.isNotEmpty
                      ? userActivity.badges.first
                      : HomePresentationConstants.noBadgesLabel,
                  style: const TextStyle(
                    color: AppPallete.gradient3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
