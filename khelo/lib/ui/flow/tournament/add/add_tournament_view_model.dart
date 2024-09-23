import 'dart:io';

import 'package:data/errors/app_error.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/domain/extensions/file_extension.dart';

part 'add_tournament_view_model.freezed.dart';

final addTournamentStateProvider = StateNotifierProvider.autoDispose<
    AddTournamentViewNotifier,
    AddTournamentState>((ref) => AddTournamentViewNotifier());

class AddTournamentViewNotifier extends StateNotifier<AddTournamentState> {
  AddTournamentViewNotifier() : super(const AddTournamentState());

  Future<void> onImageChange(String imagePath) async {
    try {
      state = state.copyWith(imageUploading: true, actionError: null);
      if (await File(imagePath).isFileUnderMaxSize()) {
        state =
            state.copyWith(profileFilePath: imagePath, imageUploading: false);
      } else {
        state = state.copyWith(
            imageUploading: false,
            actionError: const LargeAttachmentUploadError());
      }
    } catch (e) {
      state = state.copyWith(imageUploading: false, actionError: e);
      debugPrint("EditProfileViewNotifier: error while image upload -> $e");
    }
  }
}

@freezed
class AddTournamentState with _$AddTournamentState {
  const factory AddTournamentState({
    Object? error,
    Object? actionError,
    @Default(false) bool imageUploading,
    @Default(false) bool loading,
    String? profileFilePath,
    @Default(null) String? profileImageUrl,
  }) = _AddTournamentState;
}
