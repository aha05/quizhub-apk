import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Leaderboard"), centerTitle: true),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text("${index + 1}")),
            title: Text("User ${index + 1}"),
            trailing: Text("${1000 - (index * 100)} XP", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          );
        },
      ),
    );
  }
}