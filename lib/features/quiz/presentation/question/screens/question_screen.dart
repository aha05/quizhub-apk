import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/di/service_locator.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/presentation/question/bloc/question_bloc.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/question_content.dart';

class QuestionScreen extends StatelessWidget {
  final Quiz quiz;
  final int? userId;

  const QuestionScreen({super.key, required this.quiz, required this.userId});

  static Route<QuestionScreen> route(Quiz quiz, int? userId) {
    return MaterialPageRoute(
      builder: (context) => QuestionScreen(quiz: quiz, userId: userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<QuestionBloc>()
        ..add(
          QuestionsRequested(
            quizId: quiz.id,
            userId: userId ?? 0,
            timeLimit: quiz.timeLimit,
          ),
        ),
      child: QuestionContent(quiz: quiz, userId: userId),
    );
  }
}
