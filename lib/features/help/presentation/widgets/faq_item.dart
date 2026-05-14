import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;
  const FaqItem({
    super.key,
    required this.question, 
    required this.answer
    });

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _open = !_open),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: HomeColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _open
                ? HomeColors.primary.withOpacity(0.3)
                : HomeColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: TextStyle(
                        color: HomeColors.textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(
                    _open
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: _open ? HomeColors.primary : HomeColors.textLight,
                  ),
                ],
              ),
            ),
            if (_open)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  widget.answer,
                  style: const TextStyle(
                    color: HomeColors.textMid,
                    fontSize: 13,
                    height: 1.55,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
