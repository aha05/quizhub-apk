import 'package:flutter/material.dart';
import 'package:quizhub/core/theme/app_palette.dart';
import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/home/presentation/utils/category_style_resolver.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = CategoryStyleResolver.resolve(category.name);

    return Material(
      color: style.color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(HomePresentationConstants.cardRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          HomePresentationConstants.cardRadius,
        ),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              HomePresentationConstants.cardRadius,
            ),
            border: Border.all(color: style.color, width: 1.5),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(style.icon, size: 44, color: style.color),
              const SizedBox(height: 10),
              Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (category.description.isNotEmpty) ...[
                const SizedBox(height: 5),
                Text(
                  category.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppPallete.greyColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
