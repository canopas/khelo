// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_detail_tab_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MatchDetailTabState {
  Object? get error => throw _privateConstructorUsedError;
  MatchModel? get match => throw _privateConstructorUsedError;
  List<InningModel> get allInnings => throw _privateConstructorUsedError;
  String? get highlightTeamId => throw _privateConstructorUsedError;
  DateTime? get showTeamSelectionSheet => throw _privateConstructorUsedError;
  DateTime? get showHighlightOptionSelectionSheet =>
      throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;
  List<OverSummary> get overList => throw _privateConstructorUsedError;
  List<OverSummary> get filteredHighlight => throw _privateConstructorUsedError;
  List<String> get expandedInningsScorecard =>
      throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get loadingBallScoreMore => throw _privateConstructorUsedError;
  HighlightFilterOption get highlightFilterOption =>
      throw _privateConstructorUsedError;

  /// Create a copy of MatchDetailTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchDetailTabStateCopyWith<MatchDetailTabState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchDetailTabStateCopyWith<$Res> {
  factory $MatchDetailTabStateCopyWith(
          MatchDetailTabState value, $Res Function(MatchDetailTabState) then) =
      _$MatchDetailTabStateCopyWithImpl<$Res, MatchDetailTabState>;
  @useResult
  $Res call(
      {Object? error,
      MatchModel? match,
      List<InningModel> allInnings,
      String? highlightTeamId,
      DateTime? showTeamSelectionSheet,
      DateTime? showHighlightOptionSelectionSheet,
      int selectedTab,
      List<OverSummary> overList,
      List<OverSummary> filteredHighlight,
      List<String> expandedInningsScorecard,
      bool loading,
      bool loadingBallScoreMore,
      HighlightFilterOption highlightFilterOption});

  $MatchModelCopyWith<$Res>? get match;
}

