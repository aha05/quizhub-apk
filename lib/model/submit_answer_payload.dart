import 'answer_payload.dart';

class SubmitAnswerPayload {
  final int userId;
  final int timeTaken;
  final List<AnswerPayload> answers;

  SubmitAnswerPayload({
    required this.userId,
    required this.timeTaken,
    required this.answers,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'timeTaken': timeTaken,
        'answers': answers.map((a) => a.toJson()).toList(),
      };
}