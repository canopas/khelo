import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:data/extensions/list_extensions.dart';

part 'add_match_officials_view_model.freezed.dart';

final addMatchOfficialsStateProvider = StateNotifierProvider.autoDispose<
    AddMatchOfficialsViewNotifier, AddMatchOfficialsState>((ref) {
  return AddMatchOfficialsViewNotifier();
});

class AddMatchOfficialsViewNotifier
    extends StateNotifier<AddMatchOfficialsState> {
  AddMatchOfficialsViewNotifier() : super(const AddMatchOfficialsState());

  void setData(List<Officials> officials) {
    state = state.copyWith(officials: officials);
  }

  void addOfficial(MatchOfficials type, UserModel user) {
    if (isAlreadyAdded(type, user.id)) {
      return;
    }
    state = state.copyWith(
      officials: [...state.officials, Officials(type, user)],
    );
  }

  void removeOfficial(MatchOfficials type, UserModel user) {
    final updatedList = state.officials.toList();
    updatedList.removeWhere(
        (element) => element.user.id == user.id && element.type == type);
    state = state.copyWith(officials: updatedList);
  }

  void updateOfficial(
      MatchOfficials type, String existingUserId, UserModel user) {
    if (isAlreadyAdded(type, user.id)) {
      return;
    }
    state = state.copyWith(
        officials: state.officials.updateWhere(
      where: (element) =>
          element.user.id == existingUserId && element.type == type,
      updated: (oldElement) => Officials(type, user),
    ));
  }

  bool isAlreadyAdded(MatchOfficials type, String id) {
    final officialIds = state.officials
        .where((element) => element.type == type)
        .map((e) => e.user.id);

    return officialIds.contains(id);
  }
}

@freezed
class AddMatchOfficialsState with _$AddMatchOfficialsState {
  const factory AddMatchOfficialsState({
    Object? error,
    @Default([]) List<Officials> officials,
  }) = _AddMatchOfficialsState;
}

class Officials {
  MatchOfficials type;
  UserModel user;

  Officials(this.type, this.user);
}

enum MatchOfficials {
  umpires(4),
  scorers(2),
  referee(1),
  commentator(2);
  // liveStreamer(1);

  final int count;

  const MatchOfficials(this.count);

  String getTitle(BuildContext context) {
    switch (this) {
      case MatchOfficials.umpires:
        return context.l10n.add_match_officials_umpires_title;
      case MatchOfficials.scorers:
        return context.l10n.add_match_officials_scorers_title;
      case MatchOfficials.referee:
        return context.l10n.add_match_officials_referee_title;
      case MatchOfficials.commentator:
        return context.l10n.add_match_officials_commentators_title;
      // case MatchOfficials.liveStreamer:
      //   return context.l10n.add_match_officials_live_streamers_title;
    }
  }

  String getImagePath() {
    switch (this) {
      case MatchOfficials.umpires:
        return "assets/images/ic_umpire.png";
      case MatchOfficials.scorers:
        return "assets/images/ic_scorer.png";
      case MatchOfficials.referee:
        return "assets/images/ic_other_official.png";
      case MatchOfficials.commentator:
        return "assets/images/ic_micro_phone.png";
      // case MatchOfficials.liveStreamer:
      //   return "assets/images/ic_streamer.png";
    }
  }
}