/// @nodoc
class _$MatchDetailTabStateCopyWithImpl<$Res, $Val extends MatchDetailTabState>
    implements $MatchDetailTabStateCopyWith<$Res> {
  _$MatchDetailTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchDetailTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? match = freezed,
    Object? allInnings = null,
    Object? highlightTeamId = freezed,
    Object? showTeamSelectionSheet = freezed,
    Object? showHighlightOptionSelectionSheet = freezed,
    Object? selectedTab = null,
    Object? overList = null,
    Object? filteredHighlight = null,
    Object? expandedInningsScorecard = null,
    Object? loading = null,
    Object? loadingBallScoreMore = null,
    Object? highlightFilterOption = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      allInnings: null == allInnings
          ? _value.allInnings
          : allInnings // ignore: cast_nullable_to_non_nullable
              as List<InningModel>,
      highlightTeamId: freezed == highlightTeamId
          ? _value.highlightTeamId
          : highlightTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      showTeamSelectionSheet: freezed == showTeamSelectionSheet
          ? _value.showTeamSelectionSheet
          : showTeamSelectionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showHighlightOptionSelectionSheet: freezed ==
              showHighlightOptionSelectionSheet
          ? _value.showHighlightOptionSelectionSheet
          : showHighlightOptionSelectionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      overList: null == overList
          ? _value.overList
          : overList // ignore: cast_nullable_to_non_nullable
              as List<OverSummary>,
      filteredHighlight: null == filteredHighlight
          ? _value.filteredHighlight
          : filteredHighlight // ignore: cast_nullable_to_non_nullable
              as List<OverSummary>,
      expandedInningsScorecard: null == expandedInningsScorecard
          ? _value.expandedInningsScorecard
          : expandedInningsScorecard // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingBallScoreMore: null == loadingBallScoreMore
          ? _value.loadingBallScoreMore
          : loadingBallScoreMore // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightFilterOption: null == highlightFilterOption
          ? _value.highlightFilterOption
          : highlightFilterOption // ignore: cast_nullable_to_non_nullable
              as HighlightFilterOption,
    ) as $Val);
  }

  /// Create a copy of MatchDetailTabState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchModelCopyWith<$Res>? get match {
    if (_value.match == null) {
      return null;
    }

    return $MatchModelCopyWith<$Res>(_value.match!, (value) {
      return _then(_value.copyWith(match: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchDetailTabStateImplCopyWith<$Res>
    implements $MatchDetailTabStateCopyWith<$Res> {
  factory _$$MatchDetailTabStateImplCopyWith(_$MatchDetailTabStateImpl value,
          $Res Function(_$MatchDetailTabStateImpl) then) =
      __$$MatchDetailTabStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Object? error,
      MatchModel? match,
      List<InningModel> allInnings,
      String? highlightTeamId,
      DateTime? showTeamSelectionSheet,
      DateTime? showHighlightOptionSelectionSheet,
      int selectedTab,
      List<OverSummary> overList,
      List<OverSummary> filteredHighlight,
      List<String> expandedInningsScorecard,
      bool loading,
      bool loadingBallScoreMore,
      HighlightFilterOption highlightFilterOption});

  @override
  $MatchModelCopyWith<$Res>? get match;
}

/// @nodoc
class __$$MatchDetailTabStateImplCopyWithImpl<$Res>
    extends _$MatchDetailTabStateCopyWithImpl<$Res, _$MatchDetailTabStateImpl>
    implements _$$MatchDetailTabStateImplCopyWith<$Res> {
  __$$MatchDetailTabStateImplCopyWithImpl(_$MatchDetailTabStateImpl _value,
      $Res Function(_$MatchDetailTabStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchDetailTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? match = freezed,
    Object? allInnings = null,
    Object? highlightTeamId = freezed,
    Object? showTeamSelectionSheet = freezed,
    Object? showHighlightOptionSelectionSheet = freezed,
    Object? selectedTab = null,
    Object? overList = null,
    Object? filteredHighlight = null,
    Object? expandedInningsScorecard = null,
    Object? loading = null,
    Object? loadingBallScoreMore = null,
    Object? highlightFilterOption = null,
  }) {
    return _then(_$MatchDetailTabStateImpl(
      error: freezed == error ? _value.error : error,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      allInnings: null == allInnings
          ? _value._allInnings
          : allInnings // ignore: cast_nullable_to_non_nullable
              as List<InningModel>,
      highlightTeamId: freezed == highlightTeamId
          ? _value.highlightTeamId
          : highlightTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      showTeamSelectionSheet: freezed == showTeamSelectionSheet
          ? _value.showTeamSelectionSheet
          : showTeamSelectionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showHighlightOptionSelectionSheet: freezed ==
              showHighlightOptionSelectionSheet
          ? _value.showHighlightOptionSelectionSheet
          : showHighlightOptionSelectionSheet // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as int,
      overList: null == overList
          ? _value._overList
          : overList // ignore: cast_nullable_to_non_nullable
              as List<OverSummary>,
      filteredHighlight: null == filteredHighlight
          ? _value._filteredHighlight
          : filteredHighlight // ignore: cast_nullable_to_non_nullable
              as List<OverSummary>,
      expandedInningsScorecard: null == expandedInningsScorecard
          ? _value._expandedInningsScorecard
          : expandedInningsScorecard // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingBallScoreMore: null == loadingBallScoreMore
          ? _value.loadingBallScoreMore
          : loadingBallScoreMore // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightFilterOption: null == highlightFilterOption
          ? _value.highlightFilterOption
          : highlightFilterOption // ignore: cast_nullable_to_non_nullable
              as HighlightFilterOption,
    ));
  }
}

/// @nodoc

class _$MatchDetailTabStateImpl implements _MatchDetailTabState {
  const _$MatchDetailTabStateImpl(
      {this.error,
      this.match,
      final List<InningModel> allInnings = const [],
      this.highlightTeamId,
      this.showTeamSelectionSheet,
      this.showHighlightOptionSelectionSheet,
      this.selectedTab = 1,
      final List<OverSummary> overList = const [],
      final List<OverSummary> filteredHighlight = const [],
      final List<String> expandedInningsScorecard = const [],
      this.loading = false,
      this.loadingBallScoreMore = false,
      this.highlightFilterOption = HighlightFilterOption.all})
      : _allInnings = allInnings,
        _overList = overList,
        _filteredHighlight = filteredHighlight,
        _expandedInningsScorecard = expandedInningsScorecard;

  @override
  final Object? error;
  @override
  final MatchModel? match;
  final List<InningModel> _allInnings;
  @override
  @JsonKey()
  List<InningModel> get allInnings {
    if (_allInnings is EqualUnmodifiableListView) return _allInnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allInnings);
  }

  @override
  final String? highlightTeamId;
  @override
  final DateTime? showTeamSelectionSheet;
  @override
  final DateTime? showHighlightOptionSelectionSheet;
  @override
  @JsonKey()
  final int selectedTab;
  final List<OverSummary> _overList;
  @override
  @JsonKey()
  List<OverSummary> get overList {
    if (_overList is EqualUnmodifiableListView) return _overList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overList);
  }

  final List<OverSummary> _filteredHighlight;
  @override
  @JsonKey()
  List<OverSummary> get filteredHighlight {
    if (_filteredHighlight is EqualUnmodifiableListView)
      return _filteredHighlight;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredHighlight);
  }

  final List<String> _expandedInningsScorecard;
  @override
  @JsonKey()
  List<String> get expandedInningsScorecard {
    if (_expandedInningsScorecard is EqualUnmodifiableListView)
      return _expandedInningsScorecard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expandedInningsScorecard);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool loadingBallScoreMore;
  @override
  @JsonKey()
  final HighlightFilterOption highlightFilterOption;

  @override
  String toString() {
    return 'MatchDetailTabState(error: $error, match: $match, allInnings: $allInnings, highlightTeamId: $highlightTeamId, showTeamSelectionSheet: $showTeamSelectionSheet, showHighlightOptionSelectionSheet: $showHighlightOptionSelectionSheet, selectedTab: $selectedTab, overList: $overList, filteredHighlight: $filteredHighlight, expandedInningsScorecard: $expandedInningsScorecard, loading: $loading, loadingBallScoreMore: $loadingBallScoreMore, highlightFilterOption: $highlightFilterOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchDetailTabStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.match, match) || other.match == match) &&
            const DeepCollectionEquality()
                .equals(other._allInnings, _allInnings) &&
            (identical(other.highlightTeamId, highlightTeamId) ||
                other.highlightTeamId == highlightTeamId) &&
            (identical(other.showTeamSelectionSheet, showTeamSelectionSheet) ||
                other.showTeamSelectionSheet == showTeamSelectionSheet) &&
            (identical(other.showHighlightOptionSelectionSheet,
                    showHighlightOptionSelectionSheet) ||
                other.showHighlightOptionSelectionSheet ==
                    showHighlightOptionSelectionSheet) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            const DeepCollectionEquality().equals(other._overList, _overList) &&
            const DeepCollectionEquality()
                .equals(other._filteredHighlight, _filteredHighlight) &&
            const DeepCollectionEquality().equals(
                other._expandedInningsScorecard, _expandedInningsScorecard) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.loadingBallScoreMore, loadingBallScoreMore) ||
                other.loadingBallScoreMore == loadingBallScoreMore) &&
            (identical(other.highlightFilterOption, highlightFilterOption) ||
                other.highlightFilterOption == highlightFilterOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      match,
      const DeepCollectionEquality().hash(_allInnings),
      highlightTeamId,
      showTeamSelectionSheet,
      showHighlightOptionSelectionSheet,
      selectedTab,
      const DeepCollectionEquality().hash(_overList),
      const DeepCollectionEquality().hash(_filteredHighlight),
      const DeepCollectionEquality().hash(_expandedInningsScorecard),
      loading,
      loadingBallScoreMore,
      highlightFilterOption);

  /// Create a copy of MatchDetailTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchDetailTabStateImplCopyWith<_$MatchDetailTabStateImpl> get copyWith =>
      __$$MatchDetailTabStateImplCopyWithImpl<_$MatchDetailTabStateImpl>(
          this, _$identity);
}

