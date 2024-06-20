import 'package:data/errors/app_error_l10n_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:data/errors/app_error.dart';

extension AppErrorExtensions on Object {
  String l10nMessage(BuildContext context) {
    if (this is AppError) {
      switch ((this as AppError).l10nCode) {
        case AppErrorL10nCodes.noInternetConnection:
          return context.l10n.error_no_internet;
        case AppErrorL10nCodes.somethingWentWrongError:
          return context.l10n.error_something_went_wrong;
        case AppErrorL10nCodes.invalidPhoneNumber:
          return context.l10n.sign_in_invalid_phone_number_text;
        case AppErrorL10nCodes.largeAttachmentUpload:
          return context.l10n.large_attachment_upload_error_text;
        default:
          return (this as AppError).message ??
              context.l10n.error_something_went_wrong;
      }
    } else if (this is String) {
      return this as String;
    } else {
      return context.l10n.error_something_went_wrong;
    }
  }
}
