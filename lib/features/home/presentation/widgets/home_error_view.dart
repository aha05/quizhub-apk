import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';

class HomeErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const HomeErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomePresentationConstants.appTitle),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: onRetry,
          child: const Text(HomePresentationConstants.tryAgainLabel),
        ),
      ),
    );
  }
}
