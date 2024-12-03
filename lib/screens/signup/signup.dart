import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/screens/signup/signup_notifier.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final route = GoRoute(
    redirect: (context, state) {
      final authState = ProviderScope.containerOf(context).read(authProvider);
      if (!authState.isAuthenticated) {
        return null;
      }
      return '/dashboard';
    },
    path: '/signup',
    name: 'signup',
    builder: (context, state) => const SignupScreen(),
  );
}

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupNotifierProvider);
    final notifier = ref.read(signupNotifierProvider.notifier);
    final authState = ref.watch(authProvider);

    final lineHeight = MediaQuery.of(context)
            .textScaler
            .scale(Theme.of(context).textTheme.titleLarge?.fontSize ?? 20) *
        (Theme.of(context).textTheme.titleLarge?.height ?? 1.2);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Durations.medium4,
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    height: lineHeight * 2,
                  ),
                  child: Text(
                    authState.isProcessing
                        ? 'Fetching your wallet credentials from secure storage'
                        : notifier.verificationTexts[state.currentTextIndex],
                    key: ValueKey<int>(authState.isProcessing
                        ? 10000
                        : state.currentTextIndex),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              if (state.showVerifyButton)
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 64,
                          width: 64,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            notifier.startSignup(context);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            side: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
