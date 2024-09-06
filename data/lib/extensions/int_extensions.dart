extension OverExtensionOnInt on int {
  double toOvers() {
    final int overs = this ~/ 6;
    final int additionalBalls = this % 6;
    return double.parse("$overs.$additionalBalls");
  }
}
