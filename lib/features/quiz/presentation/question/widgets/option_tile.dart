import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/option.dart';

class OptionTile extends StatelessWidget {
  final Option option;
  final int index;
  final bool isSelected;
  final bool isMultiple;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isMultiple,
    required this.onTap,
  });

  static const _labels = ['A', 'B', 'C', 'D', 'E'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4F46E5).withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4F46E5) : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4F46E5)
                    : Colors.grey.shade100,
                shape: isMultiple ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: isMultiple ? BorderRadius.circular(6) : null,
              ),
              child: Center(
                child: isMultiple
                    ? Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: isSelected ? Colors.white : Colors.grey.shade400,
                        size: 18,
                      )
                    : Text(
                        index < _labels.length ? _labels[index] : '?',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.text,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? const Color(0xFF4F46E5) : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
