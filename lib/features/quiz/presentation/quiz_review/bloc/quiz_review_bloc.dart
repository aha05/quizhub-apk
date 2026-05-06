import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/domain/usecases/questions.dart';

part 'quiz_review_event.dart';
part 'quiz_review_state.dart';

class QuizReviewBloc extends Bloc<QuizReviewEvent, QuizReviewState> {
  final Questions _questions;

  QuizReviewBloc(this._questions) : super(QuizReviewInitial()) {
    on<QuizReviewRequested>(_onRequested);
  }

  Future<void> _onRequested(
    QuizReviewRequested event,
    Emitter<QuizReviewState> emit,
  ) async {
    emit(QuizReviewLoading());

    final result = await _questions.call(QuestionsParams(quizId: event.quizId));

    result.fold(
      (failure) => emit(QuizReviewFailure(failure.message)),
      (questions) => emit(QuizReviewSuccess(questions)),
    );
  }
}
