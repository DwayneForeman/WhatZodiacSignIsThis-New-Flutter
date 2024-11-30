String getCurrentTimeZone() {
  final now = DateTime.now();
  final timeZoneOffset = now.timeZoneOffset;

  final offsetHours = timeZoneOffset.inHours;
  int offsetMinutes = timeZoneOffset.inMinutes.remainder(60);
  if(offsetMinutes < 0){
    offsetMinutes = offsetMinutes.abs();
  }
  if(offsetMinutes == 30){
    offsetMinutes = 5;
  }
  if(offsetMinutes == 45) {
    offsetMinutes = 75;
  }
  if(offsetMinutes == 0){
    return '$offsetHours';
  }else {
    return '$offsetHours.$offsetMinutes';
  }
}
