import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/bloc/quiz_history_bloc.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/widgets/empty_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/widgets/error_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/widgets/history_list_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/widgets/history_loading_view.dart';

class QuizHistoryContent extends StatelessWidget {
  final int userId;
  const QuizHistoryContent({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('My Quiz History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: BlocBuilder<QuizHistoryBloc, QuizHistoryState>(
        builder: (context, state) {
          if (state is QuizHistoryLoading) {
            return const HistoryLoadingView();
          }

          if (state is QuizHistoryFailure) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<QuizHistoryBloc>().add(
                  QuizHistoryRequested(userId),
                );
              },
            );
          }

          if (state is QuizHistoryLoadSuccess) {
            final history = state.history;

            if (history.isEmpty) {
              return const QuestionEmptyView();
            }

            return HistoryListView(
              history: history,
              onRefresh: () async {
                context.read<QuizHistoryBloc>().add(
                  QuizHistoryRequested(userId),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
