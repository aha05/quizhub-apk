import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/di/service_locator.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/bloc/quiz_history_bloc.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/widgets/history_content.dart';

class QuizHistoryScreen extends StatelessWidget {
  final int userId;
  const QuizHistoryScreen({super.key, required this.userId});

  static Route<QuizHistoryScreen> route(int userId) {
    return MaterialPageRoute(
      builder: (context) => QuizHistoryScreen(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<QuizHistoryBloc>()..add(QuizHistoryRequested(userId)),
      child: QuizHistoryContent(userId: userId),
    );
  }
}
