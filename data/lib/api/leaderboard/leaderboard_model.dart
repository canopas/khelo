import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';
import '../../utils/constant/firestore_constant.dart';
import '../user/user_models.dart';

part 'leaderboard_model.freezed.dart';

part 'leaderboard_model.g.dart';

@freezed
class LeaderboardModel with _$LeaderboardModel {
  const factory LeaderboardModel({
    required LeaderboardField type,
    @Default([]) List<LeaderboardPlayer> players,
  }) = _LeaderboardModel;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardModelFromJson(json);

  factory LeaderboardModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      LeaderboardModel.fromJson(snapshot.data()!);
}

@freezed
class LeaderboardPlayer with _$LeaderboardPlayer {
  const factory LeaderboardPlayer({
    @TimeStampJsonConverter() required DateTime date,
    required String id,
    @Default(0) int runs,
    @Default(0) int wickets,
    @Default(0) int catches,
    @JsonKey(includeToJson: false, includeFromJson: false) UserModel? user,
  }) = _LeaderboardPlayer;

  factory LeaderboardPlayer.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardPlayerFromJson(json);

  factory LeaderboardPlayer.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      LeaderboardPlayer.fromJson(snapshot.data()!);
}

enum LeaderboardType {
  weekly,
  monthly,
  allTime;

  String getDatabaseConst() {
    switch (this) {
      case LeaderboardType.weekly:
        return FireStoreConst.weeklyDocument;
      case LeaderboardType.monthly:
        return FireStoreConst.monthlyDocument;
      case LeaderboardType.allTime:
        return FireStoreConst.allTimeDocument;
    }
  }
}

enum LeaderboardField {
  batting,
  bowling,
  fielding;

  String getDatabaseConst() {
    switch (this) {
      case LeaderboardField.batting:
        return FireStoreConst.runs;
      case LeaderboardField.bowling:
        return FireStoreConst.wickets;
      case LeaderboardField.fielding:
        return FireStoreConst.catches;
    }
  }

  int getMinScoreToGetFeatured() {
    switch (this) {
      case LeaderboardField.batting:
        return 50;
      case LeaderboardField.bowling:
        return 10;
      case LeaderboardField.fielding:
        return 5;
    }
  }
}
