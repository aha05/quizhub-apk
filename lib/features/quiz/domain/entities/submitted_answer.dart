class SubmittedAnswer {
  final int id;
  final int questionId;
  final List<int> selectedOptionIds;

  SubmittedAnswer({
    required this.id,
    required this.questionId,
    required this.selectedOptionIds,
  });
}
