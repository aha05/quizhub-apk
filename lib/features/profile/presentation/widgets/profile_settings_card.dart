import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_action_tile.dart';

class ProfileSettingsCard extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onChangePassword;

  const ProfileSettingsCard({
    super.key,
    required this.onEditProfile,
    required this.onChangePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          ProfileActionTile(
            icon: Icons.person_outline,
            label: ProfilePresentationConstants.editProfileLabel,
            subtitle: ProfilePresentationConstants.updateProfileSubtitle,
            onTap: onEditProfile,
          ),
          Divider(height: 1, indent: 56, color: Colors.grey.shade100),
          ProfileActionTile(
            icon: Icons.lock_outline,
            label: ProfilePresentationConstants.changePasswordLabel,
            subtitle: ProfilePresentationConstants.changePasswordSubtitle,
            onTap: onChangePassword,
          ),
        ],
      ),
    );
  }
}
