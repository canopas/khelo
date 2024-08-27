// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'make_team_admin_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MakeTeamAdminState {
  Object? get actionError => throw _privateConstructorUsedError;
  bool get pop => throw _privateConstructorUsedError;
  bool get isButtonEnabled => throw _privateConstructorUsedError;
  List<TeamPlayer> get selectedPlayers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MakeTeamAdminStateCopyWith<MakeTeamAdminState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MakeTeamAdminStateCopyWith<$Res> {
  factory $MakeTeamAdminStateCopyWith(
          MakeTeamAdminState value, $Res Function(MakeTeamAdminState) then) =
      _$MakeTeamAdminStateCopyWithImpl<$Res, MakeTeamAdminState>;
  @useResult
  $Res call(
      {Object? actionError,
      bool pop,
      bool isButtonEnabled,
      List<TeamPlayer> selectedPlayers});
}

/// @nodoc
class _$MakeTeamAdminStateCopyWithImpl<$Res, $Val extends MakeTeamAdminState>
    implements $MakeTeamAdminStateCopyWith<$Res> {
  _$MakeTeamAdminStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? pop = null,
    Object? isButtonEnabled = null,
    Object? selectedPlayers = null,
  }) {
    return _then(_value.copyWith(
      actionError: freezed == actionError ? _value.actionError : actionError,
      pop: null == pop
          ? _value.pop
          : pop // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonEnabled: null == isButtonEnabled
          ? _value.isButtonEnabled
          : isButtonEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedPlayers: null == selectedPlayers
          ? _value.selectedPlayers
          : selectedPlayers // ignore: cast_nullable_to_non_nullable
              as List<TeamPlayer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MakeTeamAdminStateImplCopyWith<$Res>
    implements $MakeTeamAdminStateCopyWith<$Res> {
  factory _$$MakeTeamAdminStateImplCopyWith(_$MakeTeamAdminStateImpl value,
          $Res Function(_$MakeTeamAdminStateImpl) then) =
      __$$MakeTeamAdminStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? actionError,
      bool pop,
      bool isButtonEnabled,
      List<TeamPlayer> selectedPlayers});
}

/// @nodoc
class __$$MakeTeamAdminStateImplCopyWithImpl<$Res>
    extends _$MakeTeamAdminStateCopyWithImpl<$Res, _$MakeTeamAdminStateImpl>
    implements _$$MakeTeamAdminStateImplCopyWith<$Res> {
  __$$MakeTeamAdminStateImplCopyWithImpl(_$MakeTeamAdminStateImpl _value,
      $Res Function(_$MakeTeamAdminStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? pop = null,
    Object? isButtonEnabled = null,
    Object? selectedPlayers = null,
  }) {
    return _then(_$MakeTeamAdminStateImpl(
      actionError: freezed == actionError ? _value.actionError : actionError,
      pop: null == pop
          ? _value.pop
          : pop // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonEnabled: null == isButtonEnabled
          ? _value.isButtonEnabled
          : isButtonEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedPlayers: null == selectedPlayers
          ? _value._selectedPlayers
          : selectedPlayers // ignore: cast_nullable_to_non_nullable
              as List<TeamPlayer>,
    ));
  }
}

/// @nodoc

class _$MakeTeamAdminStateImpl implements _MakeTeamAdminState {
  const _$MakeTeamAdminStateImpl(
      {this.actionError,
      this.pop = false,
      this.isButtonEnabled = false,
      final List<TeamPlayer> selectedPlayers = const []})
      : _selectedPlayers = selectedPlayers;

  @override
  final Object? actionError;
  @override
  @JsonKey()
  final bool pop;
  @override
  @JsonKey()
  final bool isButtonEnabled;
  final List<TeamPlayer> _selectedPlayers;
  @override
  @JsonKey()
  List<TeamPlayer> get selectedPlayers {
    if (_selectedPlayers is EqualUnmodifiableListView) return _selectedPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedPlayers);
  }

  @override
  String toString() {
    return 'MakeTeamAdminState(actionError: $actionError, pop: $pop, isButtonEnabled: $isButtonEnabled, selectedPlayers: $selectedPlayers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MakeTeamAdminStateImpl &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.pop, pop) || other.pop == pop) &&
            (identical(other.isButtonEnabled, isButtonEnabled) ||
                other.isButtonEnabled == isButtonEnabled) &&
            const DeepCollectionEquality()
                .equals(other._selectedPlayers, _selectedPlayers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(actionError),
      pop,
      isButtonEnabled,
      const DeepCollectionEquality().hash(_selectedPlayers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MakeTeamAdminStateImplCopyWith<_$MakeTeamAdminStateImpl> get copyWith =>
      __$$MakeTeamAdminStateImplCopyWithImpl<_$MakeTeamAdminStateImpl>(
          this, _$identity);
}

abstract class _MakeTeamAdminState implements MakeTeamAdminState {
  const factory _MakeTeamAdminState(
      {final Object? actionError,
      final bool pop,
      final bool isButtonEnabled,
      final List<TeamPlayer> selectedPlayers}) = _$MakeTeamAdminStateImpl;

  @override
  Object? get actionError;
  @override
  bool get pop;
  @override
  bool get isButtonEnabled;
  @override
  List<TeamPlayer> get selectedPlayers;
  @override
  @JsonKey(ignore: true)
  _$$MakeTeamAdminStateImplCopyWith<_$MakeTeamAdminStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
