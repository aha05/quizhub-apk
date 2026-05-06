import 'package:flutter/material.dart';

class SubmissionLoading extends StatelessWidget {
  const SubmissionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Submitting your answers...'),
        ],
      ),
    );
  }
}
