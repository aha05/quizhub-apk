import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/presentation/question/widgets/option_tile.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final bool isMultiple;
  final List<int> selectedOptions;
  final Function(int) onTap;

  const QuestionCard({
    super.key,
    required this.question,
    required this.isMultiple,
    required this.selectedOptions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMultiple)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Text(
                'Select all that apply',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              question.content,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...question.options.asMap().entries.map((entry) {
            final option = entry.value;
            final isSelected = selectedOptions.contains(option.id);

            return OptionTile(
              option: option,
              index: entry.key,
              isSelected: isSelected,
              isMultiple: isMultiple,
              onTap: () => onTap(option.id),
            );
          }),
        ],
      ),
    );
  }
}
