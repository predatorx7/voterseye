import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/feature/identity/identity.dart';
import 'package:voterseye/logging.dart';

import 'signup_state.dart';

final signupNotifierProvider =
    AutoDisposeNotifierProvider<SignupNotifier, SignupState>(
        SignupNotifier.new);

class SignupNotifier extends AutoDisposeNotifier<SignupState> {
  SignupNotifier() : super();

  @override
  @protected
  SignupState build() {
    Future.microtask(startTextAnimation);
    return const SignupState();
  }

  final List<String> verificationTexts = [
    'Setting up your account...',
    'Preparing your workspace...',
    'Almost there...',
    'Configuring your preferences...',
    'Ready to verify your identity!',
  ];

  Future<void> startTextAnimation() async {
    state = state.copyWith(isAnimating: true);

    for (int i = 0; i < verificationTexts.length; i++) {
      await Future.delayed(const Duration(milliseconds: 800));

      state = state.copyWith(
        currentTextIndex: i,
        showVerifyButton: i == verificationTexts.length - 1,
      );
    }

    state = state.copyWith(isAnimating: false);
  }

  void resetAnimation() {
    state = const SignupState();
    startTextAnimation();
  }

  void startSignup(BuildContext context) async {
    final am = ref.read(authProvider.notifier);
    try {
      final userIdentityService = ref.read(userIdentityServiceProvider);
      final user = await userIdentityService.getUser(context);
      am.setCredentials(user);
      $logger.info('signup complete');
    } catch (e, s) {
      $logger.severe('Error during signup', e, s);
    }
  }
}
