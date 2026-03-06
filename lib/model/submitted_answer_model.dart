class SubmittedAnswer {
  final int id;
  final int questionId;
  final List<int> selectedOptionIds;

  SubmittedAnswer({
    required this.id,
    required this.questionId,
    required this.selectedOptionIds,
  });

  factory SubmittedAnswer.fromJson(Map<String, dynamic> json) {
    return SubmittedAnswer(
      id: json['id'] as int? ?? 0,
      questionId: json['questionId'] as int? ?? 0,
      selectedOptionIds: json['selectedOptionIds'] != null
          ? List<int>.from(json['selectedOptionIds'] as List<dynamic>)
          : [],
    );
  }
}