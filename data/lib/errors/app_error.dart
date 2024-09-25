import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_error_l10n_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/constant/firebase_error_constant.dart';

class AppError implements Exception {
  final String? message;
  final String? l10nCode;
  final String? statusCode;
  final StackTrace? stackTrace;

  const AppError({
    this.message,
    this.statusCode,
    this.l10nCode,
    this.stackTrace,
  });

  @override
  String toString() {
    return '$runtimeType{message: $message, code: $statusCode, l10nCode: $l10nCode, stackTrace: $stackTrace}';
  }

  factory AppError.fromError(Object error, [StackTrace? stack]) {
    if (error is AppError) {
      return error;
    } else if (error is SocketException) {
      return const NoConnectionError();
    } else if (error is FirebaseException) {
      return _handleFirebaseError(error);
    } else if (error is TypeError) {
      return SomethingWentWrongError(
        message: error.toString(),
        stackTrace: stack,
      );
    } else if (error is LargeAttachmentUploadError) {
      return const LargeAttachmentUploadError();
    } else {
      return SomethingWentWrongError(
        message: error.toString(),
        stackTrace: stack,
      );
    }
  }

  static AppError _handleFirebaseError(FirebaseException error) {
    switch (error.code) {
      case errorInvalidVerificationCode:
        return AppError(
          statusCode: error.code,
          message: error.message,
          l10nCode: AppErrorL10nCodes.invalidVerificationCode,
          stackTrace: error.stackTrace,
        );
      case errorTooManyRequest:
        return AppError(
          statusCode: error.code,
          message: error.message,
          l10nCode: AppErrorL10nCodes.tooManyRequests,
          stackTrace: error.stackTrace,
        );
      case errorInvalidPhoneNumber:
        return AppError(
          statusCode: error.code,
          message: error.message,
          l10nCode: AppErrorL10nCodes.invalidPhoneNumber,
          stackTrace: error.stackTrace,
        );
      case errorNetworkRequestFailed:
        return const NoConnectionError();
      case errorRequiresRecentLogin:
        return const RequiresRecentLoginError();
      default:
        return SomethingWentWrongError(
          statusCode: error.code,
          message: error.message,
          stackTrace: error.stackTrace,
        );
    }
  }
}

class NoConnectionError extends AppError {
  const NoConnectionError()
      : super(
          l10nCode: AppErrorL10nCodes.noInternetConnection,
          message:
              "No internet connection. Please check your network and try again.",
        );
}

class SomethingWentWrongError extends AppError {
  const SomethingWentWrongError({
    super.message,
    super.statusCode,
    super.stackTrace,
  }) : super(l10nCode: AppErrorL10nCodes.somethingWentWrongError);
}

class LargeAttachmentUploadError extends AppError {
  const LargeAttachmentUploadError()
      : super(
          l10nCode: AppErrorL10nCodes.largeAttachmentUpload,
          message:
              "Oops! Your file exceeds the maximum allowed size of 25 MB. Please choose a smaller file and try again.",
        );
}

class RequiresRecentLoginError extends AppError {
  const RequiresRecentLoginError()
      : super(l10nCode: AppErrorL10nCodes.requiresRecentLogin);
}
