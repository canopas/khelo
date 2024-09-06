import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_all_view_model.freezed.dart';

final homeViewAllViewProvider = StateNotifierProvider.autoDispose<
        HomeViewAllViewNotifier, HomeViewAllViewState>(
    (ref) => HomeViewAllViewNotifier(ref.read(matchServiceProvider)));

class HomeViewAllViewNotifier extends StateNotifier<HomeViewAllViewState> {
  final MatchService _matchService;

  HomeViewAllViewNotifier(this._matchService)
      : super(const HomeViewAllViewState()) {
    loadMatches();
  }

  List<MatchStatus> _status = [];
  bool _maxLoaded = false;
  String? _lastMatchId;

  void setData(List<MatchStatus> status) {
    _status = status;
  }

  void loadMatches() async {
    if (_status.isEmpty) return;
    if (state.loading || _maxLoaded) return;
    try {
      state = state.copyWith(loading: true);

      final matches = await _matchService.getMatchesByStatus(
        status: _status,
        lastMatchId: _lastMatchId,
        limit: 10,
      );

      _maxLoaded = matches.length < 10;

      if (matches.isNotEmpty) {
        _lastMatchId = matches.last.id;
      }
      state = state.copyWith(
          matches: {...state.matches, ...matches}.toList(), loading: false);
    } catch (error) {
      state = state.copyWith(error: error, loading: false);
      debugPrint("HomeViewAllViewNotifier: error while load matches -> $error");
    }
  }
}

@freezed
class HomeViewAllViewState with _$HomeViewAllViewState {
  const factory HomeViewAllViewState({
    Object? error,
    @Default(false) bool loading,
    @Default([]) List<MatchModel> matches,
  }) = _HomeViewAllViewState;
}
