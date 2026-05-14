import 'package:flutter/material.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/home/domain/entities/home_data.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';
import 'package:quizhub/features/home/presentation/widgets/app_nav_bar.dart'
    hide HomeData;
import 'package:quizhub/features/home/presentation/widgets/badges_section.dart';
import 'package:quizhub/features/home/presentation/widgets/category_grid.dart';
import 'package:quizhub/features/home/presentation/widgets/category_section.dart';
import 'package:quizhub/features/home/presentation/widgets/daily_challenge.dart';
import 'package:quizhub/features/home/presentation/widgets/home_drawer.dart';
import 'package:quizhub/features/home/presentation/widgets/leaderboard_teaser.dart';
import 'package:quizhub/features/home/presentation/widgets/profile_card.dart';
import 'package:quizhub/features/home/presentation/widgets/stats_section.dart';

class HomeContent extends StatelessWidget {
  final HomeData homeData;
  final User? user;
  final ValueChanged<Category> onCategorySelected;
  final VoidCallback onLogout;

  const HomeContent({
    super.key,
    required this.homeData,
    required this.user,
    required this.onCategorySelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(
        userActivity: homeData.userActivity,
        user: user,
        onLogout: onLogout,
      ),
      appBar: AppNavBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(HomePresentationConstants.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(userActivity: homeData.userActivity),
            const SizedBox(height: HomePresentationConstants.contentGap),
            StatsSection(userActivity: homeData.userActivity),
            DailyChallenge(),
            const SizedBox(height: HomePresentationConstants.sectionGap),
            // const Text(
            //   HomePresentationConstants.categoriesTitle,
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: HomePresentationConstants.contentGap),
            CategorySection(),
            BadgesSection(badges: homeData.userActivity.badges),
            LeaderboardTeaser(user: user),
            // CategoryGrid(
            //   categories: homeData.categories,
            //   onCategorySelected: onCategorySelected,
            // ),
          ],
        ),
      ),
    );
  }
}
