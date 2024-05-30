import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

enum DateFormatType { dateAndTime, date, time, shortDate, shortDateTime }

extension DateFormatter on DateTime {
  String format(BuildContext context, DateFormatType type) {
    if (isUtc) return toLocal().format(context, type);

    switch (type) {
      case DateFormatType.dateAndTime:
        return DateFormat(
                'EEE, dd MMM yyyy ${context.is24HourFormat ? 'HH:mm' : 'hh:mm a'}')
            .format(this);
      case DateFormatType.date:
        return DateFormat('EEE, MMM dd yyyy').format(this);
      case DateFormatType.time:
        return DateFormat(context.is24HourFormat ? 'HH:mm' : 'hh:mm a')
            .format(this);
      case DateFormatType.shortDate:
        return DateFormat('dd MMM yyyy').format(this);
      case DateFormatType.shortDateTime:
        return DateFormat(
                'dd MMM yyyy, ${context.is24HourFormat ? 'HH:mm' : 'hh:mm a'}')
            .format(this);
    }
  }
}
