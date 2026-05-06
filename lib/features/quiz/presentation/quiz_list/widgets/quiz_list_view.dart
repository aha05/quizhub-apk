import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/bloc/quiz_list_bloc.dart';
import 'package:quizhub/features/quiz/presentation/question/screens/question_screen.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/utils/difficulty_extension.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/widgets/quiz_card.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/widgets/quiz_empty_state.dart';

class QuizListView extends StatelessWidget {
  final List<Quiz> quizzes;
  final int categoryId;
  final String? userId;

  const QuizListView({
    super.key,
    required this.quizzes,
    required this.categoryId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    if (quizzes.isEmpty) {
      return const QuizEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<QuizListBloc>().add(QuizListRequested(categoryId));
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: quizzes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return QuizCard(
            quiz: quiz,
            difficultyColor: quiz.difficulty.color,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuestionScreen(
                    quiz: quiz,
                    userId: int.parse(userId ?? '0'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
