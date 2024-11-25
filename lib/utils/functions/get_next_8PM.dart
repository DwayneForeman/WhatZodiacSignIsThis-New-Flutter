import 'package:flutter/material.dart';

int getDifferenceToNext8PMInSeconds() {
  final now = DateTime.now();

  // Define today's 8 PM
  final today8PM = DateTime(now.year, now.month, now.day, 20, 0, 0);

  if (now.isBefore(today8PM)) {
    // If the current time is before today's 8 PM
    debugPrint(today8PM.difference(now).inSeconds.toString());
    return today8PM.difference(now).inSeconds;
  } else {
    // If the current time is after today's 8 PM
    final midnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    final next8PM = midnight.add(const Duration(hours: 20));
    debugPrint(next8PM.difference(now).inSeconds.toString());
    return next8PM.difference(now).inSeconds;
  }
}
