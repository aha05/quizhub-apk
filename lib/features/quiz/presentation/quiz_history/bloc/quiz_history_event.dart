part of 'quiz_history_bloc.dart';

sealed class QuizHistoryEvent extends Equatable {
  const QuizHistoryEvent();

  @override
  List<Object> get props => [];
}

final class QuizHistoryRequested extends QuizHistoryEvent {
  final int userId;

  const QuizHistoryRequested(this.userId);

  @override
  List<Object> get props => [userId];
}
