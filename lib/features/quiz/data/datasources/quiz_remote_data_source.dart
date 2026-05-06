import 'package:quizhub/features/quiz/data/models/quiz_model.dart';
import 'package:quizhub/features/quiz/data/models/quiz_result_model.dart';
import 'package:quizhub/features/quiz/data/models/submit_answer_payload.dart';

abstract interface class QuizRemoteDataSource {
  Future<List<QuizModel>> fetchQuizzes(int categoryId);
  Future<QuizResultModel> submitAnswers(
    int quizId,
    SubmitAnswerPayload submitAnswerPayload,
  );
}