abstract class _MatchDetailTabState implements MatchDetailTabState {
  const factory _MatchDetailTabState(
          {final Object? error,
          final MatchModel? match,
          final List<InningModel> allInnings,
          final String? highlightTeamId,
          final DateTime? showTeamSelectionSheet,
          final DateTime? showHighlightOptionSelectionSheet,
          final int selectedTab,
          final List<OverSummary> overList,
          final List<OverSummary> filteredHighlight,
          final List<String> expandedInningsScorecard,
          final bool loading,
          final bool loadingBallScoreMore,
          final HighlightFilterOption highlightFilterOption}) =
      _$MatchDetailTabStateImpl;

  @override
  Object? get error;
  @override
  MatchModel? get match;
  @override
  List<InningModel> get allInnings;
  @override
  String? get highlightTeamId;
  @override
  DateTime? get showTeamSelectionSheet;
  @override
  DateTime? get showHighlightOptionSelectionSheet;
  @override
  int get selectedTab;
  @override
  List<OverSummary> get overList;
  @override
  List<OverSummary> get filteredHighlight;
  @override
  List<String> get expandedInningsScorecard;
  @override
  bool get loading;
  @override
  bool get loadingBallScoreMore;
  @override
  HighlightFilterOption get highlightFilterOption;

  /// Create a copy of MatchDetailTabState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchDetailTabStateImplCopyWith<_$MatchDetailTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
