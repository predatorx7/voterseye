import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/screens/dashboard/screen.dart';
import 'package:voterseye/screens/welcome.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final route = GoRoute(
    path: '/',
    name: '/',
    builder: (context, state) => const LaunchScreen(),
  );
}

class LaunchScreen extends ConsumerStatefulWidget {
  const LaunchScreen({
    super.key,
  });

  static final navigation = _Navigation();

  @override
  ConsumerState<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends ConsumerState<LaunchScreen> {
  final Completer _launchApp = Completer<void>();

  @override
  void initState() {
    super.initState();
    // preinitialize the auth state
    ref.read(authProvider);
    Future.delayed(const Duration(milliseconds: 1400), _navigateNext);
  }

  void _navigateNext() {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated) {
      return context.goNamed(WelcomeScreen.navigation.route.name!);
    }
    return context.goNamed(DashboardScreen.navigation.route.name!);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: FutureBuilder(
          future: _launchApp.future,
          builder: (context, snapshot) {
            // if (_launchApp.isCompleted) {
            //   return const SizedBox();
            // }
            return _AnimatingSplash(
              onComplete: _launchApp.complete,
            );
          },
        ),
      ),
    );
  }
}

class _AnimatingSplash extends ConsumerStatefulWidget {
  const _AnimatingSplash({
    required this.onComplete,
  });

  final VoidCallback onComplete;

  @override
  ConsumerState<_AnimatingSplash> createState() => _AnimatingSplashState();
}

class _AnimatingSplashState extends ConsumerState<_AnimatingSplash> {
  bool _isBackgroundLayerVisible = false;
  bool _isForegroundLayerVisible = false;

  @override
  void initState() {
    super.initState();
    start();
    // good place to initialize some providers
  }

  void start() async {
    Future.delayed(const Duration(seconds: 2), widget.onComplete);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isBackgroundLayerVisible = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        _isForegroundLayerVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const scale = 0.6;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isBackgroundLayerVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/brand/brand.png'),
                  ),
                ),
                child: SizedBox(
                  width: 400 * scale,
                  height: 400 * scale,
                ),
              ),
            ),
            // AnimatedOpacity(
            //   opacity: _isForegroundLayerVisible ? 1.0 : 0.0,
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeIn,
            //   child: const DecoratedBox(
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage(
            //           'assets/brand/brand.png',
            //         ),
            //       ),
            //     ),
            //     child: SizedBox(
            //       width: 100 * scale,
            //       height: 100 * scale,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
