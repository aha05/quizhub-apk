import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';

class ProfileInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? toggleObscure;

  const ProfileInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.toggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade500),
        suffixIcon: toggleObscure != null
            ? IconButton(
                onPressed: toggleObscure,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: _border(Colors.grey.shade200),
        enabledBorder: _border(Colors.grey.shade200),
        focusedBorder: _border(
          ProfilePresentationConstants.primaryColor,
          width: 1.5,
        ),
        errorBorder: _border(Colors.red),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        ProfilePresentationConstants.cardRadius,
      ),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
