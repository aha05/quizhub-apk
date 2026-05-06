import 'answer.dart';

class SubmitAnswer {
  final int userId;
  final int timeTaken;
  final List<Answer> answers;

  SubmitAnswer({
    required this.userId,
    required this.timeTaken,
    required this.answers,
  });
}
