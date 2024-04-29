import 'dart:io';
import 'package:data/errors/app_error_l10n_codes.dart';

class AppError implements Exception {
  final String? message;
  final String? l10nCode;
  final String? statusCode;

  const AppError({this.message, this.statusCode, this.l10nCode});

  @override
  String toString() {
    return '$runtimeType{message: $message, code: $statusCode, l10nCode: $l10nCode}';
  }

  factory AppError.fromError(Object error) {
    if (error is AppError) {
      return error;
    } else if (error is SocketException) {
      return const NoConnectionError();
    } else {
      return const SomethingWentWrongError();
    }
  }
}

class NoConnectionError extends AppError {
  const NoConnectionError()
      : super(
            l10nCode: AppErrorL10nCodes.noInternetConnection,
            message:
                "No internet connection. Please check your network and try again.");
}

class SomethingWentWrongError extends AppError {
  const SomethingWentWrongError({super.message, super.statusCode})
      : super(l10nCode: AppErrorL10nCodes.somethingWentWrongError);
}
