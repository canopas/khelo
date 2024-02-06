extension StringManipulator on String {
  String get caseAndSpaceInsensitive {
    return trim().replaceAll(RegExp(r'\s+'), "").toLowerCase();
  }
}
