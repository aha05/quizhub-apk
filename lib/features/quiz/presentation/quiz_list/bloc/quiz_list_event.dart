part of 'quiz_list_bloc.dart';

sealed class QuizListEvent extends Equatable {
  const QuizListEvent();

  @override
  List<Object> get props => [];
}

final class QuizListRequested extends QuizListEvent {
  final int categoryId;

  const QuizListRequested(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
