int getDifferenceToNext8AMInSeconds() {
  final now = DateTime.now();

  // Define today's 8 AM
  final today8AM = DateTime(now.year, now.month, now.day, 8, 0, 0);

  if (now.isBefore(today8AM)) {
    // If the current time is before today's 8 AM
    return today8AM.difference(now).inSeconds;
  } else {
    // If the current time is after today's 8 AM
    final midnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    final next8AM = midnight.add(Duration(hours: 8));
    return next8AM.difference(now).inSeconds;
  }
}
