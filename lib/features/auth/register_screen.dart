import 'package:flutter/material.dart';
import '../../repository/auth_repository.dart';
import '../../services/api.dart';
import 'login_screen.dart';
import '../../utils/error_mapper.dart';
import '../../core/components/error_dialog.dart';
import '../../core/exceptions/api_exception.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  final _authRepo = AuthRepository(Api());

  void _register() async {
    setState(() => _loading = true);
    try {
      await _authRepo.register(_nameController.text, _emailController.text, _passwordController.text);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } on ApiException catch (e) {
      String message = mapErrorToMessage(e.statusCode, e.body);
      ErrorDialog.show(context, message);
    } finally {
      setState(() => _loading = false);
    }
  }

 @override
 final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2575FC),
              ),
            ),
            const SizedBox(height: 30),

             TextFormField( // ✅ changed
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),

            const SizedBox(height: 15),

            TextFormField( // ✅ changed
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                if (!value.contains('@')) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),

            const SizedBox(height: 15),

            TextFormField( // ✅ changed
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _register();
                      }
                    },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: const Color(0xFF2575FC),
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                            ),
                          ),
                        ),
                ),
                TextButton(onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                }, child: Text("Do have an account? Login", style: TextStyle(color: Colors.grey))),
          ],

        ),
      ),
    ),
  );
}

}