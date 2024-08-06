import 'dart:io';

import 'package:flutter/foundation.dart';

double calculateResourcePercentage(
    int oversLeft, int wicketsLost, int totalOvers) {
  // Define base scoring rates
  double powerplayRate;
  double middleRate;
  double deathRate;
  double totalPossibleRuns;

  if (totalOvers == 10) {
    powerplayRate = 12;
    middleRate = 10;
    deathRate = 12;
    totalPossibleRuns = 120;
  } else if (totalOvers == 20) {
    powerplayRate = 9;
    middleRate = 7;
    deathRate = 10;
    totalPossibleRuns = 160;
  } else {
    // 50 overs
    powerplayRate = 9;
    middleRate = 7;
    deathRate = 10;
    totalPossibleRuns = 300;
  }

  // Determine the phase of the game
  double baseRate;
  if (oversLeft > 0.8 * totalOvers) {
    baseRate = powerplayRate;
  } else if (oversLeft > 0.3 * totalOvers) {
    baseRate = middleRate;
  } else {
    baseRate = deathRate;
  }

  // Adjust for wickets lost
  double adjustedRate = baseRate * (1 - 0.1 * wicketsLost);

  // Calculate expected runs in remaining overs
  double expectedRunsRemaining = adjustedRate * oversLeft;

  // Calculate resource percentage
  double resourcePercentage = (expectedRunsRemaining / totalPossibleRuns) * 100;

  return double.parse(resourcePercentage.toStringAsFixed(2));
}

List<Map<String, dynamic>> createResourceTable(int totalOvers) {
  List<Map<String, dynamic>> resourceTable = [];

  for (int oversLeft = 0; oversLeft <= totalOvers; oversLeft++) {
    for (int wicketsLost = 0; wicketsLost <= 10; wicketsLost++) {
      double resourcePercentage =
          calculateResourcePercentage(oversLeft, wicketsLost, totalOvers);
      resourceTable.add({
        'Overs Left': oversLeft,
        'Wickets Lost': wicketsLost,
        'Resource Percentage': resourcePercentage,
      });
    }
  }

  return resourceTable;
}

void saveResourceTableToCsv(
    List<Map<String, dynamic>> resourceTable, String filename) {
  final File file = File(filename);
  String csvData = 'Overs Left,Wickets Lost,Resource Percentage\n';
  for (var row in resourceTable) {
    csvData +=
        '${row['Overs Left']},${row['Wickets Lost']},${row['Resource Percentage']}\n';
  }
  file.writeAsStringSync(csvData);
}

Map<String, double> loadResourceTable(String filename) {
  final File file = File(filename);
  final lines = file.readAsLinesSync();
  final resourceTable = <String, double>{};

  for (var line in lines.skip(1)) {
    final parts = line.split(',');
    final key = '${parts[0]}_${parts[1]}';
    final value = double.parse(parts[2]);
    resourceTable[key] = value;
  }

  return resourceTable;
}

double getResourcePercentage(
    Map<String, double> resourceTable, int oversLeft, int wicketsLost) {
  final key = '${oversLeft}_$wicketsLost';
  return resourceTable[key] ?? 0.0;
}

double calculateResourcesUsed(int totalOvers, int oversLeft, int wicketsLost,
    Map<String, double> resourceTable) {
  final initialResources = getResourcePercentage(resourceTable, totalOvers, 0);
  final remainingResources =
      getResourcePercentage(resourceTable, oversLeft, wicketsLost);
  return initialResources - remainingResources;
}

double calculateAdjustedTarget(
    int initialScore, double initialResources, double remainingResources) {
  return initialScore * (remainingResources / initialResources);
}

void mainTargetGenerated() {
  // Load resource tables
  final resourceTable10 = loadResourceTable('resource_table_10_overs.csv');
  final resourceTable20 = loadResourceTable('resource_table_20_overs.csv');
  final resourceTable50 = loadResourceTable('resource_table_50_overs.csv');

  // Example inputs
  int totalOvers = 20;
  int oversLost = 5;
  int wicketsLost = 3;
  int initialScore = 150;

  // Choose the correct resource table based on the total overs
  Map<String, double> resourceTable;
  if (totalOvers == 10) {
    resourceTable = resourceTable10;
  } else if (totalOvers == 20) {
    resourceTable = resourceTable20;
  } else {
    resourceTable = resourceTable50;
  }

  // Calculate resources
  double initialResources = getResourcePercentage(resourceTable, totalOvers, 0);
  double remainingResources =
      getResourcePercentage(resourceTable, totalOvers - oversLost, wicketsLost);

  // Calculate adjusted target
  double adjustedTarget = calculateAdjustedTarget(
      initialScore, initialResources, remainingResources);

  // Output the adjusted target
  if (kDebugMode) {
    print('Adjusted Target: ${adjustedTarget.round()}');
  }
}
