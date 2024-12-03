import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class YouQr extends ConsumerStatefulWidget {
  const YouQr({super.key});

  @override
  ConsumerState<YouQr> createState() => _YouQrState();
}

class _YouQrState extends ConsumerState<YouQr> {
  @override
  Widget build(BuildContext context) {
    final publicKey = ref.watch(authProvider).keys?.publicKey;

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data: publicKey ?? '',
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(
              height: 16,
            ),
            SelectableText(
              publicKey ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
