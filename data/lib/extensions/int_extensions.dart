extension OverExtensionOnInt on int {
  double toOvers() {
    int overs = this ~/ 6;
    int additionalBalls = this % 6;
    return double.parse("$overs.$additionalBalls");
  }
}
