part of 'question_bloc.dart';

enum QuestionStatus {
  initial,
  loading,
  loaded,
  submitting,
  submissionSuccess,
  failure,
}

class QuestionState extends Equatable {
  final QuestionStatus status;
  final int quizId;
  final int userId;
  final List<Question> questions;
  final int currentIndex;
  final int remainingSeconds;
  final int timeLimitSeconds;
  final Map<int, List<int>> answers;
  final QuizResult? submissionResult;
  final String? errorMessage;

  const QuestionState({
    required this.status,
    required this.quizId,
    required this.userId,
    required this.questions,
    required this.currentIndex,
    required this.remainingSeconds,
    required this.timeLimitSeconds,
    required this.answers,
    this.submissionResult,
    this.errorMessage,
  });

  const QuestionState.initial()
    : status = QuestionStatus.initial,
      quizId = 0,
      userId = 0,
      questions = const [],
      currentIndex = 0,
      remainingSeconds = 0,
      timeLimitSeconds = 0,
      answers = const {},
      submissionResult = null,
      errorMessage = null;

  const QuestionState.loading()
    : status = QuestionStatus.loading,
      quizId = 0,
      userId = 0,
      questions = const [],
      currentIndex = 0,
      remainingSeconds = 0,
      timeLimitSeconds = 0,
      answers = const {},
      submissionResult = null,
      errorMessage = null;

  factory QuestionState.loaded({
    required int quizId,
    required int userId,
    required int timeLimitSeconds,
    required List<Question> questions,
  }) {
    return QuestionState(
      status: QuestionStatus.loaded,
      quizId: quizId,
      userId: userId,
      questions: questions,
      currentIndex: 0,
      remainingSeconds: timeLimitSeconds,
      timeLimitSeconds: timeLimitSeconds,
      answers: const {},
      submissionResult: null,
      errorMessage: null,
    );
  }

  factory QuestionState.failure(String message) {
    return QuestionState(
      status: QuestionStatus.failure,
      quizId: 0,
      userId: 0,
      questions: const [],
      currentIndex: 0,
      remainingSeconds: 0,
      timeLimitSeconds: 0,
      answers: const {},
      submissionResult: null,
      errorMessage: message,
    );
  }

  QuestionState copyWith({
    QuestionStatus? status,
    int? quizId,
    int? userId,
    List<Question>? questions,
    int? currentIndex,
    int? remainingSeconds,
    int? timeLimitSeconds,
    Map<int, List<int>>? answers,
    QuizResult? submissionResult,
    String? errorMessage,
  }) {
    return QuestionState(
      status: status ?? this.status,
      quizId: quizId ?? this.quizId,
      userId: userId ?? this.userId,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      timeLimitSeconds: timeLimitSeconds ?? this.timeLimitSeconds,
      answers: answers ?? this.answers,
      submissionResult: submissionResult ?? this.submissionResult,
      errorMessage: errorMessage,
    );
  }

  Question get currentQuestion => questions[currentIndex];

  bool get isLastQuestion => currentIndex == questions.length - 1;

  bool get isSubmitting => status == QuestionStatus.submitting;

  @override
  List<Object?> get props => [
    status,
    quizId,
    userId,
    questions,
    currentIndex,
    remainingSeconds,
    timeLimitSeconds,
    answers,
    submissionResult,
    errorMessage,
  ];
}
