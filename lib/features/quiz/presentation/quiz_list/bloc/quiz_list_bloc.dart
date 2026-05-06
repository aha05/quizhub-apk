import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/domain/usecases/quizzes.dart';

part 'quiz_list_event.dart';
part 'quiz_list_state.dart';

class QuizListBloc extends Bloc<QuizListEvent, QuizListState> {
  final Quizzes _quizzes;

  QuizListBloc({required Quizzes quizzes})
    : _quizzes = quizzes,
      super(QuizListInitial()) {
    on<QuizListRequested>(_onQuizListRequested);
  }

  Future<void> _onQuizListRequested(
    QuizListRequested event,
    Emitter<QuizListState> emit,
  ) async {
    emit(QuizListLoading());

    final result = await _quizzes.call(
      QuizHistoryParams(categoryId: event.categoryId),
    );
    result.fold(
      (failure) => emit(QuizListFailure(failure.message)),
      (quizzes) => emit(QuizListLoadSuccess(quizzes)),
    );
  }
}
