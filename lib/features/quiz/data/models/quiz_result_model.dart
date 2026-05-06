import 'package:quizhub/features/quiz/domain/entities/quiz_result.dart';
import 'submitted_answer_model.dart';

class QuizResultModel extends QuizResult {
  QuizResultModel({
    required super.id,
    required super.userId,
    required super.quizId,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.scorePercentage,
    required super.timeTaken,
    required super.passed,
    required super.submittedAt,
    required super.answers,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
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
                .map(
                  (e) =>
                      SubmittedAnswerModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : [],
    );
  }
}
