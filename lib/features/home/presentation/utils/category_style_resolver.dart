import 'package:flutter/material.dart';
import 'package:quizhub/core/theme/app_palette.dart';

class CategoryStyle {
  final IconData icon;
  final Color color;

  const CategoryStyle({required this.icon, required this.color});
}

class CategoryStyleResolver {
  const CategoryStyleResolver._();

  static const _styles = <String, CategoryStyle>{
    'science': CategoryStyle(icon: Icons.science, color: AppPallete.gradient3),
    'history': CategoryStyle(icon: Icons.history, color: AppPallete.gradient2),
    'tech': CategoryStyle(icon: Icons.computer, color: AppPallete.gradient1),
    'sports': CategoryStyle(
      icon: Icons.sports_basketball,
      color: AppPallete.errorColor,
    ),
  };

  static CategoryStyle resolve(String categoryName) {
    return _styles[categoryName.toLowerCase()] ??
        const CategoryStyle(icon: Icons.category, color: AppPallete.greyColor);
  }
}
