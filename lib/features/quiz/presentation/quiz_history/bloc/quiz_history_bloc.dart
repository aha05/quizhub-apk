import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/domain/usecases/quiz_history.dart';

part 'quiz_history_event.dart';
part 'quiz_history_state.dart';

class QuizHistoryBloc extends Bloc<QuizHistoryEvent, QuizHistoryState> {
  final QuizHistoryUsecase _quizHistoryUsecase;

  QuizHistoryBloc({required QuizHistoryUsecase quizHistoryUsecase})
    : _quizHistoryUsecase = quizHistoryUsecase,
      super(QuizHistoryInitial()) {
    on<QuizHistoryRequested>(_onQuizHistoryRequested);
  }

  Future<void> _onQuizHistoryRequested(
    QuizHistoryRequested event,
    Emitter<QuizHistoryState> emit,
  ) async {
    emit(QuizHistoryLoading());

    final result = await _quizHistoryUsecase.call(NoParams());
    result.fold(
      (failure) => emit(QuizHistoryFailure(failure.message)),
      (history) => emit(QuizHistoryLoadSuccess(history)),
    );
  }
}
