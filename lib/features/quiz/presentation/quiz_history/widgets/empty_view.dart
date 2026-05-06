import 'package:flutter/material.dart';

class QuestionEmptyView extends StatelessWidget {
  const QuestionEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
   return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text('No quiz attempts yet.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
