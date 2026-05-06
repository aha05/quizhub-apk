import 'package:flutter/material.dart';

class HistoryLoadingView extends StatelessWidget {
  const HistoryLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}