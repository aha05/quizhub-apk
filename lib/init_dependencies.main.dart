part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initHome();
  _initLeaderboard();
  _initProfile();

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => SecureStorage());

  serviceLocator.registerLazySingleton<TokenManager>(
    () => TokenManagerImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => ApiService(serviceLocator()));
}

void _initAuth() {
  // API
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => UserLogout(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        userLogout: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => FetchHomeData(serviceLocator()))
    ..registerLazySingleton(() => HomeBloc(fetchHomeData: serviceLocator()));
}

void _initLeaderboard() {
  serviceLocator
    ..registerFactory<LeaderboardRemoteDataSource>(
      () => LeaderboardRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<LeaderboardRepository>(
      () => LeaderboardRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => FetchLeaderboard(serviceLocator()))
    ..registerFactory(
      () => LeaderboardBloc(fetchLeaderboard: serviceLocator()),
    );
}

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => FetchProfileActivity(serviceLocator()))
    ..registerFactory(() => UpdateProfile(serviceLocator()))
    ..registerFactory(() => ChangePassword(serviceLocator()))
    ..registerFactory(
      () => ProfileBloc(
        fetchProfileActivity: serviceLocator(),
        updateProfile: serviceLocator(),
        changePassword: serviceLocator(),
      ),
    );
}
