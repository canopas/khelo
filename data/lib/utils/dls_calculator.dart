class DLSCalculator {
  // static final Map<int, double> resources = {
  //   50: 1.0,
  //   49: 0.98,
  //   // Add more entries as per the DLS table
  //   1: 0.02,
  //   0: 0.0,
  // };
  //
  // double getResourcePercentage(int oversLeft, int wicketsLost) {
  //   return resources[oversLeft] ?? 0.0;
  // }
  //
  // int calculateTarget(int originalTarget, int oversAtStart, int wicketsLost, int oversLeft) {
  //   double resourceAtStart = getResourcePercentage(oversAtStart, wicketsLost);
  //   double resourceNow = getResourcePercentage(oversLeft, wicketsLost);
  //
  //   double resourceUsed = resourceAtStart - resourceNow;
  //
  //   int revisedTarget = (originalTarget * resourceUsed).round();
  //
  //   return revisedTarget;
  // }

  // Method to get resource percentage based on overs left and wickets lost
  double getResourcePercentage(int oversLeft, int wicketsLost) {
    double resources = 100.0;

    // Adjust resources based on overs left and wickets lost
    resources -= oversLeft * 2.0; // Example reduction for overs left
    resources -= wicketsLost * 10.0; // Example reduction for wickets lost

    if (resources < 0.0) {
      resources = 0.0;
    }

    return resources;
  }

  int calculateTarget(
      int originalTarget, int totalOvers, int wicketsLost, int oversLeft) {
    double resourceAtStart = getResourcePercentage(
        totalOvers, 0); // Assuming 0 wickets lost at start
    double resourceNow = getResourcePercentage(oversLeft, wicketsLost);

    double resourceUsed = resourceAtStart - resourceNow;
    double proportionUsed = resourceUsed / resourceAtStart;

    int revisedTarget = (originalTarget * proportionUsed).round();

    return revisedTarget;
  }
}
