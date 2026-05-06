import 'package:quizhub/features/quiz/data/models/quiz_history_model.dart';

abstract interface class QuizHistoryRemoteDataSource {
  Future<List<QuizHistoryModel>> fetchQuizHistory();
}
