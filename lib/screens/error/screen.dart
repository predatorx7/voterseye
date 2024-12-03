import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:voterseye/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({
    super.key,
    required this.routerState,
  });

  final GoRouterState routerState;

  static Widget errorBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return AppErrorScreen(routerState: state);
  }

  @override
  Widget build(BuildContext context) {
    final rs = routerState;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (kDebugMode) SelectableText(rs.error?.toString() ?? 'unknown'),
            SelectableText(
              context.l10n.thatsAnError,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.merge(
                  TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
            SelectableText(
              context.l10n.requestedPageNotFound,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SelectableText(
              context.l10n.thatsAllWeKnow,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.merge(
                    TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () => context.go('/'),
              child: Text(context.l10n.home),
            ),
          ],
        ),
      ),
    );
  }
}
