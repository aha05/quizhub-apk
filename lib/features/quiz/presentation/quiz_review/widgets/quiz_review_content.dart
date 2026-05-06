import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/bloc/quiz_review_bloc.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/error_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/loading_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/question_list_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/review_summary_bar.dart';

class QuizReviewContent extends StatelessWidget {
  final QuizHistory history;

  const QuizReviewContent({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(history.quizTitle, style: const TextStyle(fontSize: 15)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: BlocBuilder<QuizReviewBloc, QuizReviewState>(
        builder: (context, state) {
          if (state is QuizReviewLoading) {
            return const LoadingView();
          }

          if (state is QuizReviewFailure) {
            return QuizReviewErrorView(
              message: state.message,
              onRetry: () {
                context.read<QuizReviewBloc>().add(
                  QuizReviewRequested(history.quizId),
                );
              },
            );
          }

          if (state is QuizReviewSuccess && state.questions.isNotEmpty) {
            final questions = state.questions;

            return Column(
              children: [
                ReviewSummaryBar(history: history),
                Expanded(
                  child: QuestionListView(
                    questions: questions,
                    history: history,
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
