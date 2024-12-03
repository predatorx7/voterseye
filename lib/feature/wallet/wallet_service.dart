// import 'dart:convert';

// class WalletService {
//   /// Import a previously exported private key
//   Future<RsaOaepPrivateKey> importPrivateKey(String base64PrivateKey) async {
//     final privateKeyString = utf8.decode(base64.decode(base64PrivateKey));
//     final privateKeyData = json.decode(privateKeyString);

//     return await RsaOaepPrivateKey.importJsonWebKey(
//       privateKeyData as Map<String, dynamic>,
//       Hash.sha256,
//     );
//   }

//   /// Import a previously exported public key
//   Future<RsaOaepPublicKey> importPublicKey(String base64PublicKey) async {
//     final publicKeyString = utf8.decode(base64.decode(base64PublicKey));
//     final publicKeyData = json.decode(publicKeyString);

//     return await RsaOaepPublicKey.importJsonWebKey(
//       publicKeyData as Map<String, dynamic>,
//       Hash.sha256,
//     );
//   }
// }
