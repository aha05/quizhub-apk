import 'package:flutter/material.dart';

class QuizEmptyState extends StatelessWidget {
  const QuizEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'No quizzes available for this category.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
