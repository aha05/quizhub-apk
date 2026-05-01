import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/exceptions/api_exception_helper.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'package:quizhub/features/leaderboard/data/models/leaderboard_entry_model.dart';

class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {
  final ApiService apiService;

  const LeaderboardRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<LeaderboardEntryModel>> fetchLeaderboard() async {
    try {
      final response = await apiService.get(ApiEndpoints.leaderboard);
      final leaderboard = response.data as List<dynamic>;

      return leaderboard
          .map(
            (json) =>
                LeaderboardEntryModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }
}
