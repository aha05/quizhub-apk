part of 'quiz_history_bloc.dart';

sealed class QuizHistoryState extends Equatable {
  const QuizHistoryState();

  @override
  List<Object> get props => [];
}

final class QuizHistoryInitial extends QuizHistoryState {}

final class QuizHistoryLoading extends QuizHistoryState {}

final class QuizHistoryFailure extends QuizHistoryState {
  final String message;

  const QuizHistoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class QuizHistoryLoadSuccess extends QuizHistoryState {
  final List<QuizHistory> history;

  const QuizHistoryLoadSuccess(this.history);

  @override
  List<Object> get props => [history];
}
