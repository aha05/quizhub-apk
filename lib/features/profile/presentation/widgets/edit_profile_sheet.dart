import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_form_bottom_sheet.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_input_field.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_save_button.dart';

class EditProfileSheet extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final bool isSaving;
  final void Function(String name, String email) onSaved;

  const EditProfileSheet({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.isSaving,
    required this.onSaved,
  });

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileFormBottomSheet(
      title: ProfilePresentationConstants.editProfileLabel,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ProfileInputField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Name is required'
                  : null,
            ),
            const SizedBox(height: 14),
            ProfileInputField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 24),
            ProfileSaveButton(isSaving: widget.isSaving, onPressed: _save),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!value.contains('@')) {
      return 'Enter a valid email';
    }

    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSaved(_nameController.text.trim(), _emailController.text.trim());
  }
}
