import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/screens/signup/signup.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final route = GoRoute(
    path: '/welcome',
    name: 'welcome',
    redirect: (context, state) {
      final authState = ProviderScope.containerOf(context).read(authProvider);
      if (!authState.isAuthenticated) {
        return null;
      }
      return '/dashboard';
    },
    builder: (context, state) => const WelcomeScreen(),
  );
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Column(
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Start your journey with us',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      context.goNamed(SignupScreen.navigation.route.name!);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
