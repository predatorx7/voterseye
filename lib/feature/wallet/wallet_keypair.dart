// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webcrypto/webcrypto.dart';
// import 'dart:convert';

// class WalletKeyPair {
//   const WalletKeyPair({
//     required this.privateKey,
//     required this.publicKey,
//   });

//   static Future<WalletKeyPair> instance = WalletKeyPair.get();

//   @protected
//   static Future<WalletKeyPair> get() async {
//     const walletKeyPairKey = 'voterseye#wallet_key_pair';
//     final preferences = await SharedPreferences.getInstance();
//     final base64KeyPair = preferences.getString(walletKeyPairKey);
//     if (base64KeyPair == null) {
//       final kp = await WalletKeyPair.create();
//       await preferences.setString(walletKeyPairKey, await kp.exportKeyPair());
//       return kp;
//     }
//     return WalletKeyPair.importKeyPair(base64KeyPair);
//   }

//   @protected
//   static Future<WalletKeyPair> create() async {
//     // Generate an RSA key pair with:
//     // - Key size: 2048 bits
//     // - Public exponent: 65537
//     // - For both signing and encryption
//     final keyPair = await RsaOaepPrivateKey.generateKey(
//       2048,
//       BigInt.from(65537),
//       Hash.sha256,
//     );

//     return WalletKeyPair(
//       privateKey: keyPair.privateKey,
//       publicKey: keyPair.publicKey,
//     );
//   }

//   @protected
//   static Future<WalletKeyPair> importKeyPair(String base64KeyPair) async {
//     final keyPairMap = json.decode(utf8.decode(base64.decode(base64KeyPair)));

//     return WalletKeyPair(
//       privateKey: await RsaOaepPrivateKey.importJsonWebKey(
//         keyPairMap['privateKey'],
//         Hash.sha256,
//       ),
//       publicKey: await RsaOaepPublicKey.importJsonWebKey(
//         keyPairMap['publicKey'],
//         Hash.sha256,
//       ),
//     );
//   }

//   final RsaOaepPrivateKey privateKey;
//   final RsaOaepPublicKey publicKey;

//   Future<String> exportPublicKey() async {
//     final publicKeyData = await publicKey.exportJsonWebKey();
//     return base64.encode(utf8.encode(json.encode(publicKeyData)));
//   }

//   Future<String> exportKeyPair() async {
//     final privateKeyData = await privateKey.exportJsonWebKey();
//     final publicKeyData = await publicKey.exportJsonWebKey();

//     return base64.encode(utf8.encode(json.encode({
//       'privateKey': privateKeyData,
//       'publicKey': publicKeyData,
//     })));
//   }
// }
