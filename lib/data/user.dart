import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    @JsonKey(name: 'dateOfBirth') String? dateOfBirth,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'mobile') String? mobile,
    @JsonKey(name: 'residentName') String? residentName,
  }) = _User;

  String get realName => residentName ?? fullName;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
