import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/domain/repositories/quiz_repository.dart';

class Quizzes implements UseCase<List<Quiz>, QuizHistoryParams> {
  final QuizRepository repository;
  Quizzes(this.repository);

  @override
  Future<Either<Failure, List<Quiz>>> call(QuizHistoryParams params) async {
    return repository.fetchQuizzes(categoryId: params.categoryId);
  }
}

class QuizHistoryParams {
  final int categoryId;

  QuizHistoryParams({required this.categoryId});
}
