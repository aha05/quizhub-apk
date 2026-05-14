import 'package:flutter/material.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';
import 'package:quizhub/features/home/presentation/widgets/category_card_temp.dart';
import 'package:quizhub/features/home/presentation/widgets/temp-data/category.dart';
import 'package:quizhub/features/home/presentation/widgets/temp-data/home_data.dart';

class CategorySection extends StatelessWidget {
  // final List<Category> categories;
  // final ValueChanged<Category> onCategorySelected;

  const CategorySection({
    super.key,
    // required this.categories,
    // required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final HomeData homeData = dummyHomeData;
    final List<Category> categories = homeData.categories;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  color: HomeColors.textDark,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: HomeColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: HomeColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return CategoryCardTemp(
                category: category,
                // onTap: () => onCategorySelected(category),
              );
            },
          ),
        ],
      ),
    );
  }
}

final dummyHomeData = HomeData(
  userActivity: const UserActivity(
    name: 'Alex Rivera',
    level: 'Knowledge Seeker',
    totalQuizzes: 48,
    completed: 35,
    badges: [
      '🔥 Streak Master',
      '⚡ Speed Demon',
      '🎯 Sharpshooter',
      '🏆 Top 10',
    ],
    highestScorePercentage: 96.5,
    leaderboard: 7,
    averageScore: 78.4,
  ),
  categories: const [
    Category(
      name: 'Science',
      icon: '🔬',
      questions: 120,
      color: Color(0xFF6C63FF),
    ),
    Category(
      name: 'History',
      icon: '🏛️',
      questions: 85,
      color: Color(0xFFFF6584),
    ),
    Category(name: 'Tech', icon: '💻', questions: 95, color: Color(0xFF2ECC71)),
    Category(
      name: 'Geography',
      icon: '🌍',
      questions: 70,
      color: Color(0xFFFA8231),
    ),
    Category(
      name: 'Sports',
      icon: '⚽',
      questions: 60,
      color: Color(0xFF4FACFE),
    ),
    Category(name: 'Art', icon: '🎨', questions: 55, color: Color(0xFFD63CE8)),
  ],
);
