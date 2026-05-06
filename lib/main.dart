import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizhub/app/auth_gate.dart';
import 'package:quizhub/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:quizhub/core/di/service_locator.dart';
import 'package:quizhub/core/theme/app_theme.dart';
import 'package:quizhub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:quizhub/features/home/presentation/bloc/home_bloc.dart';
import 'package:quizhub/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  await dotenv.load(fileName: ".env");

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),

        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()..add(AuthIsUserLoggedIn()),
        ),

        BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz-Hub',
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}
