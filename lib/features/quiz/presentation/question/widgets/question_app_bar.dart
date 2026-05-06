import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/presentation/question/utils/time_formatter.dart';
import 'package:quizhub/features/quiz/presentation/question/utils/timer_color.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/timer_badge.dart';

class QuestionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Quiz quiz;
  final int remainingSeconds;

  const QuestionAppBar({
    super.key,
    required this.quiz,
    required this.remainingSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = formatTime(remainingSeconds);
    final currentTimerColor = timerColor(remainingSeconds);

    return AppBar(
      title: Text(quiz.title, style: const TextStyle(fontSize: 15)),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
      actions: [TimerBadge(time: formattedTime, color: currentTimerColor)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
