import 'package:data/api/live_stream/live_stream_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/service/live_stream/live_stream_endpoint.dart';
import 'package:data/service/live_stream/live_stream_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_stream_info_view_model.freezed.dart';

final addStreamInfoStateProvider = StateNotifierProvider.autoDispose<
    AddStreamInfoViewNotifier, AddStreamInfoViewState>((ref) {
  return AddStreamInfoViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(liveStreamServiceProvider),
    ref.read(authServiceProvider),
  );
});

class AddStreamInfoViewNotifier extends StateNotifier<AddStreamInfoViewState> {
  final MatchService _matchService;
  final LiveStreamService _liveStreamService;
  final AuthService _authService;

  String? matchId;

  AddStreamInfoViewNotifier(
      this._matchService, this._liveStreamService, this._authService)
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
    } catch (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("AddStreamInfoViewNotifier: error while load data -> $e");
    }
  }

  Future<void> onOptionSelected(MediumOption option) async {
    state = state.copyWith(mediumOption: option, showSelectResolutionSheet: false);
    switch (option) {
      case MediumOption.kheloYTChannel:
        showResolutionSheet();
        break;
      case MediumOption.userYTChannel:
        fetchYTChannels();
        break;
    }
  }

  Future<void> fetchYTChannels() async {
    try {
      state = state.copyWith(loading: true, actionError: null, showSelectResolutionSheet: false);

      await signInWithGoogleIfNeeded();

      final channels = await _liveStreamService.fetchYTChannelLinkedToUser();
      if (channels.length == 1) {
        state = state.copyWith(
            loading: false,
            channelId: channels.first.id,
            mediumOption: MediumOption.userYTChannel);
        showResolutionSheet();
      } else {
        state = state.copyWith(
          ytChannels: channels,
          loading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(loading: false, actionError: e);
      debugPrint(
          "AddStreamInfoViewNotifier: error while fetching YT channels -> $e");
    }
  }

  void onChannelSelect(String channelId) {
    state = state.copyWith(channelId: channelId, showSelectResolutionSheet: false);
    showResolutionSheet();
  }

  Future<void> signInWithGoogleIfNeeded() async {
    if (!await _authService.isGoogleSignedIn()) {
      await _authService.signInWithGoogle();
    }
  }

  void showResolutionSheet() {
    state = state.copyWith(showSelectResolutionSheet: true);
  }

  void onResolutionSelect(YouTubeResolution resolution) {
    if (state.mediumOption == null) {
      return;
    }

    createYTStream(resolution: resolution);
  }

  Future<void> createYTStream({
    required YouTubeResolution resolution,
  }) async {
    if (matchId == null || state.match == null) return;
    try {
      state = state.copyWith(loading: true, actionError: null);

      final matchStartTime =
          ((state.match?.start_at ?? DateTime.now()).isAfter(DateTime.now())
              ? state.match?.start_at ?? DateTime.now()
              : DateTime.now());

      final stream =
          await _liveStreamService.createLiveStream(CreateLiveStreamEndPoint(
        matchId: matchId!,
        name:
            "Live Cricket Match | ${state.match!.teams.map((e) => e.team.name).join(" vs ")} | ${matchStartTime.toIso8601String()}",
        option: state.mediumOption ?? MediumOption.kheloYTChannel,
        channelId: state.channelId,
        resolution: resolution,
        scheduledStartTime: matchStartTime,
      ));
      state = state.copyWith(
        stream: stream,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(loading: false, actionError: e);
      debugPrint(
          "AddStreamInfoViewNotifier: error while creating yt stream -> $e");
    }
  }

  void unlink() {
    _authService.unlinkGoogle();
  }
}

@freezed
class AddStreamInfoViewState with _$AddStreamInfoViewState {
  const factory AddStreamInfoViewState({
    Object? error,
    Object? actionError,
    LiveStreamModel? stream,
    MatchModel? match,
    MediumOption? mediumOption,
    String? channelId,
    @Default([]) List<YTChannel> ytChannels,
    @Default(false) bool showSelectResolutionSheet,
    @Default(false) bool loading,
  }) = _AddStreamInfoViewState;
}
