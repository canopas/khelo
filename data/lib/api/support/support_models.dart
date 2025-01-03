// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';

part 'support_models.freezed.dart';

part 'support_models.g.dart';

@freezed
class AddSupportCaseRequest with _$AddSupportCaseRequest {
  const factory AddSupportCaseRequest({
    required String id,
    required String title,
    String? description,
    @Default([]) List<String> attachment_urls,
    required String user_id,
    DateTime? created_at,
    @TimeStampJsonConverter() DateTime? created_time,
  }) = _AddSupportCaseRequest;

  factory AddSupportCaseRequest.fromJson(Map<String, dynamic> json) =>
      _$AddSupportCaseRequestFromJson(json);

  factory AddSupportCaseRequest.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      AddSupportCaseRequest.fromJson(snapshot.data()!);
}

enum AttachmentUploadStatus {
  uploading,
  uploaded;

  bool get isUploading => this == uploading;

  bool get isUploaded => this == uploaded;
}

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    required String path,
    String? url,
    @Default('') String name,
    @Default(AttachmentUploadStatus.uploading)
    AttachmentUploadStatus uploadStatus,
  }) = _Attachment;
}
