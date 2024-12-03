import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/feature/reports/data/report.dart';
import 'package:voterseye/feature/reports/reports.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class _Navigation {
  final route = GoRoute(
    path: 'report/:report_id',
    name: 'report',
    builder: (context, state) => const ReportsScreen(),
    // routes: [
    //   ShareReportsScreen.navigation.route,
    // ],
  );
}

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  static final navigation = _Navigation();

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final reportId = GoRouterState.of(context).pathParameters['report_id']!;
    final report = ref
        .watch(userReportsProvider)
        .firstWhere((report) => report.id == reportId);

    return Scaffold(
      appBar: AppBar(
        title: Text(report.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Scan QR code to share report proof',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Stack(
                fit: StackFit.passthrough,
                children: [
                  ShareReportsSection(
                    onReports: (ShareReportsResponse value) async {
                      try {
                        if (_loading) return;
                        _loading = true;
                        print({'ShareReportsSection.value': value});
                        final success = await report.shareProof(
                            ref.read(authProvider.notifier), value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Proof shared'),
                          ),
                        );
                      } catch (e, s) {
                        // TODO
                      }
                      _loading = false;
                      setState(() {
                        //
                      });
                    },
                  ),
                  if (_loading)
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sharing proof of this report..',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Report ID: $reportId',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Created: ${report.createdAt.toString().split('.')[0]}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareReportsSection extends ConsumerStatefulWidget {
  const ShareReportsSection({
    super.key,
    required this.onReports,
  });

  final ValueChanged<ShareReportsResponse> onReports;

  static final navigation = _Navigation();

  @override
  ConsumerState<ShareReportsSection> createState() => _SeekReportsScreenState();
}

class _SeekReportsScreenState extends ConsumerState<ShareReportsSection>
    with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final controller = MobileScannerController(
    useNewCameraSelector: true,
  );

  bool isFlashOn = false;

  late StreamSubscription<BarcodeCapture>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    attach();

    unawaited(controller.start());
  }

  void attach() {
    print({'ShareReportsSection.attach': 'attaching'});
    _subscription = controller.barcodes.listen(_handleBarcode);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print({'ShareReportsSection.didChangeAppLifecycleState': state});
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        attach();

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  Barcode? _barcode;

  void _handleBarcode(BarcodeCapture barcodes) {
    print({'ShareReportsSection._handleBarcode': 'did receive barcodes'});
    print(barcodes.barcodes.firstOrNull);
    if (mounted) {
      setState(() {
        final barcode = barcodes.barcodes.firstOrNull;
        _barcode = barcode;
        if (barcode != null) {
          _onBarcodeFound(barcode);
        }
      });
    }
  }

  void _onBarcodeFound(Barcode barcode) {
    print('on barcode found');
    print(barcode);
    final bytes = barcode.rawBytes;
    if (bytes == null) return;
    final decoded = utf8.decode(bytes);
    final parts = decoded.split('#');
    final [receiverId, attestationId, publicJWK] = parts;
    final ShareReportsResponse response = (
      receiverId: receiverId,
      attestationId: attestationId,
      publicJWK: publicJWK,
    );
    // context.pop(response);
    widget.onReports(response);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 10,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).colorScheme.inverseSurface,
        child: MobileScanner(
          key: qrKey,
          controller: controller,
          errorBuilder: (context, error, child) {
            return ScannerErrorWidget(error: error);
          },
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
