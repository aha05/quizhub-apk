import 'option_model.dart';
import 'enums.dart';


class Question {
  final int id;
  final String content;
  final QuestionType type;
  final List<Option> options;

  Question({
    required this.id,
    required this.content,
    required this.type,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int? ?? 0,
      content: json['content'] as String? ?? '',
      type: QuestionTypeExtension.fromString(json['type'] as String?),
      options: json['options'] != null
          ? (json['options'] as List<dynamic>)
              .map((e) => Option.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}