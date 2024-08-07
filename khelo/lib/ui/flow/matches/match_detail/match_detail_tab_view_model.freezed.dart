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
  InningModel? get firstInning => throw _privateConstructorUsedError;
  InningModel? get secondInning => throw _privateConstructorUsedError;
  String? get highlightTeamId => throw _privateConstructorUsedError;
  DateTime? get showTeamSelectionSheet => throw _privateConstructorUsedError;
  DateTime? get showHighlightOptionSelectionSheet =>
      throw _privateConstructorUsedError;
  int get selectedTab => throw _privateConstructorUsedError;
  List<OverSummary> get overList => throw _privateConstructorUsedError;
  List<OverSummary> get filteredHighlight => throw _privateConstructorUsedError;
  List<String> get expandedTeamScorecard => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get ballScoreQueryListenerSet => throw _privateConstructorUsedError;
  HighlightFilterOption get highlightFilterOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      InningModel? firstInning,
      InningModel? secondInning,
      String? highlightTeamId,
      DateTime? showTeamSelectionSheet,
      DateTime? showHighlightOptionSelectionSheet,
      int selectedTab,
      List<OverSummary> overList,
      List<OverSummary> filteredHighlight,
      List<String> expandedTeamScorecard,
      bool loading,
      bool ballScoreQueryListenerSet,
      HighlightFilterOption highlightFilterOption});

  $MatchModelCopyWith<$Res>? get match;
  $InningModelCopyWith<$Res>? get firstInning;
  $InningModelCopyWith<$Res>? get secondInning;
}

