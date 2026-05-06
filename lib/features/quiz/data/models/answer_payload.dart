import 'package:quizhub/features/quiz/domain/entities/answer.dart';

class AnswerPayload extends Answer {
  AnswerPayload({required super.questionId, required super.selectedOptionIds});
  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'selectedOptionIds': selectedOptionIds,
  };
}
