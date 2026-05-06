import 'package:fpdart/src/either.dart';
import 'package:quizhub/core/error/api_error_mapper.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/exceptions/api_exception.dart';
import 'package:quizhub/core/network/connection_checker.dart';
import 'package:quizhub/features/quiz/data/datasources/question_remote_data_source.dart';
import 'package:quizhub/features/quiz/data/datasources/quiz_history_remote_data_source.dart';
import 'package:quizhub/features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:quizhub/features/quiz/data/models/submit_answer_payload.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_result.dart';
import 'package:quizhub/features/quiz/domain/entities/submit_answer.dart';
import 'package:quizhub/features/quiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource quizRemoteDataSource;
  final QuestionRemoteDataSource questionRemoteDataSource;
  final QuizHistoryRemoteDataSource quizHistoryRemoteDataSource;
  final ConnectionChecker connectionChecker;

  QuizRepositoryImpl({
    required this.quizRemoteDataSource,
    required this.questionRemoteDataSource,
    required this.quizHistoryRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<Question>>> fetchQuestions({
    required int quizId,
  }) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    try {
      final questions = await questionRemoteDataSource.fetchQuestions(quizId);

      return Right(questions);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<QuizHistory>>> fetchQuizHistory() async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    try {
      final quizHistory = await quizHistoryRemoteDataSource.fetchQuizHistory();
      return Right(quizHistory);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Quiz>>> fetchQuizzes({
    required int categoryId,
  }) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    try {
      final quizzes = await quizRemoteDataSource.fetchQuizzes(categoryId);
      return Right(quizzes);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuizResult>> submitAnswers({
    required int quizId,
    required SubmitAnswer payload,
  }) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }
    try {
      final toModelPayload = SubmitAnswerPayload(
        userId: payload.userId,
        timeTaken: payload.timeTaken,
        answers: payload.answers,
      );
      final result = await quizRemoteDataSource.submitAnswers(
        quizId,
        toModelPayload,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
