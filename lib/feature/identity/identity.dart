import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voterseye/data/user.dart';

import 'package:flutter/material.dart' show BuildContext;
import 'country/in.dart';

export 'package:flutter/material.dart' show BuildContext;
export 'country/in.dart';

final class UserIdentityAuthenticationError {
  final String message;

  const UserIdentityAuthenticationError(this.message);

  @override
  String toString() {
    return 'UserIdentityAuthenticationError: $message';
  }
}

abstract class UserIdentityService {
  factory UserIdentityService(String countryCode) {
    switch (countryCode.toLowerCase().trim()) {
      case 'in':
        return ReclaimIndianIdentityService();
      default:
        throw Exception('Unsupported country code: $countryCode');
    }
  }

  Future<User> getUser(BuildContext context);
}

final userIdentityServiceProvider = Provider((ref) {
  return UserIdentityService('in');
});
