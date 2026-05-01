part of 'leaderboard_bloc.dart';

sealed class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

final class LeaderboardInitial extends LeaderboardState {}

final class LeaderboardLoading extends LeaderboardState {}

final class LeaderboardFailure extends LeaderboardState {
  final String message;

  const LeaderboardFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class LeaderboardLoadSuccess extends LeaderboardState {
  final List<LeaderboardEntry> entries;

  const LeaderboardLoadSuccess(this.entries);

  @override
  List<Object> get props => [entries];
}
