import 'submitted_answer_model.dart';

class QuizResult {
  final int id;
  final int userId;
  final int quizId;
  final int totalQuestions;
  final int correctAnswers;
  final double scorePercentage;
  final int timeTaken;
  final bool passed;
  final String submittedAt;
  final List<SubmittedAnswer> answers;

  QuizResult({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.scorePercentage,
    required this.timeTaken,
    required this.passed,
    required this.submittedAt,
    required this.answers,
  });

  int get wrongAnswers => totalQuestions - correctAnswers;

  String get formattedTime {
    final minutes = timeTaken ~/ 60;
    final seconds = timeTaken % 60;
    if (minutes == 0) return '${seconds}s';
    return '${minutes}m ${seconds}s';
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      quizId: json['quizId'] as int? ?? 0,
      totalQuestions: json['totalQuestions'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      scorePercentage: (json['scorePercentage'] as num? ?? 0).toDouble(),
      timeTaken: json['timeTaken'] as int? ?? 0,
      passed: json['passed'] as bool? ?? false,
      submittedAt: json['submittedAt'] as String? ?? '',
      answers: json['answers'] != null
          ? (json['answers'] as List<dynamic>)
              .map((e) => SubmittedAnswer.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}