import 'package:flutter/material.dart';

class Category {
  final String name;
  final String icon;
  final int questions;
  final Color color;

  const Category({
    required this.name,
    required this.icon,
    required this.questions,
    required this.color,
  });
}
