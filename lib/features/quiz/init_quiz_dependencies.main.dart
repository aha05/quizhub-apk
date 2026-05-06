part of 'init_quiz_dependencies.dart';

void initQuizDependencies(GetIt serviceLocator) {
  // ─── DataSource ───
  serviceLocator
    ..registerFactory<QuizRemoteDataSource>(
      () => QuizRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<QuestionRemoteDataSource>(
      () => QuestionRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<QuizHistoryRemoteDataSource>(
      () => QuizHistoryRemoteDataSourceImpl(serviceLocator()),
    );

  // ─── Repository ───
  serviceLocator.registerFactory<QuizRepository>(
    () => QuizRepositoryImpl(
      quizRemoteDataSource: serviceLocator(),
      questionRemoteDataSource: serviceLocator(),
      quizHistoryRemoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
  );

  // ─── UseCases ───
  serviceLocator.registerFactory(() => Questions(serviceLocator()));

  serviceLocator.registerFactory(() => Quizzes(serviceLocator()));

  serviceLocator.registerFactory(() => QuizHistoryUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => SubmitQuizAnswers(serviceLocator()));

  // ─── Blocs ───
  serviceLocator
    ..registerFactory(
      () => QuizHistoryBloc(quizHistoryUsecase: serviceLocator()),
    )
    ..registerFactory(() => QuizListBloc(quizzes: serviceLocator()))
    ..registerFactory(
      () => QuestionBloc(
        questions: serviceLocator(),
        submitQuizAnswers: serviceLocator(),
      ),
    )
    ..registerFactory(() => QuizReviewBloc(serviceLocator()));
}