/// @nodoc
class _$MatchDetailTabStateCopyWithImpl<$Res, $Val extends MatchDetailTabState>
    implements $MatchDetailTabStateCopyWith<$Res> {
  _$MatchDetailTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? match = freezed,
    Object? firstInning = freezed,
    Object? secondInning = freezed,
    Object? highlightTeamId = freezed,
    Object? showTeamSelectionSheet = freezed,
    Object? showHighlightOptionSelectionSheet = freezed,
    Object? selectedTab = null,
    Object? overList = null,
    Object? filteredHighlight = null,
    Object? expandedTeamScorecard = null,
    Object? loading = null,
    Object? ballScoreQueryListenerSet = null,
    Object? highlightFilterOption = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      firstInning: freezed == firstInning
          ? _value.firstInning
          : firstInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      secondInning: freezed == secondInning
          ? _value.secondInning
          : secondInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
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
      expandedTeamScorecard: null == expandedTeamScorecard
          ? _value.expandedTeamScorecard
          : expandedTeamScorecard // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      ballScoreQueryListenerSet: null == ballScoreQueryListenerSet
          ? _value.ballScoreQueryListenerSet
          : ballScoreQueryListenerSet // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightFilterOption: null == highlightFilterOption
          ? _value.highlightFilterOption
          : highlightFilterOption // ignore: cast_nullable_to_non_nullable
              as HighlightFilterOption,
    ) as $Val);
  }

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

  @override
  @pragma('vm:prefer-inline')
  $InningModelCopyWith<$Res>? get firstInning {
    if (_value.firstInning == null) {
      return null;
    }

    return $InningModelCopyWith<$Res>(_value.firstInning!, (value) {
      return _then(_value.copyWith(firstInning: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InningModelCopyWith<$Res>? get secondInning {
    if (_value.secondInning == null) {
      return null;
    }

    return $InningModelCopyWith<$Res>(_value.secondInning!, (value) {
      return _then(_value.copyWith(secondInning: value) as $Val);
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
      InningModel? firstInning,
      InningModel? secondInning,
      String? highlightTeamId,
      DateTime? showTeamSelectionSheet,
      DateTime? showHighlightOptionSelectionSheet,
      int selectedTab,
      List<OverSummary> overList,
      List<OverSummary> filteredHighlight,
      List<String> expandedTeamScorecard,
      bool loading,
      bool ballScoreQueryListenerSet,
      HighlightFilterOption highlightFilterOption});

  @override
  $MatchModelCopyWith<$Res>? get match;
  @override
  $InningModelCopyWith<$Res>? get firstInning;
  @override
  $InningModelCopyWith<$Res>? get secondInning;
}

/// @nodoc
class __$$MatchDetailTabStateImplCopyWithImpl<$Res>
    extends _$MatchDetailTabStateCopyWithImpl<$Res, _$MatchDetailTabStateImpl>
    implements _$$MatchDetailTabStateImplCopyWith<$Res> {
  __$$MatchDetailTabStateImplCopyWithImpl(_$MatchDetailTabStateImpl _value,
      $Res Function(_$MatchDetailTabStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? match = freezed,
    Object? firstInning = freezed,
    Object? secondInning = freezed,
    Object? highlightTeamId = freezed,
    Object? showTeamSelectionSheet = freezed,
    Object? showHighlightOptionSelectionSheet = freezed,
    Object? selectedTab = null,
    Object? overList = null,
    Object? filteredHighlight = null,
    Object? expandedTeamScorecard = null,
    Object? loading = null,
    Object? ballScoreQueryListenerSet = null,
    Object? highlightFilterOption = null,
  }) {
    return _then(_$MatchDetailTabStateImpl(
      error: freezed == error ? _value.error : error,
      match: freezed == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
      firstInning: freezed == firstInning
          ? _value.firstInning
          : firstInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
      secondInning: freezed == secondInning
          ? _value.secondInning
          : secondInning // ignore: cast_nullable_to_non_nullable
              as InningModel?,
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
      expandedTeamScorecard: null == expandedTeamScorecard
          ? _value._expandedTeamScorecard
          : expandedTeamScorecard // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      ballScoreQueryListenerSet: null == ballScoreQueryListenerSet
          ? _value.ballScoreQueryListenerSet
          : ballScoreQueryListenerSet // ignore: cast_nullable_to_non_nullable
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
      this.firstInning,
      this.secondInning,
      this.highlightTeamId,
      this.showTeamSelectionSheet,
      this.showHighlightOptionSelectionSheet,
      this.selectedTab = 1,
      final List<OverSummary> overList = const [],
      final List<OverSummary> filteredHighlight = const [],
      final List<String> expandedTeamScorecard = const [],
      this.loading = false,
      this.ballScoreQueryListenerSet = false,
      this.highlightFilterOption = HighlightFilterOption.all})
      : _overList = overList,
        _filteredHighlight = filteredHighlight,
        _expandedTeamScorecard = expandedTeamScorecard;

  @override
  final Object? error;
  @override
  final MatchModel? match;
  @override
  final InningModel? firstInning;
  @override
  final InningModel? secondInning;
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

  final List<String> _expandedTeamScorecard;
  @override
  @JsonKey()
  List<String> get expandedTeamScorecard {
    if (_expandedTeamScorecard is EqualUnmodifiableListView)
      return _expandedTeamScorecard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expandedTeamScorecard);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool ballScoreQueryListenerSet;
  @override
  @JsonKey()
  final HighlightFilterOption highlightFilterOption;

  @override
  String toString() {
    return 'MatchDetailTabState(error: $error, match: $match, firstInning: $firstInning, secondInning: $secondInning, highlightTeamId: $highlightTeamId, showTeamSelectionSheet: $showTeamSelectionSheet, showHighlightOptionSelectionSheet: $showHighlightOptionSelectionSheet, selectedTab: $selectedTab, overList: $overList, filteredHighlight: $filteredHighlight, expandedTeamScorecard: $expandedTeamScorecard, loading: $loading, ballScoreQueryListenerSet: $ballScoreQueryListenerSet, highlightFilterOption: $highlightFilterOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchDetailTabStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.match, match) || other.match == match) &&
            (identical(other.firstInning, firstInning) ||
                other.firstInning == firstInning) &&
            (identical(other.secondInning, secondInning) ||
                other.secondInning == secondInning) &&
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
            const DeepCollectionEquality()
                .equals(other._expandedTeamScorecard, _expandedTeamScorecard) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.ballScoreQueryListenerSet,
                    ballScoreQueryListenerSet) ||
                other.ballScoreQueryListenerSet == ballScoreQueryListenerSet) &&
            (identical(other.highlightFilterOption, highlightFilterOption) ||
                other.highlightFilterOption == highlightFilterOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      match,
      firstInning,
      secondInning,
      highlightTeamId,
      showTeamSelectionSheet,
      showHighlightOptionSelectionSheet,
      selectedTab,
      const DeepCollectionEquality().hash(_overList),
      const DeepCollectionEquality().hash(_filteredHighlight),
      const DeepCollectionEquality().hash(_expandedTeamScorecard),
      loading,
      ballScoreQueryListenerSet,
      highlightFilterOption);

  @JsonKey(ignore: true)
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
          final InningModel? firstInning,
          final InningModel? secondInning,
          final String? highlightTeamId,
          final DateTime? showTeamSelectionSheet,
          final DateTime? showHighlightOptionSelectionSheet,
          final int selectedTab,
          final List<OverSummary> overList,
          final List<OverSummary> filteredHighlight,
          final List<String> expandedTeamScorecard,
          final bool loading,
          final bool ballScoreQueryListenerSet,
          final HighlightFilterOption highlightFilterOption}) =
      _$MatchDetailTabStateImpl;

  @override
  Object? get error;
  @override
  MatchModel? get match;
  @override
  InningModel? get firstInning;
  @override
  InningModel? get secondInning;
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
  List<String> get expandedTeamScorecard;
  @override
  bool get loading;
  @override
  bool get ballScoreQueryListenerSet;
  @override
  HighlightFilterOption get highlightFilterOption;
  @override
  @JsonKey(ignore: true)
  _$$MatchDetailTabStateImplCopyWith<_$MatchDetailTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
