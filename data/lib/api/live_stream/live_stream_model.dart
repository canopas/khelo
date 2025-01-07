// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';

part 'live_stream_model.freezed.dart';

part 'live_stream_model.g.dart';

@freezed
class LiveStreamModel with _$LiveStreamModel {
  const factory LiveStreamModel({
    required String id,
    required String match_id,
    required String rtmp_url,
    required String stream_id,
    required String broadcast_id,
    required String title,
    @TimeStampJsonConverter() DateTime? start_time,
    @Default(LiveStreamStatus.pending) LiveStreamStatus status,
  }) = _LiveStreamModel;

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamModelFromJson(json);

  factory LiveStreamModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      LiveStreamModel.fromJson(snapshot.data()!);
}

enum LiveStreamStatus {
  pending,
  live,
  paused,
  completed;
}

enum MediumOption {
  kheloYTChannel,
  userYTChannel;

  bool get isLoginRequired => this == MediumOption.userYTChannel;
}

@freezed
class YTChannel with _$YTChannel {
  const factory YTChannel({
    required String id,
    required String title,
    required String description,
    required bool madeForKids,
    required bool selfDeclaredMadeForKids,
    required String? thumbnailUrl,
    required PrivacyStatus privacyStatus,
  }) = _YTChannel;

  factory YTChannel.fromJson(Map<String, dynamic> json) {
    return YTChannel(
      id: json['id'],
      title: json['snippet']['title'],
      description: json['snippet']['description'],
      madeForKids: json['status']['madeForKids'] ?? false,
      selfDeclaredMadeForKids: json['status']['selfDeclaredMadeForKids'] ?? false,
      thumbnailUrl: json['snippet']['thumbnails']['default']['url'],
      privacyStatus: json['status']['privacyStatus'] == 'public'
          ? PrivacyStatus.public
          : json['status']['privacyStatus'] == 'private'
          ? PrivacyStatus.private
          : PrivacyStatus.unlisted,
    );
  }
}

enum PrivacyStatus {
  public,
  private,
  unlisted,
}
