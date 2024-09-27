import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';

import '../theme/colors.dart';

Future<void> selectDate(
  BuildContext context, {
  String? helpText,
  required DateTime initialDate,
  required Function(DateTime) onDateSelected,
}) async {
  showDatePicker(
    context: context,
    helpText: helpText,
    initialDate: initialDate,
    firstDate: DateTime(1965),
    lastDate: DateTime(2101),
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
