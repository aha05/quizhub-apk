import 'category_model.dart';
import 'enums.dart'; 

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

  Quiz({
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

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : Category(id: 0, name: '', description: ''),
      difficulty: DifficultyExtension.fromString(json['difficulty'] as String?),
      status: QuizStatusExtension.fromString(json['status'] as String?),
      questions: json['questions'] as int? ?? 0,
      timeLimit: json['timeLimit'] as int? ?? 0,
      passPercentage: json['passPercentage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category.toJson(),
        'difficulty': difficulty.name,
        'status': status.name,
        'questions': questions,
        'timeLimit': timeLimit,
        'passPercentage': passPercentage,
      };
}