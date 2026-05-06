class QuizHistoryAnswer {
  final int questionId;
  final List<int> selectedOptionIds;

  QuizHistoryAnswer({
    required this.questionId,
    required this.selectedOptionIds,
  });
}
