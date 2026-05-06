import 'package:quizhub/features/quiz/domain/entities/submitted_answer.dart';

class SubmittedAnswerModel extends SubmittedAnswer {
  SubmittedAnswerModel({
    required super.id,
    required super.questionId,
    required super.selectedOptionIds,
  });

  factory SubmittedAnswerModel.fromJson(Map<String, dynamic> json) {
    return SubmittedAnswerModel(
      id: json['id'] as int? ?? 0,
      questionId: json['questionId'] as int? ?? 0,
      selectedOptionIds: json['selectedOptionIds'] != null
          ? List<int>.from(json['selectedOptionIds'] as List<dynamic>)
          : [],
    );
  }
}
