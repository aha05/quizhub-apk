import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/leaderboard/presentation/bloc/leaderboard_bloc.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_presentation_constants.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/leaderboard_content.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/leaderboard_error_view.dart';
import 'package:quizhub/init_dependencies.dart';

class LeaderboardScreen extends StatelessWidget {
  final int? currentUserId;

  const LeaderboardScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<LeaderboardBloc>()..add(LeaderboardRequested()),
      child: _LeaderboardView(currentUserId: currentUserId),
    );
  }
}

class _LeaderboardView extends StatelessWidget {
  final int? currentUserId;

  const _LeaderboardView({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LeaderboardPresentationConstants.backgroundColor,
      appBar: AppBar(
        title: const Text(LeaderboardPresentationConstants.title),
        backgroundColor: LeaderboardPresentationConstants.surfaceColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: BlocBuilder<LeaderboardBloc, LeaderboardState>(
        builder: (context, state) {
          if (state is LeaderboardInitial || state is LeaderboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LeaderboardFailure) {
            return LeaderboardErrorView(
              message: state.message,
              onRetry: () {
                context.read<LeaderboardBloc>().add(LeaderboardRequested());
              },
            );
          }

          final entries = (state as LeaderboardLoadSuccess).entries;

          return LeaderboardContent(
            entries: entries,
            currentUserId: currentUserId,
            onRefresh: () async {
              context.read<LeaderboardBloc>().add(LeaderboardRequested());
            },
          );
        },
      ),
    );
  }
}
