import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:quizhub/features/home/presentation/screens/home_screen.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/presentation/question/screens/question_screen.dart';

class ActionButtons extends StatelessWidget {
  final Quiz quiz;
  final bool passed;

  const ActionButtons({super.key, required this.quiz, required this.passed});

  @override
  Widget build(BuildContext context) {
    final userId = context.select<AppUserCubit, int?>((cubit) {
      final state = cubit.state;
      return state is AppUserLoggedIn ? int.parse(state.user.id) : 0;
    });

    return Column(
      children: [
        if (passed)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuestionScreen(quiz: quiz, userId: userId),
                  ),
                );
              },
              icon: const Icon(Icons.replay_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        if (!passed) const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            },
            icon: const Icon(Icons.home_outlined),
            label: const Text('Back to Home'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
