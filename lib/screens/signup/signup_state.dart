import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

@freezed
class SignupState with _$SignupState {
  const SignupState._();

  const factory SignupState({
    @Default(0) int currentTextIndex,
    @Default(false) bool showVerifyButton,
    @Default(false) bool isAnimating,
  }) = _SignupState;
}
