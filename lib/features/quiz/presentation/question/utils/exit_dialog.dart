import 'package:flutter/material.dart';

Future<bool> confirmExit(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Exit Quiz?'),
          content: const Text('Your progress will be lost.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Stay'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Exit'),
            ),
          ],
        ),
      ) ??
      false;
}
