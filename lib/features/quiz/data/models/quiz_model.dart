import 'package:quizhub/features/quiz/domain/entities/enums.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'category_model.dart';

class QuizModel extends Quiz {
  final CategoryModel modelCategory;

  QuizModel({
    required super.id,
    required super.title,
    required super.description,
    required this.modelCategory,
    required super.difficulty,
    required super.status,
    required super.questions,
    required super.timeLimit,
    required super.passPercentage,
  }) : super(category: modelCategory);

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      modelCategory: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : CategoryModel(id: 0, name: '', description: ''),
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
    'category': modelCategory.toJson(),
    'difficulty': difficulty.name,
    'status': status.name,
    'questions': questions,
    'timeLimit': timeLimit,
    'passPercentage': passPercentage,
  };
}
