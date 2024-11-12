// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_detail_members_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TournamentDetailMembersState {
  Object? get actionError => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;
  List<TournamentMember> get members => throw _privateConstructorUsedError;

  /// Create a copy of TournamentDetailMembersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentDetailMembersStateCopyWith<TournamentDetailMembersState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentDetailMembersStateCopyWith<$Res> {
  factory $TournamentDetailMembersStateCopyWith(
          TournamentDetailMembersState value,
          $Res Function(TournamentDetailMembersState) then) =
      _$TournamentDetailMembersStateCopyWithImpl<$Res,
          TournamentDetailMembersState>;
  @useResult
  $Res call(
      {Object? actionError,
      String? currentUserId,
      List<TournamentMember> members});
}

/// @nodoc
class _$TournamentDetailMembersStateCopyWithImpl<$Res,
        $Val extends TournamentDetailMembersState>
    implements $TournamentDetailMembersStateCopyWith<$Res> {
  _$TournamentDetailMembersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentDetailMembersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? currentUserId = freezed,
    Object? members = null,
  }) {
    return _then(_value.copyWith(
      actionError: freezed == actionError ? _value.actionError : actionError,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TournamentMember>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentDetailMembersStateImplCopyWith<$Res>
    implements $TournamentDetailMembersStateCopyWith<$Res> {
  factory _$$TournamentDetailMembersStateImplCopyWith(
          _$TournamentDetailMembersStateImpl value,
          $Res Function(_$TournamentDetailMembersStateImpl) then) =
      __$$TournamentDetailMembersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? actionError,
      String? currentUserId,
      List<TournamentMember> members});
}

/// @nodoc
class __$$TournamentDetailMembersStateImplCopyWithImpl<$Res>
    extends _$TournamentDetailMembersStateCopyWithImpl<$Res,
        _$TournamentDetailMembersStateImpl>
    implements _$$TournamentDetailMembersStateImplCopyWith<$Res> {
  __$$TournamentDetailMembersStateImplCopyWithImpl(
      _$TournamentDetailMembersStateImpl _value,
      $Res Function(_$TournamentDetailMembersStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentDetailMembersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionError = freezed,
    Object? currentUserId = freezed,
    Object? members = null,
  }) {
    return _then(_$TournamentDetailMembersStateImpl(
      actionError: freezed == actionError ? _value.actionError : actionError,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TournamentMember>,
    ));
  }
}

/// @nodoc

class _$TournamentDetailMembersStateImpl
    implements _TournamentDetailMembersState {
  const _$TournamentDetailMembersStateImpl(
      {this.actionError,
      this.currentUserId,
      final List<TournamentMember> members = const []})
      : _members = members;

  @override
  final Object? actionError;
  @override
  final String? currentUserId;
  final List<TournamentMember> _members;
  @override
  @JsonKey()
  List<TournamentMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'TournamentDetailMembersState(actionError: $actionError, currentUserId: $currentUserId, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentDetailMembersStateImpl &&
            const DeepCollectionEquality()
                .equals(other.actionError, actionError) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(actionError),
      currentUserId,
      const DeepCollectionEquality().hash(_members));

  /// Create a copy of TournamentDetailMembersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentDetailMembersStateImplCopyWith<
          _$TournamentDetailMembersStateImpl>
      get copyWith => __$$TournamentDetailMembersStateImplCopyWithImpl<
          _$TournamentDetailMembersStateImpl>(this, _$identity);
}

abstract class _TournamentDetailMembersState
    implements TournamentDetailMembersState {
  const factory _TournamentDetailMembersState(
          {final Object? actionError,
          final String? currentUserId,
          final List<TournamentMember> members}) =
      _$TournamentDetailMembersStateImpl;

  @override
  Object? get actionError;
  @override
  String? get currentUserId;
  @override
  List<TournamentMember> get members;

  /// Create a copy of TournamentDetailMembersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentDetailMembersStateImplCopyWith<
          _$TournamentDetailMembersStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
