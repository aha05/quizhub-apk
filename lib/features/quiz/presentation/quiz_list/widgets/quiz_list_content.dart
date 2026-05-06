import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/bloc/quiz_list_bloc.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/widgets/quiz_error_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/widgets/quiz_list_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/widgets/quiz_loading_view.dart';

class QuizListContent extends StatelessWidget {
  final Category category;
  const QuizListContent({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppUserCubit cubit) {
      final state = cubit.state;
      return state is AppUserLoggedIn ? state.user : null;
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: BlocBuilder<QuizListBloc, QuizListState>(
        builder: (context, state) {
          if (state is QuizListLoading) {
            return const QuizLoadingView();
          }

          if (state is QuizListFailure) {
            return QuizErrorView(
              message: state.message,
              onRetry: () {
                context.read<QuizListBloc>().add(
                  QuizListRequested(category.id),
                );
              },
            );
          }
          if (state is QuizListLoadSuccess) {
            return QuizListView(
              quizzes: state.quizzes,
              categoryId: category.id,
              userId: user?.id,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
