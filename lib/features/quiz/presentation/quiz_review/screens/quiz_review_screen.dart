import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/di/service_locator.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/bloc/quiz_review_bloc.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/quiz_review_content.dart';

class QuizReviewScreen extends StatelessWidget {
  final QuizHistory history;

  const QuizReviewScreen({super.key, required this.history});

  static Route<QuizReviewScreen> route(QuizHistory history) {
    return MaterialPageRoute(
      builder: (context) => QuizReviewScreen(history: history),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<QuizReviewBloc>()
            ..add(QuizReviewRequested(history.quizId)),
      child: QuizReviewContent(history: history),
    );
  }
}
