import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../model/quiz_model.dart';
import '../../model/category_model.dart';
import '../../model/enums.dart'; 
import '../../model/user_model.dart'; 
import 'quiz_question_screen.dart';
import '../../services/quiz_service.dart';
import '../../services/api.dart';
import '../../core/handlers/auth_handler.dart';
import '../../core/exceptions/api_exception.dart';


class QuizListScreen extends StatefulWidget {
  final Category category;

  const QuizListScreen({super.key, required this.category});

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
 final QuizService _service = QuizService(Api());

  bool isLoading = true;
  List<Quiz> quizzes = [];
  String? error;

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    try {
      final results = await _service.fetchQuizzes(widget.category.id);

      setState(() {
        quizzes = results as List<Quiz>;
        isLoading = false;
      });

    } on ApiException catch (e) {
      if (e.statusCode == 401){
          AuthHandler.redirectToLogin(context, e);
      }
      setState(() {
        error = 'Failed to load quizzes: $e';
        isLoading = false;
      });
    }
  }

  Color _difficultyColor(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return Colors.green;
      case Difficulty.MEDIUM:
        return Colors.orange;
      case Difficulty.HARD:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) { 

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  error = null;
                });
                fetchQuizzes();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (quizzes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'No quizzes available for this category.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: quizzes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final quiz = quizzes[index];
        return _QuizCard(
          quiz: quiz,
          difficultyColor: _difficultyColor(quiz.difficulty),
          onTap: () {
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    QuizQuestionScreen(quiz: quiz, userId: user?.id),
              ),
            );
          },
        );
      },
    );
  }
}


class _QuizCard extends StatelessWidget {
  final Quiz quiz;
  final Color difficultyColor;
  final VoidCallback onTap;

  const _QuizCard({
    required this.quiz,
    required this.difficultyColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + difficulty badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    quiz.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: difficultyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: difficultyColor.withOpacity(0.4)),
                  ),
                  child: Text(
                    quiz.difficulty.label,
                    style: TextStyle(
                      color: difficultyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Description
            Text(
              quiz.description,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Stats row
            Row(
              children: [
                _StatChip(
                  icon: Icons.help_outline,
                  label: '${quiz.questions} Questions',
                ),
                const SizedBox(width: 16),
                _StatChip(
                  icon: Icons.timer_outlined,
                  label: '${quiz.timeLimit} min',
                ),
                const SizedBox(width: 16),
                _StatChip(
                  icon: Icons.flag_outlined,
                  label: 'Pass: ${quiz.passPercentage}%',
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }
}