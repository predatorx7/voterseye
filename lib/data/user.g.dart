// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      dateOfBirth: json['dateOfBirth'] as String?,
      email: json['email'] as String?,
      fullName: json['full_name'] as String,
      mobile: json['mobile'] as String?,
      residentName: json['residentName'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'dateOfBirth': instance.dateOfBirth,
      'email': instance.email,
      'full_name': instance.fullName,
      'mobile': instance.mobile,
      'residentName': instance.residentName,
    };
