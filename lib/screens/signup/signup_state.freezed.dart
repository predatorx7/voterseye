// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignupState {
  int get currentTextIndex => throw _privateConstructorUsedError;
  bool get showVerifyButton => throw _privateConstructorUsedError;
  bool get isAnimating => throw _privateConstructorUsedError;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupStateCopyWith<SignupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupStateCopyWith<$Res> {
  factory $SignupStateCopyWith(
          SignupState value, $Res Function(SignupState) then) =
      _$SignupStateCopyWithImpl<$Res, SignupState>;
  @useResult
  $Res call({int currentTextIndex, bool showVerifyButton, bool isAnimating});
}

/// @nodoc
class _$SignupStateCopyWithImpl<$Res, $Val extends SignupState>
    implements $SignupStateCopyWith<$Res> {
  _$SignupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTextIndex = null,
    Object? showVerifyButton = null,
    Object? isAnimating = null,
  }) {
    return _then(_value.copyWith(
      currentTextIndex: null == currentTextIndex
          ? _value.currentTextIndex
          : currentTextIndex // ignore: cast_nullable_to_non_nullable
              as int,
      showVerifyButton: null == showVerifyButton
          ? _value.showVerifyButton
          : showVerifyButton // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnimating: null == isAnimating
          ? _value.isAnimating
          : isAnimating // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupStateImplCopyWith<$Res>
    implements $SignupStateCopyWith<$Res> {
  factory _$$SignupStateImplCopyWith(
          _$SignupStateImpl value, $Res Function(_$SignupStateImpl) then) =
      __$$SignupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentTextIndex, bool showVerifyButton, bool isAnimating});
}

/// @nodoc
class __$$SignupStateImplCopyWithImpl<$Res>
    extends _$SignupStateCopyWithImpl<$Res, _$SignupStateImpl>
    implements _$$SignupStateImplCopyWith<$Res> {
  __$$SignupStateImplCopyWithImpl(
      _$SignupStateImpl _value, $Res Function(_$SignupStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTextIndex = null,
    Object? showVerifyButton = null,
    Object? isAnimating = null,
  }) {
    return _then(_$SignupStateImpl(
      currentTextIndex: null == currentTextIndex
          ? _value.currentTextIndex
          : currentTextIndex // ignore: cast_nullable_to_non_nullable
              as int,
      showVerifyButton: null == showVerifyButton
          ? _value.showVerifyButton
          : showVerifyButton // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnimating: null == isAnimating
          ? _value.isAnimating
          : isAnimating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SignupStateImpl extends _SignupState {
  const _$SignupStateImpl(
      {this.currentTextIndex = 0,
      this.showVerifyButton = false,
      this.isAnimating = false})
      : super._();

  @override
  @JsonKey()
  final int currentTextIndex;
  @override
  @JsonKey()
  final bool showVerifyButton;
  @override
  @JsonKey()
  final bool isAnimating;

  @override
  String toString() {
    return 'SignupState(currentTextIndex: $currentTextIndex, showVerifyButton: $showVerifyButton, isAnimating: $isAnimating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupStateImpl &&
            (identical(other.currentTextIndex, currentTextIndex) ||
                other.currentTextIndex == currentTextIndex) &&
            (identical(other.showVerifyButton, showVerifyButton) ||
                other.showVerifyButton == showVerifyButton) &&
            (identical(other.isAnimating, isAnimating) ||
                other.isAnimating == isAnimating));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentTextIndex, showVerifyButton, isAnimating);

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupStateImplCopyWith<_$SignupStateImpl> get copyWith =>
      __$$SignupStateImplCopyWithImpl<_$SignupStateImpl>(this, _$identity);
}

abstract class _SignupState extends SignupState {
  const factory _SignupState(
      {final int currentTextIndex,
      final bool showVerifyButton,
      final bool isAnimating}) = _$SignupStateImpl;
  const _SignupState._() : super._();

  @override
  int get currentTextIndex;
  @override
  bool get showVerifyButton;
  @override
  bool get isAnimating;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupStateImplCopyWith<_$SignupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
