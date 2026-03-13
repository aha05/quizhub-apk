class QuizHistoryAnswer {
  final int questionId;
  final List<int> selectedOptionIds;
 
  QuizHistoryAnswer({
    required this.questionId,
    required this.selectedOptionIds,
  });
 
  factory QuizHistoryAnswer.fromJson(Map<String, dynamic> json) {
    return QuizHistoryAnswer(
      questionId: json['questionId'] as int? ?? 0,
      selectedOptionIds: json['selectedOptionIds'] != null
          ? List<int>.from(json['selectedOptionIds'] as List<dynamic>)
          : [],
    );
  }
}
