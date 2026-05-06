import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/option.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/option_tag.dart';

class ReviewOption extends StatelessWidget {
  final Option option;
  final bool isSelected;
  final bool isCorrectOption;

  const ReviewOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrectOption,
  });

  @override
  Widget build(BuildContext context) {
    // Determine display state
    final bool isWrongSelection = isSelected && !isCorrectOption;

    Color borderColor;
    Color bgColor;
    Color iconColor;
    IconData icon;

    if (isCorrectOption) {
      borderColor = const Color(0xFF22C55E);
      bgColor = const Color(0xFFDCFCE7);
      iconColor = const Color(0xFF22C55E);
      icon = Icons.check_circle_rounded;
    } else if (isWrongSelection) {
      borderColor = const Color(0xFFEF4444);
      bgColor = const Color(0xFFFFE4E6);
      iconColor = const Color(0xFFEF4444);
      icon = Icons.cancel_rounded;
    } else {
      borderColor = Colors.grey.shade200;
      bgColor = Colors.grey.shade50;
      iconColor = Colors.grey.shade300;
      icon = Icons.radio_button_unchecked;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              option.text,
              style: TextStyle(
                fontSize: 14,
                color: isCorrectOption || isWrongSelection
                    ? Colors.black87
                    : Colors.grey.shade500,
                fontWeight: isCorrectOption || isWrongSelection
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ),
          // Labels
          if (isCorrectOption && isSelected)
            OptionTag(
              label: 'Your answer · Correct',
              color: const Color(0xFF22C55E),
            )
          else if (isCorrectOption)
            OptionTag(label: 'Correct answer', color: const Color(0xFF22C55E))
          else if (isWrongSelection)
            OptionTag(label: 'Your answer', color: const Color(0xFFEF4444)),
        ],
      ),
    );
  }
}
