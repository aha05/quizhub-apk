import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../repository/auth_repository.dart';
import '../../services/api.dart';
import '../../services/home_service.dart';
import '../../model/category_model.dart';
import '../../model/user_activity_model.dart';
import '../auth/login_screen.dart';
import '../quiz/quiz_list_screen.dart';
import '../leaderboard/leaderboard_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeService _service = HomeService(Api());

  List<Category> categories = [];
  UserActivity? userActivity;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {

      final results = await Future.wait([
        _service.fetchCategories(),
        _service.fetchUserActivity(),
      ]);

      setState(() {
        categories = results[0] as List<Category>;
        userActivity = results[1] as UserActivity;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load data")),
      );
    }
  }

  final Map<String, Map<String, dynamic>> categoryUIMap = {
    "science": {
      "icon": Icons.science,
      "color": Colors.orangeAccent,
    },
    "history": {
      "icon": Icons.history,
      "color": Colors.greenAccent,
    },
    "tech": {
      "icon": Icons.computer,
      "color": Colors.blueAccent,
    },
    "sports": {
      "icon": Icons.sports_basketball,
      "color": Colors.redAccent,
    },
  };

  Map<String, dynamic> getCategoryUI(String name) {
    return categoryUIMap[name.toLowerCase()] ??
        {
          "icon": Icons.category,
          "color": Colors.grey,
        };
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text("QuizHub"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserHeader(),
            const SizedBox(height: 25),
            _buildStatsSection(),
            const SizedBox(height: 30),
            const Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildCategoryGrid(),
          ],
        ),
      ),
    );
  }


  Widget _buildUserHeader() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userActivity?.name ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(userActivity?.level ?? "",
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Text(
                  userActivity!.badges.isNotEmpty
                      ? userActivity!.badges.first
                      : "No Badges Yet",
                  style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget _buildStatsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _buildStatCard(
                    "Total Quiz", userActivity!.totalQuizzes.toString())),
            const SizedBox(width: 15),
            Expanded(
                child: _buildStatCard(
                    "Avg Score", "${userActivity!.averageScore}%")),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
                child: _buildStatCard(
                    "Completed", userActivity!.completed.toString())),
            const SizedBox(width: 15),
            Expanded(
                child: _buildStatCard(
                    "Rank", "#${userActivity!.leaderboard}")),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  /// CATEGORY GRID
  Widget _buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final ui = getCategoryUI(category.name);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    QuizListScreen(category: category),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ui["color"].withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: ui["color"], width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(ui["icon"], size: 50, color: ui["color"]),
                const SizedBox(height: 10),
                Text(
                  category.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (category.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      category.description!,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildDrawer(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Colors.blueAccent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(height: 10),
                Text(userActivity?.name ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18)),
                Text(userActivity?.level ?? "No Badges Yet",
                    style:
                        const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text("My Quizzes"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard),
            title: const Text("Leaderboard"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LeaderboardScreen(currentUserId: user?.id)),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sign Out",
                style: TextStyle(color: Colors.red)),
            onTap: () async {
              final authRepository = AuthRepository(Api());
              await authRepository.logout();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }


}