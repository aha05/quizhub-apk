import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/exceptions/api_exception_helper.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:quizhub/features/quiz/data/models/quiz_model.dart';
import 'package:quizhub/features/quiz/data/models/quiz_result_model.dart';
import 'package:quizhub/features/quiz/data/models/submit_answer_payload.dart';

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final ApiService apiService;
  QuizRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<QuizModel>> fetchQuizzes(int categoryId) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.quizzesByCategory(categoryId),
      );
      final quizzes = response.data as List<dynamic>;

      return quizzes
          .map((json) => QuizModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }

  @override
  Future<QuizResultModel> submitAnswers(
    int quizId,
    SubmitAnswerPayload submitAnswerPayload,
  ) async {
    try {
      final response = await apiService.post(
        ApiEndpoints.submitQuiz(quizId),
        data: submitAnswerPayload.toJson(),
      );

      return QuizResultModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }
}
