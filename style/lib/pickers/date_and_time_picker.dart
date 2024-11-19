import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';

import '../theme/colors.dart';

Future<void> selectDate(
  BuildContext context, {
  String? helpText,
  DateTime? startDate,
  DateTime? endDate,
  required DateTime initialDate,
  required Function(DateTime) onDateSelected,
}) async {
  final now = DateTime.now();

  showDatePicker(
    context: context,
    helpText: helpText,
    initialDate: initialDate,
    firstDate: startDate ?? (initialDate.isBefore(now) ? initialDate : now),
    lastDate: endDate ?? DateTime(now.year + 1, now.month, now.day),
    builder: (context, child) {
      return Theme(
        data: context.brightness == Brightness.dark
            ? materialThemeDataDark
            : materialThemeDataLight,
        child: child!,
      );
    },
  ).then((selectedDate) {
    if (selectedDate != null) {
      DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        initialDate.hour,
        initialDate.minute,
      );
      onDateSelected.call(selectedDateTime);
    }
  });
}

Future<void> selectTime(
  BuildContext context, {
  required DateTime initialTime,
  required Function(DateTime) onTimeSelected,
}) async {
  showTimePicker(
    context: context,
    initialTime: TimeOfDay(
      hour: initialTime.hour,
      minute: initialTime.minute,
    ),
    builder: (context, child) {
      return Theme(
        data: context.brightness == Brightness.dark
            ? materialThemeDataDark
            : materialThemeDataLight,
        child: child!,
      );
    },
  ).then((selectedTime) {
    if (selectedTime != null) {
      DateTime selectedDateTime = DateTime(
        initialTime.year,
        initialTime.month,
        initialTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      onTimeSelected.call(selectedDateTime);
    }
  });
}
