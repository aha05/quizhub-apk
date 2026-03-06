import './api.dart';
import '../model/quiz_model.dart';
import '../model/submit_answer_payload.dart';
import '../model/quiz_result_model.dart';

class QuizService {
  final Api api;
  QuizService(this.api);

  Future<List<Quiz>> fetchQuizzes(int categoryId) async {
  try {
    final dynamic response = await api.get("/quiz/category/${categoryId}");
    final List<dynamic> quizzes = response as List<dynamic>;

    return quizzes
        .map((json) => Quiz.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to fetch quizzes: $e');
  }
}

Future<QuizResult> submitAnswer(int quizId, SubmitAnswerPayload submitAnswerPayload) async {
  try {
    final data = await api.post("/quiz/${quizId}/submit", submitAnswerPayload.toJson());

    return QuizResult.fromJson(data);
  } catch (e) {
    throw Exception('Failed to submit answer: $e');
  }
}

}