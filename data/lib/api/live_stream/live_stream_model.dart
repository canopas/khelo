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
