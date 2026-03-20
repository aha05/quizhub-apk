import './api.dart';
import '../../model/quiz_history_model.dart';


class QuizHistoryService {
  final Api api;
  QuizHistoryService(this.api);

  Future<List<QuizHistory>> fetchQuizHistory(int userId) async {
  try {
    final dynamic response = await api.get("/user-activity/history");
    final List<dynamic> history = response as List<dynamic>;

    return history
        .map((json) => QuizHistory.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to fetch history: $e');
  }
}

}