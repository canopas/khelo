// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_game_tab_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyGameTabState {
  int get selectedTab => throw _privateConstructorUsedError;

  /// Create a copy of MyGameTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyGameTabStateCopyWith<MyGameTabState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyGameTabStateCopyWith<$Res> {
  factory $MyGameTabStateCopyWith(
          MyGameTabState value, $Res Function(MyGameTabState) then) =
      _$MyGameTabStateCopyWithImpl<$Res, MyGameTabState>;
  @useResult
  $Res call({int selectedTab});
}

/// @nodoc
class _$MyGameTabStateCopyWithImpl<$Res, $Val extends MyGameTabState>
    implements $MyGameTabStateCopyWith<$Res> {
  _$MyGameTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyGameTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTab = null,
  }) {
    return _then(_value.copyWith(
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyGameTabStateImplCopyWith<$Res>
    implements $MyGameTabStateCopyWith<$Res> {
  factory _$$MyGameTabStateImplCopyWith(_$MyGameTabStateImpl value,
          $Res Function(_$MyGameTabStateImpl) then) =
      __$$MyGameTabStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedTab});
}

/// @nodoc
class __$$MyGameTabStateImplCopyWithImpl<$Res>
    extends _$MyGameTabStateCopyWithImpl<$Res, _$MyGameTabStateImpl>
    implements _$$MyGameTabStateImplCopyWith<$Res> {
  __$$MyGameTabStateImplCopyWithImpl(
      _$MyGameTabStateImpl _value, $Res Function(_$MyGameTabStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyGameTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTab = null,
  }) {
    return _then(_$MyGameTabStateImpl(
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MyGameTabStateImpl implements _MyGameTabState {
  const _$MyGameTabStateImpl({this.selectedTab = 0});

  @override
  @JsonKey()
  final int selectedTab;

  @override
  String toString() {
    return 'MyGameTabState(selectedTab: $selectedTab)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyGameTabStateImpl &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedTab);

  /// Create a copy of MyGameTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyGameTabStateImplCopyWith<_$MyGameTabStateImpl> get copyWith =>
      __$$MyGameTabStateImplCopyWithImpl<_$MyGameTabStateImpl>(
          this, _$identity);
}

abstract class _MyGameTabState implements MyGameTabState {
  const factory _MyGameTabState({final int selectedTab}) = _$MyGameTabStateImpl;

  @override
  int get selectedTab;

  /// Create a copy of MyGameTabState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyGameTabStateImplCopyWith<_$MyGameTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
