import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_result.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/painters/score_ring_painter.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/utils/quiz_result_helpers.dart';

class ScoreCard extends StatefulWidget {
  final QuizResult result;
  final Quiz quiz;

  const ScoreCard({super.key, required this.result, required this.quiz});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scoreAnimation;

  Color get _resultColor => QuizResultHelpers.resultColor(widget.result.passed);

  Color get _resultColorLight =>
      QuizResultHelpers.resultColorLight(widget.result.passed);

  IconData get _resultIcon =>
      QuizResultHelpers.resultIcon(widget.result.passed);

  String get _resultTitle =>
      QuizResultHelpers.resultTitle(widget.result.passed);

  String get _resultSubtitle => QuizResultHelpers.resultSubtitle(
    widget.result.passed,
    widget.quiz.passPercentage,
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scoreAnimation = Tween<double>(
      begin: 0,
      end: widget.result.scorePercentage / 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Pass/Fail badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: _resultColorLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_resultIcon, size: 16, color: _resultColor),
                const SizedBox(width: 6),
                Text(
                  widget.result.passed ? 'PASSED' : 'FAILED',
                  style: TextStyle(
                    color: _resultColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Animated score ring
          AnimatedBuilder(
            animation: _scoreAnimation,
            builder: (context, child) {
              return SizedBox(
                width: 150,
                height: 150,
                child: CustomPaint(
                  painter: ScoreRingPainter(
                    progress: _scoreAnimation.value,
                    color: _resultColor,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(_scoreAnimation.value * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: _resultColor,
                          ),
                        ),
                        Text(
                          'Score',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Title & subtitle
          Text(
            _resultTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _resultSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            widget.quiz.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
