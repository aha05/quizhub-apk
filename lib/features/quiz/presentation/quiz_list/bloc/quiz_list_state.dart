part of 'quiz_list_bloc.dart';

sealed class QuizListState extends Equatable {
  const QuizListState();

  @override
  List<Object> get props => [];
}

final class QuizListInitial extends QuizListState {}

final class QuizListLoading extends QuizListState {}

final class QuizListFailure extends QuizListState {
  final String message;

  const QuizListFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class QuizListLoadSuccess extends QuizListState {
  final List<Quiz> quizzes;

  const QuizListLoadSuccess(this.quizzes);

  @override
  List<Object> get props => [quizzes];
}
