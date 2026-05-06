import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/quiz/domain/entities/enums.dart';

class Quiz {
  final int id;
  final String title;
  final String description;
  final Category category;
  final Difficulty difficulty;
  final QuizStatus status;
  final int questions;
  final int timeLimit;
  final int passPercentage;

  const Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.status,
    required this.questions,
    required this.timeLimit,
    required this.passPercentage,
  });
}
