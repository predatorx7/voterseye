// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: 'dateOfBirth')
  String? get dateOfBirth => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobile')
  String? get mobile => throw _privateConstructorUsedError;
  @JsonKey(name: 'residentName')
  String? get residentName => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: 'dateOfBirth') String? dateOfBirth,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'mobile') String? mobile,
      @JsonKey(name: 'residentName') String? residentName});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateOfBirth = freezed,
    Object? email = freezed,
    Object? fullName = null,
    Object? mobile = freezed,
    Object? residentName = freezed,
  }) {
    return _then(_value.copyWith(
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      residentName: freezed == residentName
          ? _value.residentName
          : residentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'dateOfBirth') String? dateOfBirth,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'mobile') String? mobile,
      @JsonKey(name: 'residentName') String? residentName});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateOfBirth = freezed,
    Object? email = freezed,
    Object? fullName = null,
    Object? mobile = freezed,
    Object? residentName = freezed,
  }) {
    return _then(_$UserImpl(
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      residentName: freezed == residentName
          ? _value.residentName
          : residentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {@JsonKey(name: 'dateOfBirth') this.dateOfBirth,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'full_name') required this.fullName,
      @JsonKey(name: 'mobile') this.mobile,
      @JsonKey(name: 'residentName') this.residentName})
      : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'mobile')
  final String? mobile;
  @override
  @JsonKey(name: 'residentName')
  final String? residentName;

  @override
  String toString() {
    return 'User(dateOfBirth: $dateOfBirth, email: $email, fullName: $fullName, mobile: $mobile, residentName: $residentName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.residentName, residentName) ||
                other.residentName == residentName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, dateOfBirth, email, fullName, mobile, residentName);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {@JsonKey(name: 'dateOfBirth') final String? dateOfBirth,
      @JsonKey(name: 'email') final String? email,
      @JsonKey(name: 'full_name') required final String fullName,
      @JsonKey(name: 'mobile') final String? mobile,
      @JsonKey(name: 'residentName') final String? residentName}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: 'dateOfBirth')
  String? get dateOfBirth;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'mobile')
  String? get mobile;
  @override
  @JsonKey(name: 'residentName')
  String? get residentName;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
