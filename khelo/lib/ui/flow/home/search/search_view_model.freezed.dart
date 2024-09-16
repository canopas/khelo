// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchHomeViewState {
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  List<MatchModel> get searchedMatches => throw _privateConstructorUsedError;

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchHomeViewStateCopyWith<SearchHomeViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchHomeViewStateCopyWith<$Res> {
  factory $SearchHomeViewStateCopyWith(
          SearchHomeViewState value, $Res Function(SearchHomeViewState) then) =
      _$SearchHomeViewStateCopyWithImpl<$Res, SearchHomeViewState>;
  @useResult
  $Res call(
      {TextEditingController searchController,
      List<MatchModel> searchedMatches});
}

/// @nodoc
class _$SearchHomeViewStateCopyWithImpl<$Res, $Val extends SearchHomeViewState>
    implements $SearchHomeViewStateCopyWith<$Res> {
  _$SearchHomeViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? searchedMatches = null,
  }) {
    return _then(_value.copyWith(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      searchedMatches: null == searchedMatches
          ? _value.searchedMatches
          : searchedMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchHomeViewStateImplCopyWith<$Res>
    implements $SearchHomeViewStateCopyWith<$Res> {
  factory _$$SearchHomeViewStateImplCopyWith(_$SearchHomeViewStateImpl value,
          $Res Function(_$SearchHomeViewStateImpl) then) =
      __$$SearchHomeViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController searchController,
      List<MatchModel> searchedMatches});
}

/// @nodoc
class __$$SearchHomeViewStateImplCopyWithImpl<$Res>
    extends _$SearchHomeViewStateCopyWithImpl<$Res, _$SearchHomeViewStateImpl>
    implements _$$SearchHomeViewStateImplCopyWith<$Res> {
  __$$SearchHomeViewStateImplCopyWithImpl(_$SearchHomeViewStateImpl _value,
      $Res Function(_$SearchHomeViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchController = null,
    Object? searchedMatches = null,
  }) {
    return _then(_$SearchHomeViewStateImpl(
      searchController: null == searchController
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      searchedMatches: null == searchedMatches
          ? _value._searchedMatches
          : searchedMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
    ));
  }
}

/// @nodoc

class _$SearchHomeViewStateImpl implements _SearchHomeViewState {
  const _$SearchHomeViewStateImpl(
      {required this.searchController,
      final List<MatchModel> searchedMatches = const []})
      : _searchedMatches = searchedMatches;

  @override
  final TextEditingController searchController;
  final List<MatchModel> _searchedMatches;
  @override
  @JsonKey()
  List<MatchModel> get searchedMatches {
    if (_searchedMatches is EqualUnmodifiableListView) return _searchedMatches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedMatches);
  }

  @override
  String toString() {
    return 'SearchHomeViewState(searchController: $searchController, searchedMatches: $searchedMatches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchHomeViewStateImpl &&
            (identical(other.searchController, searchController) ||
                other.searchController == searchController) &&
            const DeepCollectionEquality()
                .equals(other._searchedMatches, _searchedMatches));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchController,
      const DeepCollectionEquality().hash(_searchedMatches));

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchHomeViewStateImplCopyWith<_$SearchHomeViewStateImpl> get copyWith =>
      __$$SearchHomeViewStateImplCopyWithImpl<_$SearchHomeViewStateImpl>(
          this, _$identity);
}

abstract class _SearchHomeViewState implements SearchHomeViewState {
  const factory _SearchHomeViewState(
      {required final TextEditingController searchController,
      final List<MatchModel> searchedMatches}) = _$SearchHomeViewStateImpl;

  @override
  TextEditingController get searchController;
  @override
  List<MatchModel> get searchedMatches;

  /// Create a copy of SearchHomeViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchHomeViewStateImplCopyWith<_$SearchHomeViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
