import 'package:flutter/material.dart';

Color timerColor(int seconds) {
  if (seconds <= 60) return Colors.red;
  if (seconds <= 120) return Colors.orange;
  return Colors.green;
}
