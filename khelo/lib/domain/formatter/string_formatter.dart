import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

const _missing = '-';

extension StringExtension on String? {
  String format(BuildContext context, StringFormats formatType) {
    if (this == null) return _missing;

    switch (formatType) {
      case StringFormats.obscurePhoneNumber:
        final splitString = this!.split(" ");
        if (splitString.length == 1) {
          if (this!.length < 13) {
            return _missing;
          }
          return context.l10n.common_obscure_phone_number_text(
              this!.substring(0, 3), this!.substring(this!.length - 2));
        } else {
          final countryCode = splitString.first;
          final lastTwoDigit = splitString
              .elementAt(1)
              .substring(splitString.elementAt(1).length - 2);
          return context.l10n
              .common_obscure_phone_number_text(countryCode, lastTwoDigit);
        }
    }
  }
}

enum StringFormats {
  obscurePhoneNumber('+## ***** ***##');

  const StringFormats(this.value);

  final String value;
}
