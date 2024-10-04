import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

enum DateFormatType {
  dateAndTime,
  date,
  time,
  dayMonth,
  monthYear,
  shortDate,
  shortDateTime,
  dayMonthYear
}

extension DateFormatter on DateTime {
  String format(BuildContext context, DateFormatType type) {
    if (isUtc) return toLocal().format(context, type);

    switch (type) {
      case DateFormatType.dateAndTime:
        return DateFormat(
                'EEE, dd MMM yyyy ${context.is24HourFormat ? 'HH:mm' : 'hh:mm a'}')
            .format(this);
      case DateFormatType.date:
        return DateFormat('EEE, dd MMM yyyy').format(this);
      case DateFormatType.time:
        return DateFormat(context.is24HourFormat ? 'HH:mm' : 'hh:mm a')
            .format(this);
      case DateFormatType.shortDate:
        return DateFormat('dd MMM yyyy').format(this);
      case DateFormatType.shortDateTime:
        return DateFormat(
                'dd MMM yyyy, ${context.is24HourFormat ? 'HH:mm' : 'hh:mm a'}')
            .format(this);
      case DateFormatType.dayMonthYear:
        return DateFormat.yMMMd().format(this);
      case DateFormatType.monthYear:
        return DateFormat('MMMM yyyy').format(this);
      case DateFormatType.dayMonth:
        return DateFormat('dd MMM').format(this);
    }
  }

  static String formatDateRange(
    BuildContext context, {
    required DateTime startDate,
    required DateTime endDate,
    required DateFormatType formatType,
  }) =>
      "${startDate.format(context, formatType)} - ${endDate.format(context, formatType)}";
}
