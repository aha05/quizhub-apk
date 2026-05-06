import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'quiz_history_answer_model.dart';

class QuizHistoryModel extends QuizHistory {
  QuizHistoryModel({
    required super.id,
    required super.quizId,
    required super.quizTitle,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.scorePercentage,
    required super.quizCategory,
    required super.passed,
    required super.submittedAt,
    required super.timeTaken,
    required super.answers,
  });

  factory QuizHistoryModel.fromJson(Map<String, dynamic> json) {
    return QuizHistoryModel(
      id: json['id'] as int? ?? 0,
      quizId: json['quizId'] as int? ?? 0,
      quizTitle: json['quizTitle'] as String? ?? '',
      totalQuestions: json['totalQuestions'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      scorePercentage: (json['scorePercentage'] as num? ?? 0).toDouble(),
      quizCategory: json['quizCategory'] as String? ?? '',
      passed: json['passed'] as bool? ?? false,
      submittedAt: json['submittedAt'] as String? ?? '',
      timeTaken: json['timeTaken'] as int? ?? 0,
      answers: json['answers'] != null
          ? (json['answers'] as List<dynamic>)
                .map(
                  (e) => QuizHistoryAnswerModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList()
          : [],
    );
  }
}
