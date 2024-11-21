import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'scanner_view_model.freezed.dart';

final scannerStateNotifierProvider =
    StateNotifierProvider.autoDispose<ScannerStateNotifier, ScannerState>(
        (ref) {
  return ScannerStateNotifier();
});

class ScannerStateNotifier extends StateNotifier<ScannerState> {
  List<String> _addedIds = [];
  StreamSubscription? _subscription;

  ScannerStateNotifier() : super(const ScannerState()) {
    _checkCameraPermission();
  }

  void setData(List<String> addedIds) {
    _addedIds = addedIds;
  }

  Future<void> _checkCameraPermission() async {
    final permission = await Permission.camera.status;
    if (permission.isGranted) {
      state = state.copyWith(hasPermission: true);
    }
    if (permission.isDenied) {
      final status = await Permission.camera.request();
      if (status.isGranted) {
        state = state.copyWith(hasPermission: true);
      }
    }
  }

  void initializeController(QRViewController controller) {
    state = state.copyWith(controller: controller);
    _observeQrCode();
  }

  void toggleTorch() async {
    state = state.copyWith(error: null);
    try {
      await state.controller?.toggleFlash();
      final flashState = await state.controller?.getFlashStatus() ?? false;
      state = state.copyWith(flashOn: flashState);
    } catch (e) {
      state = state.copyWith(error: e);
      debugPrint("ScannerViewNotifier: Error while toggling flash $e");
    }
  }

  void _observeQrCode() {
    _subscription?.cancel();
    state = state.copyWith(error: null);
    _subscription = state.controller?.scannedDataStream.listen(
      (event) {
        final code = event.code;
        if (!_addedIds.contains(code)) {
          _removeListeners();
        }
        state = state.copyWith(
          scannedId: code ?? "",
        );
      },
      onError: (e) {
        state = state.copyWith(error: e);
        debugPrint("ScannerViewNotifier: Error while listening QR stream $e");
      },
    );
  }

  void _removeListeners() {
    _subscription?.cancel();
    state.controller?.dispose();
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }
}

@freezed
class ScannerState with _$ScannerState {
  const factory ScannerState({
    Object? error,
    QRViewController? controller,
    @Default('') String scannedId,
    @Default(false) bool flashOn,
    @Default(false) bool hasPermission,
  }) = _ScannerState;
}

enum ScanTarget { player, team }
