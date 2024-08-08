class DLSCalculator {
  // Simplified resource percentage table (normally this is more complex)
  final Map<int, double> resourceTable = {
    50: 100.0,
    40: 90.0,
    30: 75.0,
    20: 50.0,
    10: 20.0,
    5: 10.0,
    0: 0.0,
  };

  double getResourcePercentage(int oversLeft, int wicketsLost) {
    // This function should actually use a more complex lookup or interpolation
    // For simplicity, we're using a direct lookup here.
    return resourceTable[oversLeft] ?? 0.0;
  }

  double calculateResourceLoss(int oversAtStart, int wicketsAtStart, int oversAtInterruption, int wicketsAtInterruption) {
    double startResource = getResourcePercentage(oversAtStart, wicketsAtStart);
    double interruptionResource = getResourcePercentage(oversAtInterruption, wicketsAtInterruption);
    return startResource - interruptionResource;
  }

  double calculateTargetScore(int team1Score, int initialOvers, int remainingOvers, int wicketsLost) {
    double initialResource = getResourcePercentage(initialOvers, 0);
    double remainingResource = getResourcePercentage(remainingOvers, wicketsLost);

    double resourcePercentage = remainingResource / initialResource;
    return team1Score * resourcePercentage;
  }
}
