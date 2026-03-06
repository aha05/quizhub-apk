class AnswerPayload {
  final int questionId;
  final List<int> selectedOptionIds;

  AnswerPayload({
    required this.questionId,
    required this.selectedOptionIds,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'selectedOptionIds': selectedOptionIds,
      };
}