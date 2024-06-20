import 'dart:io';

import 'package:collection/collection.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:data/service/file_upload/file_upload_service.dart';
import 'package:data/service/support/support_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:data/api/support/support_models.dart';

part 'contact_support_view_model.freezed.dart';

final contactSupportStateNotifierProvider = StateNotifierProvider.autoDispose<
    ContactSupportViewStateNotifier, ContactSupportViewState>((ref) {
  return ContactSupportViewStateNotifier(
      ImagePicker(),
      ref.read(fileUploadServiceProvider),
      ref.read(supportServiceProvider),
      ref.read(currentUserPod)?.id);
});

class ContactSupportViewStateNotifier
    extends StateNotifier<ContactSupportViewState> {
  final ImagePicker picker;
  final FileUploadService fileUploadService;
  final SupportService supportService;
  final String? _currentUserId;

  ContactSupportViewStateNotifier(
    this.picker,
    this.fileUploadService,
    this.supportService,
    this._currentUserId,
  ) : super(ContactSupportViewState(
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
        ));

  void onValueChange() {
    state = state.copyWith(
      actionError: null,
      enableSubmit: state.titleController.text.trim().isNotEmpty &&
          state.attachments
                  .where((element) => element.uploadStatus.isUploading)
                  .firstOrNull ==
              null,
    );
  }

  void _uploadAttachments({required String path, required String name}) async {
    try {
      state = state.copyWith(attachments: [
        ...state.attachments,
        Attachment(
            path: path,
            name: name,
            uploadStatus: AttachmentUploadStatus.uploading),
      ]);
      onValueChange();
      final bool isLarge = await File(path).length() > 25 * 1024 * 1024;

      if (isLarge) {
        final attachments = state.attachments.toList()
          ..removeWhere((element) => element.path == path);

        state = state.copyWith(
            attachments: attachments,
            actionError: const LargeAttachmentUploadError());
      } else {
        final url = await fileUploadService.uploadProfileImage(
            path, ImageUploadType.support);
        state = state.copyWith(
          attachments: state.attachments.updateWhere(
            where: (attachment) => attachment.path == path,
            updated: (oldElement) => oldElement.copyWith(
              url: url,
              uploadStatus: AttachmentUploadStatus.uploaded,
            ),
          ),
        );
      }

      onValueChange();
    } catch (error, _) {
      state = state.copyWith(actionError: error);
      debugPrint(
          "ContactSupportViewStateNotifier: Error while uploading $path error $error");
    }
  }

  void pickAttachments() async {
    try {
      final List<XFile> medias = await picker.pickMultipleMedia(
        imageQuality: 70,
      );
      for (XFile media in medias) {
        _uploadAttachments(path: media.path, name: media.name);
      }
    } catch (error, _) {
      debugPrint(
        "ContactSupportViewStateNotifier: Error while pick image! $error",
      );
    }
  }

  void removeAttachment(int index) async {
    if (state.attachments.elementAt(index).url != null) {
      await fileUploadService
          .deleteUploadedImage(state.attachments.elementAt(index).url ?? '');
    }
    state = state.copyWith(
        attachments: state.attachments.toList()..removeAt(index));
    onValueChange();
  }

  void discardAttachments() async {
    for (final attachment in state.attachments) {
      if (attachment.url != null) {
        await fileUploadService.deleteUploadedImage(attachment.url!);
      }
    }
    state = state.copyWith(attachments: []);
  }

  void submitSupportCase() async {
    try {
      state = state.copyWith(submitting: true, actionError: null);

      final supportCase = AddSupportCaseRequest(
          title: state.titleController.text.trim(),
          description: state.descriptionController.text.trim(),
          attachmentUrls:
              state.attachments.map((e) => e.url).whereNotNull().toList(),
          userId: _currentUserId ?? '',
          createdAt: DateTime.now());

      await supportService.addSupportCase(supportCase).whenComplete(
            () => state = state.copyWith(pop: true, submitting: false),
          );
    } catch (error) {
      state = state.copyWith(actionError: error, pop: false);
      debugPrint(
          "ContactSupportViewStateNotifier: Error while adding support case $error");
    }
  }
}

@freezed
class ContactSupportViewState with _$ContactSupportViewState {
  const factory ContactSupportViewState({
    Object? actionError,
    @Default(false) bool submitting,
    @Default(false) bool enableSubmit,
    @Default(false) bool pop,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    @Default([]) List<Attachment> attachments,
  }) = _ContactSupportViewState;
}
