import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/data/user.dart';
import 'package:voterseye/feature/wallet/user_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/auth.dart';

final authProvider = NotifierProvider<AuthManager, AuthState>(AuthManager.new);

final ValueListenable<AuthState> authChangeNotifier =
    ValueNotifier<AuthState>(const AuthState.unauthenticated());

class AuthManager extends Notifier<AuthState> {
  AuthManager();

  String? get publicKey => state.keys?.publicKey;

  @override
  AuthState build() {
    _hydrateUser();
    return authChangeNotifier.value;
  }

  void setCredentials(User user) async {
    state = AuthState.processing(user);
    _loadKeysFromWallet(user);
  }

  void _loadKeysFromWallet(User user) async {
    final keys = await UserKeys.fetch(user);
    final current = state.user;
    if (current == null) return;
    state = AuthState.authenticated(current, keys);
  }

  final _preference = SharedPreferences.getInstance();

  static const _userPersistenceKey = 'frog#user';

  Future<void> _hydrateUser() async {
    final preference = await _preference;
    final userJson = preference.getString(_userPersistenceKey);
    if (userJson != null) {
      final user = User.fromJson(jsonDecode(userJson));
      state = AuthState.processing(user);
      _loadKeysFromWallet(user);
    }
  }

  Future<void> _saveUser(User? user) async {
    final preference = await _preference;
    if (user != null) {
      await preference.setString(
        _userPersistenceKey,
        json.encode(user.toJson()),
      );
    } else {
      await preference.remove(_userPersistenceKey);
    }
  }

  @override
  set state(AuthState value) {
    if (value != state) {
      Future.microtask(() {
        _saveUser(value.user);
        (authChangeNotifier as ValueNotifier).value = value;
      });
    }
    super.state = value;
  }

  void signOut() {
    state = const AuthState.unauthenticated();
  }
}
