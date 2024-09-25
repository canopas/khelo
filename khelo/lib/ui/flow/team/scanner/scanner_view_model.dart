import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scanner_view_model.freezed.dart';

final scannerStateNotifierProvider =
    StateNotifierProvider.autoDispose<ScannerStateNotifier, ScannerState>(
        (ref) {
  return ScannerStateNotifier();
});

class ScannerStateNotifier extends StateNotifier<ScannerState> {
  StreamSubscription? _subscription;

  ScannerStateNotifier()
      : super(
          ScannerState(controller: MobileScannerController()),
        ) {
    _checkCameraPermission();
    _observeQrCode();
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

  void toggleTorch() async {
    state = state.copyWith(error: null);
    try {
      await state.controller.toggleTorch();
      state = state.copyWith(flashOn: state.controller.torchEnabled);
    } catch (e) {
      state = state.copyWith(error: e);
      debugPrint("ScannerViewNotifier: Error while toggling flash $e");
    }
  }

  Future<void> analyzeFromFile(String filePath) async {
    final barcodes = await state.controller.analyzeImage(filePath);
    state = state.copyWith(
      userId: barcodes?.barcodes.firstOrNull?.displayValue ?? "",
    );
  }

  void _observeQrCode() {
    _subscription?.cancel();
    state = state.copyWith(error: null);
    _subscription = state.controller.barcodes.listen(
      (event) {
        removeListeners();
        state = state.copyWith(
          userId: event.barcodes.firstOrNull?.displayValue ?? "",
        );
      },
      onError: (e) {
        state = state.copyWith(error: e);
        debugPrint("ScannerViewNotifier: Error while listening QR stream $e");
      },
    );
  }

  void removeListeners() {
    _subscription?.cancel();
    state.controller.dispose();
  }

  @override
  void dispose() async {
    removeListeners();
    super.dispose();
  }
}

@freezed
class ScannerState with _$ScannerState {
  const factory ScannerState({
    Object? error,
    @Default('') String userId,
    @Default(false) bool flashOn,
    @Default(false) bool hasPermission,
    required MobileScannerController controller,
  }) = _ScannerState;
}
