import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

enum DateFormatType { dateAndTime, }

extension DateFormatter on DateTime {
  String format(BuildContext context, DateFormatType type) {
    if (isUtc) return toLocal().format(context, type);

    switch (type) {
      case DateFormatType.dateAndTime:
        return DateFormat(
                'EEE, MMM dd yyyy ${context.is24HourFormat ? 'HH:mm' : 'hh:mm a'}')
            .format(this);
    }
  }
}
