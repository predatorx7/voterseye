import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:voterseye/data/user.dart';
import 'package:voterseye/feature/wallet/user_keys.dart';

part 'auth.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.authenticated(User user, UserKeys keys) =
      _Authenticated;
  const factory AuthState.processing(User user) = _ProcessingAuthenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;

  bool get isAuthenticated => this is _Authenticated;
  User? get user =>
      this is _Authenticated ? (this as _Authenticated).user : null;
  bool get isProcessing => this is _ProcessingAuthenticated;
  UserKeys? get keys =>
      this is _Authenticated ? (this as _Authenticated).keys : null;
}
