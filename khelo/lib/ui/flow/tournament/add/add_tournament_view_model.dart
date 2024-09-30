import 'dart:io';

import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/service/file_upload/file_upload_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/utils/constant/firebase_storage_constant.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/domain/extensions/file_extension.dart';

part 'add_tournament_view_model.freezed.dart';

final addTournamentStateProvider = StateNotifierProvider.autoDispose<
    AddTournamentViewNotifier, AddTournamentState>((ref) {
  final notifier = AddTournamentViewNotifier(
    ref.read(tournamentServiceProvider),
    ref.read(fileUploadServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier.setUserId(next?.id);
  });
  return notifier;
});

class AddTournamentViewNotifier extends StateNotifier<AddTournamentState> {
  final FileUploadService _fileUploadService;
  final TournamentService _tournamentService;

  AddTournamentViewNotifier(
    this._tournamentService,
    this._fileUploadService,
    String? userId,
  ) : super(AddTournamentState(
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          nameController: TextEditingController(),
          currentUserId: userId,
        ));

  void setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  Future<void> onImageChange(String imagePath) async {
    try {
      state = state.copyWith(imageUploading: true, actionError: null);
      if (await File(imagePath).isFileUnderMaxSize()) {
        state = state.copyWith(filePath: imagePath, imageUploading: false);
      } else {
        state = state.copyWith(
            imageUploading: false,
            actionError: const LargeAttachmentUploadError());
      }
    } catch (e) {
      state = state.copyWith(imageUploading: false, actionError: e);
      debugPrint("AddTournamentViewNotifier: error while image upload -> $e");
    }
  }

  void onChange() {
    final name = state.nameController.text.trim();

    state = state.copyWith(enableButton: name.isNotEmpty);
  }

  void onSelectType(TournamentType type) {
    state = state.copyWith(selectedType: type);
  }

  void onStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void onEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void addTournament() async {
    try {
      if (state.currentUserId == null) return;

      state = state.copyWith(loading: true);
      final tournamentId = _tournamentService.generateTournamentId;
      final name = state.nameController.text.trim();

      if (state.filePath != null && state.currentUserId != null) {
        final imageUrl = await _fileUploadService.uploadProfileImage(
          filePath: state.filePath ?? '',
          uploadPath: StorageConst.tournamentProfileUploadPath(
              userId: state.currentUserId ?? 'INVALID ID',
              tournamentId: tournamentId),
        );
        state = state.copyWith(imageUrl: imageUrl);
      }

      final tournament = TournamentModel(
        id: tournamentId,
        name: name,
        type: state.selectedType,
        start_date: state.startDate,
        end_date: state.endDate,
        created_at: DateTime.now(),
        created_by: state.currentUserId ?? 'INVALID ID',
        members: [
          TournamentMember(
            id: state.currentUserId ?? 'INVALID ID',
            role: TournamentMemberRole.organizer,
          ),
        ],
        profile_img_url: state.imageUrl,
      );

      await _tournamentService.createTournament(tournament);

      state = state.copyWith(pop: true, loading: false, error: null);
    } catch (error) {
      state = state.copyWith(loading: false, error: error);
      debugPrint(
          "AddTournamentViewNotifier: error while adding tournament -> $error");
    }
  }
}

@freezed
class AddTournamentState with _$AddTournamentState {
  const factory AddTournamentState({
    Object? error,
    Object? actionError,
    String? filePath,
    String? currentUserId,
    required DateTime endDate,
    required DateTime startDate,
    @Default(false) bool pop,
    @Default(false) bool loading,
    @Default(false) bool enableButton,
    @Default(false) bool imageUploading,
    @Default(null) String? imageUrl,
    required TextEditingController nameController,
    @Default(TournamentType.knockOut) TournamentType selectedType,
  }) = _AddTournamentState;
}