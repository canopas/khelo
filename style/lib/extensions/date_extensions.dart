import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  bool isSameDay(DateTime? date) => DateUtils.isSameDay(this, date);

  DateTime get startOfMonth => DateTime(year, month, 1);
}
