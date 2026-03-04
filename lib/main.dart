import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'repository/auth_repository.dart';
import 'services/api.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("App starting...");

  await dotenv.load(fileName: ".env");

  runApp(QuizHubApp());
}

class QuizHubApp extends StatelessWidget {

  const QuizHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizHub',
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}