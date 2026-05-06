import 'package:quizhub/features/quiz/domain/entities/enums.dart';
import 'package:quizhub/features/quiz/domain/entities/option.dart';

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
}
