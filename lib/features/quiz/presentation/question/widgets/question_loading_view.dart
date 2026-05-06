import 'package:flutter/material.dart';

class QuestionLoadingView extends StatelessWidget {
  final String quizTitle;
  const QuestionLoadingView({super.key, required this.quizTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(quizTitle, style: const TextStyle(fontSize: 15)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading questions...'),
          ],
        ),
      ),
    );
  }
}


  