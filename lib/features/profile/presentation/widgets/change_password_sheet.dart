import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_form_bottom_sheet.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_input_field.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_save_button.dart';

class ChangePasswordSheet extends StatefulWidget {
  final bool isSaving;
  final void Function(String currentPassword, String newPassword) onSaved;

  const ChangePasswordSheet({
    super.key,
    required this.isSaving,
    required this.onSaved,
  });

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileFormBottomSheet(
      title: ProfilePresentationConstants.changePasswordLabel,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ProfileInputField(
              controller: _currentController,
              label: 'Current Password',
              icon: Icons.lock_outline,
              obscureText: _obscureCurrent,
              toggleObscure: () {
                setState(() => _obscureCurrent = !_obscureCurrent);
              },
              validator: (value) => value == null || value.isEmpty
                  ? 'Current password is required'
                  : null,
            ),
            const SizedBox(height: 14),
            ProfileInputField(
              controller: _newController,
              label: 'New Password',
              icon: Icons.lock_reset_outlined,
              obscureText: _obscureNew,
              toggleObscure: () {
                setState(() => _obscureNew = !_obscureNew);
              },
              validator: _validateNewPassword,
            ),
            const SizedBox(height: 14),
            ProfileInputField(
              controller: _confirmController,
              label: 'Confirm New Password',
              icon: Icons.lock_outline,
              obscureText: _obscureConfirm,
              toggleObscure: () {
                setState(() => _obscureConfirm = !_obscureConfirm);
              },
              validator: (value) {
                return value != _newController.text
                    ? 'Passwords do not match'
                    : null;
              },
            ),
            const SizedBox(height: 24),
            ProfileSaveButton(isSaving: widget.isSaving, onPressed: _save),
          ],
        ),
      ),
    );
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }

    if (value.length < 6) {
      return 'Minimum 6 characters';
    }

    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSaved(_currentController.text, _newController.text);
  }
}
