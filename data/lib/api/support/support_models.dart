import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_models.freezed.dart';

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
