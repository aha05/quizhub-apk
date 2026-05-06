import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_result.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/widgets/action_buttons.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/widgets/breakdown_card.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/widgets/score_card.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/widgets/stats_row.dart';

class QuizResultScreen extends StatefulWidget {
  final QuizResult result;
  final Quiz quiz;

  const QuizResultScreen({super.key, required this.result, required this.quiz});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );


    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Quiz Result'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ScoreCard(result: widget.result, quiz: widget.quiz),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    StatsRow(
                      correctAnswers: widget.result.correctAnswers,
                      wrongAnswers: widget.result.wrongAnswers,
                      formattedTime: widget.result.formattedTime,
                    ),
                    const SizedBox(height: 16),
                    BreakdownCard(
                      total: widget.result.totalQuestions,
                      correct: widget.result.correctAnswers,
                      wrong: widget.result.wrongAnswers,
                      passScore: widget.quiz.passPercentage,
                      scorePercentage: widget.result.scorePercentage.toInt(),
                      passed: widget.result.passed,
                    ),
                    const SizedBox(height: 24),
                    ActionButtons(
                      quiz: widget.quiz,
                      passed: widget.result.passed,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
