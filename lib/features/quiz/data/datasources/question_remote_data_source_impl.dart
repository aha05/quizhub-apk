import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/exceptions/api_exception_helper.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/features/quiz/data/datasources/question_remote_data_source.dart';
import 'package:quizhub/features/quiz/data/models/question_model.dart';

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final ApiService apiService;
  QuestionRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<QuestionModel>> fetchQuestions(int quizId) async {
    try {
      final dynamic response = await apiService.get(
        ApiEndpoints.quizQuestions(quizId),
      );
      final List<dynamic> questions = response.data as List<dynamic>;

      return questions
          .map((json) => QuestionModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }
}
