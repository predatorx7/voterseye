import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voterseye/logging.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'screen.dart';

class SeekReportsSuccessScreen extends StatelessWidget {
  const SeekReportsSuccessScreen({super.key});

  static final route = GoRoute(
    path: 'success/:attestorId',
    name: 'seek-reports-success',
    builder: (context, state) => const SeekReportsSuccessScreen(),
  );

  @override
  Widget build(BuildContext context) {
    final attestorId = GoRouterState.of(context).pathParameters['attestorId'] ??
        sharedAttestorId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Received'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Report Successfully Received!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'The report has been shared with you.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            FilledButton(
              onPressed: () async {
                final url =
                    'https://testnet-scan.sign.global/attestation/onchain_evm_80002_${attestorId}';
                try {
                  $logger.info('lacunching: $url');
                  await launchUrlString(url);
                  $logger.info('DONE');
                } catch (e, s) {
                  $logger.severe('Faield to share', e, s);
                }
              },
              child: Text('View Report'),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
