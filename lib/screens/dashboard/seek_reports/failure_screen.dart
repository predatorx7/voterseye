import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeekReportsFailureScreen extends StatelessWidget {
  const SeekReportsFailureScreen({super.key});

  static final route = GoRoute(
    path: 'failure',
    name: 'seek-reports-failure',
    builder: (context, state) => const SeekReportsFailureScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Receiving Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Failed to Receive Report',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'There was an error receiving the report.\nPlease try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
