import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:voterseye/data/user.dart';
import 'package:voterseye/feature/identity/identity.dart';
import 'package:voterseye/logging.dart';
import 'package:gnarkprover/gnarkprover.dart';
import 'package:reclaim_flutter_sdk/reclaim_flutter_sdk.dart';

class _ReclaimIndianIdentitySecrets {
  static const String appId = String.fromEnvironment(
    'RECLAIM_APP_ID',
  );
  static const String appSecret = String.fromEnvironment(
    'RECLAIM_APP_SERCRET',
  );
  static const providerId = String.fromEnvironment(
    'RECLAIM_PROVIDER_ID',
    defaultValue: 'c9f2b456-dd97-4bd6-9497-2d899211efbd',
  );
}

class ReclaimIndianIdentityService implements UserIdentityService {
  Future<CreateClaimOutput?> startVerification(BuildContext context) async {
    debugCanPrintLogs = kDebugMode;
    // Getting the Gnark prover instance to initialize in advance before usage because initialization can take time.
    // This can also be done in the `main` function.
    // Calling this more than once is safe.
    Gnarkprover.getInstance();

    await Flags.setCookiePersist(true);

    final reclaimVerification = ReclaimVerification(
      buildContext: context,
      appId: _ReclaimIndianIdentitySecrets.appId,
      providerId: _ReclaimIndianIdentitySecrets.providerId,
      secret: _ReclaimIndianIdentitySecrets.appSecret,
      context: '',
      parameters: {},
      hideLanding: true,
      computeAttestorProof: (type, bytes) async {
        // Get gnark prover instance and compute the attestor proof.
        return (await Gnarkprover.getInstance())
            .computeWitnessProof(type, bytes);
      },
    );

    final proofs = await reclaimVerification.startVerification();
    return proofs;
  }

  @override
  Future<User> getUser(BuildContext context) async {
    try {
      final proofs = await startVerification(context);
      if (proofs == null) {
        throw UserIdentityAuthenticationError('Verification cancelled');
      }
      final data = json.decode(proofs.claimData.context)["extractedParameters"];
      if (data == null || (data is Map && data.isEmpty)) {
        throw UserIdentityAuthenticationError('No data found');
      }
      return User.fromJson(data);
    } catch (e, s) {
      logging.severe('Error getting user', e, s);
      throw UserIdentityAuthenticationError('Error getting user');
    }
  }
}
