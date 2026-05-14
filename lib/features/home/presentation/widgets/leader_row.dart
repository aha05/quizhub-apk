import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';

class LeaderRow extends StatelessWidget {
  final int rank;
  final String name;
  final double score;
  final bool isMe;
  const LeaderRow({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final rankColor = rank == 1
        ? const Color(0xFFFFB300)
        : rank == 2
        ? const Color(0xFF9E9E9E)
        : rank == 3
        ? const Color(0xFFCD7F32)
        : HomeColors.textLight;

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: isMe ? HomeColors.primary.withOpacity(0.07) : Colors.transparent,
        borderRadius: BorderRadius.circular(11),
        border: isMe
            ? Border.all(color: HomeColors.primary.withOpacity(0.2), width: 1)
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 26,
            child: Text(
              '#$rank',
              style: TextStyle(
                color: rankColor,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isMe
                    ? HomeColors.primary
                    : const Color.fromRGBO(26, 26, 46, 1),
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            '${score.toStringAsFixed(1)}%',
            style: const TextStyle(
              color: HomeColors.textMid,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
