import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/utils/review_helpers.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/review_card.dart';

class QuestionListView extends StatelessWidget {
  final List<Question> questions;
  final QuizHistory history;

  const QuestionListView({
    super.key,
    required this.questions,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: questions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final question = questions[index];
        final selected = selectedIds(history, question.id);
        final isCorrect = isQuestionCorrect(history, question);

        return ReviewCard(
          question: question,
          questionNumber: index + 1,
          selectedIds: selected,
          isCorrect: isCorrect,
        );
      },
    );
  }
}
