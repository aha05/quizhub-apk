import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/domain/repositories/quiz_repository.dart';

class Questions implements UseCase<List<Question>, QuestionsParams> {
  final QuizRepository repository;
  Questions(this.repository);

  @override
  Future<Either<Failure, List<Question>>> call(QuestionsParams params) async {
    return await repository.fetchQuestions(quizId: params.quizId);
  }
}

class QuestionsParams {
  final int quizId;

  QuestionsParams({required this.quizId});
}
