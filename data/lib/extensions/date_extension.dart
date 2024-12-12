extension DateExtension on DateTime {
  DateTime get getStartOfMonth {
    return DateTime(year, month, 1);
  }

  DateTime get getEndOfMonth {
    final nextMonth = month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1));
  }

  DateTime get getStartOfWeek {
    final startOfWeek = subtract(Duration(days: weekday - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  DateTime get getEndOfWeek {
    final endOfWeek = add(Duration(days: 7 - weekday));
    return DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);
  }
}