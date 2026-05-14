import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';

class DailyChallenge extends StatefulWidget {
  const DailyChallenge({super.key});

  @override
  State<DailyChallenge> createState() => _DailyChallengeState();
}

class _DailyChallengeState extends State<DailyChallenge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _pulseAnim = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnim,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: HomeColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: HomeColors.accent.withOpacity(0.22),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: HomeColors.accent.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: const LinearGradient(
                  colors: [HomeColors.accent, Color(0xFFFF8C69)],
                ),
              ),
              child: const Center(
                child: Text('⚡', style: TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: HomeColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'DAILY CHALLENGE',
                      style: TextStyle(
                        color: HomeColors.accent,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Science Rapid Fire',
                    style: TextStyle(
                      color: HomeColors.textDark,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    '10 questions • 60 seconds',
                    style: TextStyle(color: HomeColors.textMid, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [HomeColors.accent, Color(0xFFFF8C69)],
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Text(
                'Play',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
