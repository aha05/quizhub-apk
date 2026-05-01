import 'package:flutter/material.dart';
import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';
import 'package:quizhub/features/home/presentation/widgets/category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<Category> categories;
  final ValueChanged<Category> onCategorySelected;

  const CategoryGrid({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 720 ? 4 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: HomePresentationConstants.contentGap,
            crossAxisSpacing: HomePresentationConstants.contentGap,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return CategoryCard(
              category: category,
              onTap: () => onCategorySelected(category),
            );
          },
        );
      },
    );
  }
}
