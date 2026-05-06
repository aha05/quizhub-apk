import 'package:quizhub/features/quiz/data/models/answer_payload.dart';
import 'package:quizhub/features/quiz/domain/entities/submit_answer.dart';

class SubmitAnswerPayload extends SubmitAnswer {
  SubmitAnswerPayload({
    required super.userId,
    required super.timeTaken,
    required super.answers,
  });

  Map<String, dynamic> toJson() => {
    'quizId': userId,
    'timeTaken': timeTaken,
    'answers': answers
        .map(
          (e) => AnswerPayload(
            questionId: e.questionId,
            selectedOptionIds: e.selectedOptionIds,
          ).toJson(),
        )
        .toList(),
  };
}
