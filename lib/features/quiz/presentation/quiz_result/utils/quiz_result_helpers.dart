import 'package:flutter/material.dart';

class QuizResultHelpers {

  static Color resultColor(bool passed) {
    return passed ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
  }

  static Color resultColorLight(bool passed) {
    return passed ? const Color(0xFFDCFCE7) : const Color(0xFFFFE4E6);
  }

  static IconData resultIcon(bool passed) {
    return passed ? Icons.emoji_events_rounded : Icons.replay_rounded;
  }

  static String resultTitle(bool passed) {
    return passed ? 'Congratulations!' : 'Better Luck Next Time';
  }

  static String resultSubtitle(bool passed, int passPercentage) {
    return passed
        ? 'You passed the quiz successfully!'
        : 'You didn’t reach the pass score of $passPercentage%';
  }

  static String percentageText(double value) {
    return '${(value * 100).toInt()}%';
  }

  static String scoreText(int correct, int total) {
    return '$correct / $total';
  }

  static double scoreProgress(double percentage) {
    if (percentage < 0) return 0;
    if (percentage > 100) return 1;
    return percentage / 100;
  }

  static bool isPassed(double scorePercentage, int passPercentage) {
    return scorePercentage >= passPercentage;
  }
}
