// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_stats_tab_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyStatsTabState {
  int get selectedTab => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyStatsTabStateCopyWith<MyStatsTabState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyStatsTabStateCopyWith<$Res> {
  factory $MyStatsTabStateCopyWith(
          MyStatsTabState value, $Res Function(MyStatsTabState) then) =
      _$MyStatsTabStateCopyWithImpl<$Res, MyStatsTabState>;
  @useResult
  $Res call({int selectedTab});
}

/// @nodoc
class _$MyStatsTabStateCopyWithImpl<$Res, $Val extends MyStatsTabState>
    implements $MyStatsTabStateCopyWith<$Res> {
  _$MyStatsTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$MyStatsTabStateImplCopyWith<$Res>
    implements $MyStatsTabStateCopyWith<$Res> {
  factory _$$MyStatsTabStateImplCopyWith(_$MyStatsTabStateImpl value,
          $Res Function(_$MyStatsTabStateImpl) then) =
      __$$MyStatsTabStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedTab});
}

/// @nodoc
class __$$MyStatsTabStateImplCopyWithImpl<$Res>
    extends _$MyStatsTabStateCopyWithImpl<$Res, _$MyStatsTabStateImpl>
    implements _$$MyStatsTabStateImplCopyWith<$Res> {
  __$$MyStatsTabStateImplCopyWithImpl(
      _$MyStatsTabStateImpl _value, $Res Function(_$MyStatsTabStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTab = null,
  }) {
    return _then(_$MyStatsTabStateImpl(
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MyStatsTabStateImpl implements _MyStatsTabState {
  const _$MyStatsTabStateImpl({this.selectedTab = 0});

  @override
  @JsonKey()
  final int selectedTab;

  @override
  String toString() {
    return 'MyStatsTabState(selectedTab: $selectedTab)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyStatsTabStateImpl &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedTab);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyStatsTabStateImplCopyWith<_$MyStatsTabStateImpl> get copyWith =>
      __$$MyStatsTabStateImplCopyWithImpl<_$MyStatsTabStateImpl>(
          this, _$identity);
}

abstract class _MyStatsTabState implements MyStatsTabState {
  const factory _MyStatsTabState({final int selectedTab}) =
      _$MyStatsTabStateImpl;

  @override
  int get selectedTab;
  @override
  @JsonKey(ignore: true)
  _$$MyStatsTabStateImplCopyWith<_$MyStatsTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
