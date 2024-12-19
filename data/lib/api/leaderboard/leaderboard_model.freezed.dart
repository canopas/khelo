// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaderboardModel _$LeaderboardModelFromJson(Map<String, dynamic> json) {
  return _LeaderboardModel.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardModel {
  LeaderboardField get type => throw _privateConstructorUsedError;
  List<LeaderboardPlayer> get players => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardModelCopyWith<LeaderboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardModelCopyWith<$Res> {
  factory $LeaderboardModelCopyWith(
          LeaderboardModel value, $Res Function(LeaderboardModel) then) =
      _$LeaderboardModelCopyWithImpl<$Res, LeaderboardModel>;
  @useResult
  $Res call({LeaderboardField type, List<LeaderboardPlayer> players});
}

/// @nodoc
class _$LeaderboardModelCopyWithImpl<$Res, $Val extends LeaderboardModel>
    implements $LeaderboardModelCopyWith<$Res> {
  _$LeaderboardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? players = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LeaderboardField,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardPlayer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderboardModelImplCopyWith<$Res>
    implements $LeaderboardModelCopyWith<$Res> {
  factory _$$LeaderboardModelImplCopyWith(_$LeaderboardModelImpl value,
          $Res Function(_$LeaderboardModelImpl) then) =
      __$$LeaderboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LeaderboardField type, List<LeaderboardPlayer> players});
}

