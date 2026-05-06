import 'package:quizhub/features/quiz/data/models/option_model.dart';
import 'package:quizhub/features/quiz/domain/entities/enums.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.id,
    required super.content,
    required super.type,
    required super.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int? ?? 0,
      content: json['content'] as String? ?? '',
      type: QuestionTypeExtension.fromString(json['type'] as String?),
      options: json['options'] != null
          ? (json['options'] as List<dynamic>)
                .map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }
}
