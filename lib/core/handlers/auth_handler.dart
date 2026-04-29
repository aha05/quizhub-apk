import 'package:flutter/material.dart';
import '../exceptions/api_exception.dart';
import '../../features/auth/presentation/pages/login_screen.dart';

class AuthHandler {

  static void redirectToLogin(BuildContext context, ApiException e) {

    if (e.statusCode == 401) {
       Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
       );

      return;
    }

    // other errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Inalid Token")),
    );
  }
}