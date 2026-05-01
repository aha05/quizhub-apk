import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';
import 'package:quizhub/features/leaderboard/domain/usecases/fetch_leaderboard.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final FetchLeaderboard _fetchLeaderboard;

  LeaderboardBloc({required FetchLeaderboard fetchLeaderboard})
    : _fetchLeaderboard = fetchLeaderboard,
      super(LeaderboardInitial()) {
    on<LeaderboardRequested>(_onLeaderboardRequested);
  }

  Future<void> _onLeaderboardRequested(
    LeaderboardRequested event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(LeaderboardLoading());

    final result = await _fetchLeaderboard(NoParams());

    result.fold(
      (failure) => emit(LeaderboardFailure(failure.message)),
      (entries) => emit(LeaderboardLoadSuccess(entries)),
    );
  }
}
