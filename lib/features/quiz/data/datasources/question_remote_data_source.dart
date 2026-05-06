import 'package:quizhub/features/quiz/data/models/question_model.dart';

abstract interface class QuestionRemoteDataSource {
  Future<List<QuestionModel>> fetchQuestions(int quizId);
}
