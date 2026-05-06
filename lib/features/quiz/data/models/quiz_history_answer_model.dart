import 'package:quizhub/features/quiz/domain/entities/quiz_history_answer.dart';

class QuizHistoryAnswerModel extends QuizHistoryAnswer {
  QuizHistoryAnswerModel({
    required super.questionId,
    required super.selectedOptionIds,
  });

  factory QuizHistoryAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuizHistoryAnswerModel(
      questionId: json['questionId'] as int? ?? 0,
      selectedOptionIds: json['selectedOptionIds'] != null
          ? List<int>.from(json['selectedOptionIds'] as List<dynamic>)
          : [],
    );
  }
}
