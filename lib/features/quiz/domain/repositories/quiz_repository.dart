import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_result.dart';
import 'package:quizhub/features/quiz/domain/entities/submit_answer.dart';

abstract interface class QuizRepository {
  Future<Either<Failure, List<Quiz>>> fetchQuizzes({required int categoryId});
  Future<Either<Failure, List<Question>>> fetchQuestions({required int quizId});
  Future<Either<Failure, QuizResult>> submitAnswers({
    required int quizId,
    required SubmitAnswer payload,
  });
  Future<Either<Failure, List<QuizHistory>>> fetchQuizHistory();
}
