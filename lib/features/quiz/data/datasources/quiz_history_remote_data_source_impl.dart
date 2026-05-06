import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/exceptions/api_exception_helper.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/features/quiz/data/datasources/quiz_history_remote_data_source.dart';
import 'package:quizhub/features/quiz/data/models/quiz_history_model.dart';

class QuizHistoryRemoteDataSourceImpl implements QuizHistoryRemoteDataSource {
  final ApiService apiService;
  QuizHistoryRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<QuizHistoryModel>> fetchQuizHistory() async {
    try {
      final dynamic response = await apiService.get(ApiEndpoints.quizHistory);
      final List<dynamic> history = response.data as List<dynamic>;

      return history
          .map(
            (json) => QuizHistoryModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }
}
