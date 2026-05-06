import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/enums.dart';

extension DifficultyExtension on Difficulty {
  Color get color {
    switch (this) {
      case Difficulty.EASY:
        return Colors.green;
      case Difficulty.MEDIUM:
        return Colors.orange;
      case Difficulty.HARD:
        return Colors.red;
    }
  }

  String get label {
    switch (this) {
      case Difficulty.EASY:
        return "Easy";
      case Difficulty.MEDIUM:
        return "Medium";
      case Difficulty.HARD:
        return "Hard";
    }
  }
}
