import 'package:data/extensions/int_extensions.dart';

extension OverExtensionOnDouble on double {
  double add(int ballsToAdd) {
    int totalBalls = toBalls() + ballsToAdd;
    return totalBalls.toOvers();
  }

  double remove(int ballsToRemove) {
    int totalBalls = toBalls() - ballsToRemove;
    if (totalBalls < 0) totalBalls = 0;
    return totalBalls.toOvers();
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

  int toBalls() {
    return (getOverNumberFromOver() * 6) + getBallNumberFromOver();
  }
}
