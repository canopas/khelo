extension OverExtensionInDouble on double {
  double addOver(int ballsToAdd, {bool roundUp = false}) { // TODO: rename to ball
    int totalBalls = toTotalBalls() + ballsToAdd;
    double result = totalBalls / 6.0;
    // if (roundUp) {
    //   result = result.ceil().toDouble();
    // }
    return result;
  }

  double removeOver(int ballsToRemove, {bool roundUp = false}) { // TODO: rename to ball
    int totalBalls = toTotalBalls() - ballsToRemove;
    if (totalBalls < 0) totalBalls = 0;
    double result = totalBalls / 6.0;
    // if (roundUp) {
    //   result = result.ceil().toDouble();
    // }
    return result;
  }

  int getBallNumberFromOver() {
    String valueString = toString();

    List<String> parts = valueString.split('.');

    if (parts.length > 1) {
      return int.parse(parts[1]);
    } else {
      return 0;
    }
  }

  int getOverNumberFromOver() {
    return toInt();
  }

  int toTotalBalls() {
    return (getOverNumberFromOver() * 6) + getBallNumberFromOver();
  }

  static double fromTotalBalls(int totalBalls) {
    return totalBalls / 6.0;
  }
}
