import 'package:flutter/material.dart';
import '../../model/leaderboard_model.dart';
import '../../services/leaderboard_service.dart';
import '../../services/api.dart';
import '../../core/handlers/auth_handler.dart';
import '../../core/exceptions/api_exception.dart';


class LeaderboardScreen extends StatefulWidget {
  final int? currentUserId;

  const LeaderboardScreen({super.key, required this.currentUserId});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final LeaderboardService _service = LeaderboardService(Api());
  
  bool isLoading = true;
  String? error;
  List<LeaderboardEntry> entries = [];

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    try {
    final leaderboard = await _service.fetchLeaderboard();

      setState(() {
        entries = leaderboard as List<LeaderboardEntry>;
        isLoading = false;
      });

      await Future.delayed(const Duration(seconds: 1));
    } on ApiException catch (e) {
      if (e.statusCode == 401){
           AuthHandler.redirectToLogin(context, e);
      }
      setState(() {
        error = 'Failed to load leaderboard: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() { isLoading = true; error = null; });
                _fetchLeaderboard();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (entries.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.leaderboard_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('No leaderboard data yet.',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    // Find current user's entry
    final currentUserEntry = entries.where(
      (e) => e.userId == widget.currentUserId,
    ).firstOrNull;

    return Column(
      children: [
        // Top 3 podium
        if (entries.length >= 3) _buildPodium(),

        // Current user's rank card (if not in top 3)
        if (currentUserEntry != null &&
            entries.indexOf(currentUserEntry) >= 3)
          _buildCurrentUserCard(currentUserEntry),

        // Full list
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() { isLoading = true; error = null; });
              await _fetchLeaderboard();
            },
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) => _LeaderboardRow(
                entry: entries[index],
                isCurrentUser: entries[index].userId == widget.currentUserId,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPodium() {
    final top3 = entries.take(3).toList();
    final first = top3[0];
    final second = top3[1];
    final third = top3[2];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd place
          Expanded(child: _PodiumColumn(entry: second, height: 80, place: 2)),
          const SizedBox(width: 8),
          // 1st place
          Expanded(child: _PodiumColumn(entry: first, height: 110, place: 1)),
          const SizedBox(width: 8),
          // 3rd place
          Expanded(child: _PodiumColumn(entry: third, height: 60, place: 3)),
        ],
      ),
    );
  }


  Widget _buildCurrentUserCard(LeaderboardEntry entry) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF4F46E5),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '#${entry.rank}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildAvatar(entry.username, Colors.white, Colors.white24, 36),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${entry.username} (You)',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${entry.quizzesAttempted} quizzes attempted',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.score}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'pts',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const _LeaderboardRow({
    required this.entry,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final isTop3 = entry.rank <= 3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? const Color(0xFF4F46E5).withOpacity(0.06)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCurrentUser
              ? const Color(0xFF4F46E5).withOpacity(0.3)
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 36,
            child: isTop3
                ? Text(
                    _rankEmoji(entry.rank),
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '#${entry.rank}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 12),

          // Avatar
          _buildAvatar(
            entry.username,
            _avatarTextColor(entry.rank),
            _avatarBgColor(entry.rank),
            38,
          ),
          const SizedBox(width: 10),

          // Name + quizzes
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'You',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  '${entry.quizzesAttempted} quizzes attempted',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          // Score
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.score}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                'pts',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _rankEmoji(int rank) {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '#$rank';
    }
  }

  Color _avatarBgColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFF3CD);
      case 2:
        return const Color(0xFFE8E8E8);
      case 3:
        return const Color(0xFFFFE5D0);
      default:
        return const Color(0xFFEEF2FF);
    }
  }

  Color _avatarTextColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFD4A017);
      case 2:
        return const Color(0xFF707070);
      case 3:
        return const Color(0xFFD2691E);
      default:
        return const Color(0xFF4F46E5);
    }
  }
}


class _PodiumColumn extends StatelessWidget {
  final LeaderboardEntry entry;
  final double height;
  final int place;

  const _PodiumColumn({
    required this.entry,
    required this.height,
    required this.place,
  });

  Color get _placeColor {
    switch (place) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return Colors.grey;
    }
  }

  String get _placeEmoji {
    switch (place) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Username
        Text(
          entry.username,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.black87),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        // Score
        Text(
          '${entry.score} pts',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        // Avatar
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _placeColor.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: _placeColor, width: 2),
          ),
          child: Center(
            child: Text(
              entry.username.isNotEmpty
                  ? entry.username[0].toUpperCase()
                  : '?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _placeColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        // Podium block
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: _placeColor.withOpacity(0.15),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            border: Border.all(color: _placeColor.withOpacity(0.4)),
          ),
          child: Center(
            child: Text(
              _placeEmoji,
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ),
      ],
    );
  }
}


Widget _buildAvatar(
    String username, Color textColor, Color bgColor, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: bgColor,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        username.isNotEmpty ? username[0].toUpperCase() : '?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: size * 0.4,
        ),
      ),
    ),
  );
}