/// @nodoc
class __$$LeaderboardModelImplCopyWithImpl<$Res>
    extends _$LeaderboardModelCopyWithImpl<$Res, _$LeaderboardModelImpl>
    implements _$$LeaderboardModelImplCopyWith<$Res> {
  __$$LeaderboardModelImplCopyWithImpl(_$LeaderboardModelImpl _value,
      $Res Function(_$LeaderboardModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaderboardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? players = null,
  }) {
    return _then(_$LeaderboardModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LeaderboardField,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardPlayer>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardModelImpl implements _LeaderboardModel {
  const _$LeaderboardModelImpl(
      {required this.type, final List<LeaderboardPlayer> players = const []})
      : _players = players;

  factory _$LeaderboardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardModelImplFromJson(json);

  @override
  final LeaderboardField type;
  final List<LeaderboardPlayer> _players;
  @override
  @JsonKey()
  List<LeaderboardPlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'LeaderboardModel(type: $type, players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_players));

  /// Create a copy of LeaderboardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardModelImplCopyWith<_$LeaderboardModelImpl> get copyWith =>
      __$$LeaderboardModelImplCopyWithImpl<_$LeaderboardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardModelImplToJson(
      this,
    );
  }
}

abstract class _LeaderboardModel implements LeaderboardModel {
  const factory _LeaderboardModel(
      {required final LeaderboardField type,
      final List<LeaderboardPlayer> players}) = _$LeaderboardModelImpl;

  factory _LeaderboardModel.fromJson(Map<String, dynamic> json) =
      _$LeaderboardModelImpl.fromJson;

  @override
  LeaderboardField get type;
  @override
  List<LeaderboardPlayer> get players;

  /// Create a copy of LeaderboardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardModelImplCopyWith<_$LeaderboardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaderboardPlayer _$LeaderboardPlayerFromJson(Map<String, dynamic> json) {
  return _LeaderboardPlayer.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardPlayer {
  @TimeStampJsonConverter()
  DateTime get date => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  int get runs => throw _privateConstructorUsedError;
  int get wickets => throw _privateConstructorUsedError;
  int get catches => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel? get user => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardPlayer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardPlayerCopyWith<LeaderboardPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardPlayerCopyWith<$Res> {
  factory $LeaderboardPlayerCopyWith(
          LeaderboardPlayer value, $Res Function(LeaderboardPlayer) then) =
      _$LeaderboardPlayerCopyWithImpl<$Res, LeaderboardPlayer>;
  @useResult
  $Res call(
      {@TimeStampJsonConverter() DateTime date,
      String id,
      int runs,
      int wickets,
      int catches,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel? user});

  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$LeaderboardPlayerCopyWithImpl<$Res, $Val extends LeaderboardPlayer>
    implements $LeaderboardPlayerCopyWith<$Res> {
  _$LeaderboardPlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? id = null,
    Object? runs = null,
    Object? wickets = null,
    Object? catches = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      wickets: null == wickets
          ? _value.wickets
          : wickets // ignore: cast_nullable_to_non_nullable
              as int,
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  /// Create a copy of LeaderboardPlayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeaderboardPlayerImplCopyWith<$Res>
    implements $LeaderboardPlayerCopyWith<$Res> {
  factory _$$LeaderboardPlayerImplCopyWith(_$LeaderboardPlayerImpl value,
          $Res Function(_$LeaderboardPlayerImpl) then) =
      __$$LeaderboardPlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@TimeStampJsonConverter() DateTime date,
      String id,
      int runs,
      int wickets,
      int catches,
      @JsonKey(includeToJson: false, includeFromJson: false) UserModel? user});

  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$LeaderboardPlayerImplCopyWithImpl<$Res>
    extends _$LeaderboardPlayerCopyWithImpl<$Res, _$LeaderboardPlayerImpl>
    implements _$$LeaderboardPlayerImplCopyWith<$Res> {
  __$$LeaderboardPlayerImplCopyWithImpl(_$LeaderboardPlayerImpl _value,
      $Res Function(_$LeaderboardPlayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaderboardPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? id = null,
    Object? runs = null,
    Object? wickets = null,
    Object? catches = null,
    Object? user = freezed,
  }) {
    return _then(_$LeaderboardPlayerImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      runs: null == runs
          ? _value.runs
          : runs // ignore: cast_nullable_to_non_nullable
              as int,
      wickets: null == wickets
          ? _value.wickets
          : wickets // ignore: cast_nullable_to_non_nullable
              as int,
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardPlayerImpl implements _LeaderboardPlayer {
  const _$LeaderboardPlayerImpl(
      {@TimeStampJsonConverter() required this.date,
      required this.id,
      this.runs = 0,
      this.wickets = 0,
      this.catches = 0,
      @JsonKey(includeToJson: false, includeFromJson: false) this.user});

  factory _$LeaderboardPlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardPlayerImplFromJson(json);

  @override
  @TimeStampJsonConverter()
  final DateTime date;
  @override
  final String id;
  @override
  @JsonKey()
  final int runs;
  @override
  @JsonKey()
  final int wickets;
  @override
  @JsonKey()
  final int catches;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserModel? user;

  @override
  String toString() {
    return 'LeaderboardPlayer(date: $date, id: $id, runs: $runs, wickets: $wickets, catches: $catches, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardPlayerImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.runs, runs) || other.runs == runs) &&
            (identical(other.wickets, wickets) || other.wickets == wickets) &&
            (identical(other.catches, catches) || other.catches == catches) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, id, runs, wickets, catches, user);

  /// Create a copy of LeaderboardPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardPlayerImplCopyWith<_$LeaderboardPlayerImpl> get copyWith =>
      __$$LeaderboardPlayerImplCopyWithImpl<_$LeaderboardPlayerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardPlayerImplToJson(
      this,
    );
  }
}

abstract class _LeaderboardPlayer implements LeaderboardPlayer {
  const factory _LeaderboardPlayer(
      {@TimeStampJsonConverter() required final DateTime date,
      required final String id,
      final int runs,
      final int wickets,
      final int catches,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final UserModel? user}) = _$LeaderboardPlayerImpl;

  factory _LeaderboardPlayer.fromJson(Map<String, dynamic> json) =
      _$LeaderboardPlayerImpl.fromJson;

  @override
  @TimeStampJsonConverter()
  DateTime get date;
  @override
  String get id;
  @override
  int get runs;
  @override
  int get wickets;
  @override
  int get catches;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  UserModel? get user;

  /// Create a copy of LeaderboardPlayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardPlayerImplCopyWith<_$LeaderboardPlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
