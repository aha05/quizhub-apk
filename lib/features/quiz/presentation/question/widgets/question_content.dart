import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/utils/show_snackbar.dart';
import 'package:quizhub/features/quiz/domain/entities/enums.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/presentation/question/bloc/question_bloc.dart';
import 'package:quizhub/features/quiz/presentation/question/utils/exit_dialog.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/bottom_nav.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/progress_bar.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/question_app_bar.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/question_card.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/question_error_view.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/question_loading_view.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/submission_loading.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/screens/quiz_result_modal.dart';

class QuestionContent extends StatelessWidget {
  final Quiz quiz;
  final int? userId;

  const QuestionContent({super.key, required this.quiz, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<QuestionBloc>()
        ..add(
          QuestionsRequested(
            quizId: quiz.id,
            userId: userId ?? 0,
            timeLimit: quiz.timeLimit,
          ),
        ),
      child: BlocConsumer<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state.status == QuestionStatus.submissionSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => QuizResultScreen(
                  result: state.submissionResult!,
                  quiz: quiz,
                ),
              ),
            );
          }
          if (state.errorMessage != null) {
            showSnackBar(context, state.errorMessage!);
          }
        },
        builder: (context, state) {
          if (state.status == QuestionStatus.loading) {
            return QuestionLoadingView(quizTitle: quiz.title);
          }

          if (state.status == QuestionStatus.failure) {
            return QuestionErrorView(
              title: quiz.title,
              message: state.errorMessage ?? 'Something went wrong',
              onRetry: () {
                context.read<QuestionBloc>().add(
                  QuestionsRequested(
                    quizId: state.quizId,
                    userId: state.userId,
                    timeLimit: state.timeLimitSeconds ~/ 60,
                  ),
                );
              },
            );
          }

          if (state.status == QuestionStatus.loaded ||
              state.status == QuestionStatus.submitting) {
            return _buildContent(context, state);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, QuestionState state) {
    final bloc = context.read<QuestionBloc>();

    return WillPopScope(
      onWillPop: () async => await confirmExit(context),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: QuestionAppBar(
          quiz: quiz,
          remainingSeconds: state.remainingSeconds,
        ),
        body: state.status == QuestionStatus.submitting
            ? SubmissionLoading()
            : Column(
                children: [
                  ProgressBar(
                    currentIndex: state.currentIndex,
                    total: state.answers.values
                        .where((e) => e.isNotEmpty)
                        .length,
                    answered: state.answers.length,
                  ),
                  Expanded(
                    child: QuestionCard(
                      question: state.currentQuestion,
                      isMultiple:
                          state.currentQuestion.type == QuestionType.MULTIPLE,
                      selectedOptions:
                          state.answers[state.currentQuestion.id] ?? [],
                      onTap: (optionId) {
                        bloc.add(
                          QuestionAnswerToggled(
                            questionId: state.currentQuestion.id,
                            optionId: optionId,
                          ),
                        );
                      }, // 👉 dispatch to bloc from option tile
                    ),
                  ),
                  BottomNav(
                    currentIndex: state.currentIndex,
                    totalQuestions: state.questions.length,
                    onNext: () => bloc.add(QuestionNext()),
                    onPrevious: () => bloc.add(QuestionPrevious()),
                    onSubmit: () => bloc.add(const QuestionSubmitted()),
                  ),
                ],
              ),
      ),
    );
  }
}
