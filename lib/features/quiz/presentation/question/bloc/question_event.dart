part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

final class QuestionsRequested extends QuestionEvent {
  final int quizId;
  final int userId;
  final int timeLimit;

  const QuestionsRequested({
    required this.quizId,
    required this.userId,
    required this.timeLimit,
  });

  @override
  List<Object> get props => [quizId, userId, timeLimit];
}

final class QuestionAnswerToggled extends QuestionEvent {
  final int questionId;
  final int optionId;

  const QuestionAnswerToggled({
    required this.questionId,
    required this.optionId,
  });

  @override
  List<Object> get props => [questionId, optionId];
}

final class QuestionPrevious extends QuestionEvent {
  const QuestionPrevious();
}

final class QuestionNext extends QuestionEvent {
  const QuestionNext();
}

final class QuestionTimerTicked extends QuestionEvent {
  const QuestionTimerTicked();
}

final class QuestionSubmitted extends QuestionEvent {
  final bool autoSubmit;

  const QuestionSubmitted({this.autoSubmit = false});

  @override
  List<Object> get props => [autoSubmit];
}
