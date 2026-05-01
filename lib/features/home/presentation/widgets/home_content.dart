import 'package:flutter/material.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/home/domain/entities/home_data.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';
import 'package:quizhub/features/home/presentation/widgets/category_grid.dart';
import 'package:quizhub/features/home/presentation/widgets/home_drawer.dart';
import 'package:quizhub/features/home/presentation/widgets/stats_section.dart';
import 'package:quizhub/features/home/presentation/widgets/user_header.dart';

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
      appBar: AppBar(
        title: const Text(HomePresentationConstants.appTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(HomePresentationConstants.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHeader(userActivity: homeData.userActivity),
            const SizedBox(height: HomePresentationConstants.contentGap),
            StatsSection(userActivity: homeData.userActivity),
            const SizedBox(height: HomePresentationConstants.sectionGap),
            const Text(
              HomePresentationConstants.categoriesTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: HomePresentationConstants.contentGap),
            CategoryGrid(
              categories: homeData.categories,
              onCategorySelected: onCategorySelected,
            ),
          ],
        ),
      ),
    );
  }
}
