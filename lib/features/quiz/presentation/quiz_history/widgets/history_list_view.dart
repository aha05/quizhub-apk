import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/screens/quiz_review_screen.dart';

import 'history_card.dart';

class HistoryListView extends StatelessWidget {
  final List<QuizHistory> history;
  final Future<void> Function() onRefresh;

  const HistoryListView({
    super.key,
    required this.history,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = history[index];

          return HistoryCard(
            history: item,
            onReview: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizReviewScreen(history: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
