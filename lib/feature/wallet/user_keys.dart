import 'package:voterseye/data/user.dart';
import 'package:voterseye/utils/keys.dart';

import 'package:flutter/foundation.dart';
import 'package:reclaim_flutter_sdk/reclaim_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WalletKeyPair {
  const WalletKeyPair({
    required this.privateKey,
    required this.publicKey,
  });

  static Future<WalletKeyPair> instance = WalletKeyPair.get();

  @protected
  static Future<WalletKeyPair> get() async {
    const walletKeyPairKey = 'voterseye#wallet_key_pair';
    final preferences = await SharedPreferences.getInstance();
    final base64KeyPair = preferences.getString(walletKeyPairKey);
    if (base64KeyPair == null) {
      final kp = await WalletKeyPair.create();
      await preferences.setString(walletKeyPairKey, await kp.exportKeyPair());
      return kp;
    }
    return WalletKeyPair.importKeyPair(base64KeyPair);
  }

  @protected
  static Future<WalletKeyPair> create() async {
    final sk = generatePrivateKey();
    final pk = getPublicKey(sk);

    return WalletKeyPair(
      privateKey: sk,
      publicKey: pk,
    );
  }

  @protected
  static Future<WalletKeyPair> importKeyPair(String base64KeyPair) async {
    final keyPairMap = json.decode(utf8.decode(base64.decode(base64KeyPair)));

    return WalletKeyPair(
      privateKey: keyPairMap['privateKey'],
      publicKey: keyPairMap['publicKey'],
    );
  }

  final String privateKey;
  final String publicKey;

  Future<String> exportPublicKey() async {
    return base64.encode(utf8.encode(publicKey));
  }

  Future<String> exportKeyPair() async {
    return base64.encode(utf8.encode(json.encode({
      'privateKey': privateKey,
      'publicKey': publicKey,
    })));
  }
}

class UserKeys {
  String privateKey;
  String publicKey;
  Uint8List symmetricKey;
  WalletKeyPair walletKeyPair;

  UserKeys({
    required this.privateKey,
    required this.publicKey,
    required this.symmetricKey,
    required this.walletKeyPair,
  });

  static Future<UserKeys> fromStorage() async {
    final privateKey = await getPrivateKey();
    final publicKey = getPublicKey(privateKey);
    final symmetricKey = deriveSymmetricKey(privateKey);

    return UserKeys(
      privateKey: privateKey,
      publicKey: publicKey,
      symmetricKey: symmetricKey,
      walletKeyPair: await WalletKeyPair.instance,
    );
  }

  static Future<UserKeys> fetch(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return UserKeys.fromStorage();
  }

  Future<void> remove() async {
    // Implementation for removing keys
  }
}
