import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';

//  Get user's selected option ids for a given question
List<int> selectedIds(QuizHistory history, int questionId) {
  return history.answers
      .where((a) => a.questionId == questionId)
      .expand((a) => a.selectedOptionIds)
      .toList();
}

// Whether the user got this question fully correct
bool isQuestionCorrect(QuizHistory history, Question question) {
  final selected = selectedIds(history, question.id);
  final correctIds = question.options
      .where((o) => o.correct)
      .map((o) => o.id)
      .toList();

  return selected.length == correctIds.length &&
      selected.every((id) => correctIds.contains(id));
}
