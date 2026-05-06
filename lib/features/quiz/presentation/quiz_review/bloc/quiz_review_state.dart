part of 'quiz_review_bloc.dart';

sealed class QuizReviewState extends Equatable {
  const QuizReviewState();

  @override
  List<Object> get props => [];
}

class QuizReviewInitial extends QuizReviewState {}

class QuizReviewLoading extends QuizReviewState {}

class QuizReviewSuccess extends QuizReviewState {
  final List<Question> questions;

  const QuizReviewSuccess(this.questions);

  @override
  List<Object> get props => [questions];
}

class QuizReviewFailure extends QuizReviewState {
  final String message;

  const QuizReviewFailure(this.message);

  @override
  List<Object> get props => [message];
}
