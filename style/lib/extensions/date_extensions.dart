extension DateTimeExtensions on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get startOfMonth => DateTime(year, month, 1);
}
