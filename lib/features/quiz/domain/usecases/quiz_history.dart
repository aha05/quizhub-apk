import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/domain/repositories/quiz_repository.dart';

class QuizHistoryUsecase implements UseCase<List<QuizHistory>, NoParams> {
  final QuizRepository repository;
  QuizHistoryUsecase(this.repository);

  @override
  Future<Either<Failure, List<QuizHistory>>> call(NoParams params) async {
    return await repository.fetchQuizHistory();
  }
}
