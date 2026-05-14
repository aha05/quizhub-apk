import 'package:flutter/material.dart';
import 'package:quizhub/features/help/presentation/widgets/faq_item.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  static const _faqs = [
    (
      'How do I start a quiz?',
      'Tap any category on the home screen or use the Daily Challenge card to start a quiz immediately.',
    ),
    (
      'How are scores calculated?',
      'Each correct answer earns full points. Your percentage score is (correct / total) × 100.',
    ),
    (
      'What are badges?',
      'Badges are earned by achieving milestones like winning streaks, fast answers, or top rankings.',
    ),
    (
      'How does the leaderboard work?',
      'The leaderboard ranks users by average score across all completed quizzes globally.',
    ),
    (
      'Can I retake a quiz?',
      'Yes! You can retake any quiz as many times as you like. Only your best score is saved.',
    ),
    (
      'How do I save a quiz?',
      'Tap the bookmark icon on any quiz detail screen to save it for later.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.bg,
      appBar: AppBar(
        backgroundColor: HomeColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: HomeColors.textDark,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help & FAQ',
          style: TextStyle(
            color: HomeColors.textDark,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(color: HomeColors.border, height: 1),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _faqs.length,
        itemBuilder: (_, i) => FaqItem(question: _faqs[i].$1, answer: _faqs[i].$2),
      ),
    );
  }
}

