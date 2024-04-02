import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

const _missing = '-';

extension StringExtension on String? {
  String format(BuildContext context, StringFormats formatType) {
    if (this == null) return _missing;

    switch (formatType) {
      case StringFormats.obscurePhoneNumber:
        if (this!.length < 13) {
          return _missing;
        }
        return context.l10n.common_obscure_phone_number_text(
            this!.substring(0, 3),
            this!.substring(this!.length - 2)); // TODO: change to 1 if needed
    }
  }
}

enum StringFormats {
  obscurePhoneNumber('+## ***** ***##');

  const StringFormats(this.value);

  final String value;
}
