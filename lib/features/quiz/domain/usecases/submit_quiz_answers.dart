import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_result.dart';
import 'package:quizhub/features/quiz/domain/entities/submit_answer.dart';
import 'package:quizhub/features/quiz/domain/repositories/quiz_repository.dart';

class SubmitQuizAnswers
    implements UseCase<QuizResult, SubmitQuizAnswersParams> {
  final QuizRepository repository;
  SubmitQuizAnswers(this.repository);

  @override
  Future<Either<Failure, QuizResult>> call(
    SubmitQuizAnswersParams params,
  ) async {
    return repository.submitAnswers(
      quizId: params.quizId,
      payload: params.payload,
    );
  }
}

class SubmitQuizAnswersParams {
  final int quizId;
  final SubmitAnswer payload;

  SubmitQuizAnswersParams({required this.quizId, required this.payload});
}
