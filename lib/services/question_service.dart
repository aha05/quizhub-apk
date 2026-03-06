import './api.dart';
import '../../model/question_model.dart';

class QuestionService {
  final Api api;
  QuestionService(this.api);

  Future<List<Question>> fetchQuestions(int quizId) async {
  try {
    final dynamic response = await api.get("/quiz/${quizId}/questions");
    final List<dynamic> questions = response as List<dynamic>;

    return questions
        .map((json) => Question.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to fetch questions: $e');
  }
}

}