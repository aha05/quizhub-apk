import 'package:quizhub/features/quiz/domain/entities/quiz_history_answer.dart';

class QuizHistory {
  final int id;
  final int quizId;
  final String quizTitle;
  final int totalQuestions;
  final int correctAnswers;
  final double scorePercentage;
  final String quizCategory;
  final bool passed;
  final String submittedAt;
  final int timeTaken;
  final List<QuizHistoryAnswer> answers;

  QuizHistory({
    required this.id,
    required this.quizId,
    required this.quizTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.scorePercentage,
    required this.quizCategory,
    required this.passed,
    required this.submittedAt,
    required this.timeTaken,
    required this.answers,
  });

  int get wrongAnswers => totalQuestions - correctAnswers;

  String get formattedTime {
    final m = timeTaken ~/ 60;
    final s = timeTaken % 60;
    return m == 0 ? '${s}s' : '${m}m ${s}s';
  }

  String get formattedDate {
    try {
      final dt = DateTime.parse(submittedAt);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return submittedAt;
    }
  }
}
