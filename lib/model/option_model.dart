class Option {
  final int id;
  final String text;
  final bool correct;

  Option({
    required this.id,
    required this.text,
    required this.correct,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] as int? ?? 0,
      text: json['text'] as String? ?? '',
      correct: json['correct'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'correct': correct,
      };
}