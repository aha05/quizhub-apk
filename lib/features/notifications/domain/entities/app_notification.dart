import 'package:flutter/material.dart';

class AppNotification {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  bool isRead;

  AppNotification({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    this.isRead = false,
  });
}
