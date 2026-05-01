import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/domain/entities/profile_activity.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_badges_card.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_settings_card.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_stats_grid.dart';

class ProfileContent extends StatelessWidget {
  final ProfileActivity activity;
  final String email;
  final Future<void> Function() onRefresh;
  final VoidCallback onEditProfile;
  final VoidCallback onChangePassword;

  const ProfileContent({
    super.key,
    required this.activity,
    required this.email,
    required this.onRefresh,
    required this.onEditProfile,
    required this.onChangePassword,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(ProfilePresentationConstants.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileInfoCard(
              activity: activity,
              email: email,
              onEdit: onEditProfile,
            ),
            const SizedBox(height: ProfilePresentationConstants.sectionGap),
            ProfileStatsGrid(activity: activity),
            const SizedBox(height: ProfilePresentationConstants.sectionGap),
            ProfileBadgesCard(badges: activity.badges),
            if (activity.badges.isNotEmpty)
              const SizedBox(height: ProfilePresentationConstants.sectionGap),
            ProfileSettingsCard(
              onEditProfile: onEditProfile,
              onChangePassword: onChangePassword,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
