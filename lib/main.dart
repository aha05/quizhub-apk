import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'repository/auth_repository.dart';
import 'services/api.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'provider/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("App starting...");

  await dotenv.load(fileName: ".env");

  runApp(const QuizHubApp());
}

class QuizHubApp extends StatelessWidget {
  const QuizHubApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..loadUser(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QuizHub',
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}