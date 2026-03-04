import 'package:flutter/material.dart';
import '../leaderboard/leaderboard_screen.dart';


class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Quiz Completed!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Score: 8/10", style: TextStyle(fontSize: 48, color: Colors.green, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _statCard("Correct", "8", Colors.green),
                SizedBox(width: 20),
                _statCard("Wrong", "2", Colors.red),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LeaderboardScreen())), child: Text("View Leaderboard")),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String val, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
      child: Column(children: [Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)), Text(label)]),
    );
  }
}