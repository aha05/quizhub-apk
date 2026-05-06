import 'package:quizhub/features/quiz/domain/entities/option.dart';

class OptionModel extends Option {
  OptionModel({required super.id, required super.text, required super.correct});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as int? ?? 0,
      text: json['text'] as String? ?? '',
      correct: json['correct'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'text': text, 'correct': correct};
}
