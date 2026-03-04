import 'package:flutter/material.dart';
import '../../repository/auth_repository.dart';
import '../quiz/quiz_question_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username = "Yonas";
  final String level = "Pro Player";
  final String badge = "🔥 Gold Badge";

  final List<Map<String, dynamic>> categories = [
    {"name": "Science", "icon": Icons.science, "color": Colors.orangeAccent},
    {"name": "History", "icon": Icons.history, "color": Colors.greenAccent},
    {"name": "Tech", "icon": Icons.computer, "color": Colors.blueAccent},
    {"name": "Sports", "icon": Icons.sports_basketball, "color": Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) {
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

            /// 🔥 USER HEADER
            _buildUserHeader(),

            const SizedBox(height: 25),

            /// 📊 STATS CARDS
            _buildStatsSection(),

            const SizedBox(height: 30),

            const Text(
              "Choose Category",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// 📚 CATEGORY GRID
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizQuestionScreen(),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: categories[index]['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: categories[index]['color'],
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(categories[index]['icon'],
                            size: 50, color: categories[index]['color']),
                        const SizedBox(height: 10),
                        Text(
                          categories[index]['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 🧑 USER HEADER
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
                  username,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(level, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Text(badge,
                    style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 📊 STATS SECTION
  Widget _buildStatsSection() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(child: _buildStatCard("Total Quiz", "24")),
          const SizedBox(width: 15),
          Expanded(child: _buildStatCard("Avg Score", "82%")),
        ],
      ),
      const SizedBox(height: 15),
      Row(
        children: [
          Expanded(child: _buildStatCard("Completed", "18")),
          const SizedBox(width: 15),
          Expanded(child: _buildStatCard("Rank", "#5")),
        ],
      ),
    ],
  );
}

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
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
      ),
    );
  }

  /// 🍔 DRAWER MENU
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30),
                ),
                SizedBox(height: 10),
                Text("Yonas",
                    style:
                        TextStyle(color: Colors.white, fontSize: 18)),
                Text("Pro Player",
                    style: TextStyle(color: Colors.white70)),
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
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sign Out",
                style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              // Add logout logic here
            },
          ),
        ],
      ),
    );
  }
}