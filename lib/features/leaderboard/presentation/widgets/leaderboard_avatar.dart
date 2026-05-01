import 'package:flutter/material.dart';

class LeaderboardAvatar extends StatelessWidget {
  final String username;
  final Color textColor;
  final Color backgroundColor;
  final double size;

  const LeaderboardAvatar({
    super.key,
    required this.username,
    required this.textColor,
    required this.backgroundColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: Text(
          username.isNotEmpty ? username[0].toUpperCase() : '?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: size * 0.4,
          ),
        ),
      ),
    );
  }
}
