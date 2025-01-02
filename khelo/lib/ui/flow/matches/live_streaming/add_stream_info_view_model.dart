import 'package:data/api/live_stream/live_stream_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/live_stream/live_stream_endpoint.dart';
import 'package:data/service/live_stream/live_stream_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';

part 'add_stream_info_view_model.freezed.dart';

final addStreamInfoStateProvider = StateNotifierProvider.autoDispose<
    AddStreamInfoViewNotifier, AddStreamInfoViewState>((ref) {
  return AddStreamInfoViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(liveStreamServiceProvider),
  );
});

class AddStreamInfoViewNotifier extends StateNotifier<AddStreamInfoViewState> {
  final MatchService _matchService;
  final LiveStreamService _liveStreamService;

  String? matchId;

  AddStreamInfoViewNotifier(this._matchService, this._liveStreamService)
      : super(AddStreamInfoViewState());

  void setData(String matchId) {
    this.matchId = matchId;
    loadData();
  }

  Future<void> loadData() async {
    if (matchId == null) return;
    try {
      state = state.copyWith(loading: true);
      final [match, stream] = await Future.wait([
        _matchService.getMatchById(matchId!),
        _liveStreamService.getLiveStreamByMatchId(matchId!),
      ]);
      state = state.copyWith(
        match: match as MatchModel?,
        stream: stream as LiveStreamModel?,
        loading: false,
        error: null,
      );
      if (stream == null && match != null) {
        createYTStream(
          name: match.teams
              .map((e) => e.team.name_initial ?? e.team.name.initials(limit: 3))
              .join(" vs "),
          description: match.teams.map((e) => e.team.name).join(" vs "),
        );
      } else {
        startLiveStreaming();
      }
    } catch (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint(
          "AddStreamInfoViewNotifier: error while load stream info -> $e");
    }
  }

  Future<void> createYTStream({
    required String name,
    required String description,
  }) async {
    if (matchId == null) return;
    try {
      state = state.copyWith(loading: true);
      final stream =
          await _liveStreamService.createLiveStream(CreateLiveStreamEndPoint(
        name: name,
        description: description,
        matchId: matchId!,
      ));
      state = state.copyWith(
        stream: stream,
        loading: false,
        error: null,
      );
      startLiveStreaming();
    } catch (e) {
      // TODO: this will be action error and action loading so update those variables only
      state = state.copyWith(loading: false, error: e);
      debugPrint(
          "AddStreamInfoViewNotifier: error while load stream info -> $e");
    }
  }

  void startLiveStreaming() {
    // things needed to record and then send to rtmp etcs
  }

  // start YT Flow here
  // Get YT channel and all the stream key and all here
  // after that show button to start live streaming
  // on tap of that start streaming
  // give some control like pause, resume and Stop Streaming
}

@freezed
class AddStreamInfoViewState with _$AddStreamInfoViewState {
  const factory AddStreamInfoViewState({
    Object? error,
    LiveStreamModel? stream,
    MatchModel? match,
    @Default(false) bool loading,
  }) = _AddStreamInfoViewState;
}
