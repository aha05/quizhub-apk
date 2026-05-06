part of 'quiz_review_bloc.dart';

sealed class QuizReviewEvent extends Equatable {
  const QuizReviewEvent();

  @override
  List<Object> get props => [];
}

class QuizReviewRequested extends QuizReviewEvent {
  final int quizId;

  const QuizReviewRequested(this.quizId);

  @override
  List<Object> get props => [quizId];
}
