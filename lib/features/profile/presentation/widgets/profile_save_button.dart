import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';

class ProfileSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSaving;

  const ProfileSaveButton({
    super.key,
    required this.onPressed,
    required this.isSaving,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isSaving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ProfilePresentationConstants.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ProfilePresentationConstants.cardRadius,
            ),
          ),
        ),
        child: isSaving
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                ProfilePresentationConstants.saveChangesLabel,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
