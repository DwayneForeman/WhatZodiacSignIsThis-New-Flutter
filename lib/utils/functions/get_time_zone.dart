String getCurrentTimeZone() {
  final now = DateTime.now();
  final timeZoneOffset = now.timeZoneOffset;

  final offsetHours = timeZoneOffset.inHours;
  final offsetMinutes = timeZoneOffset.inMinutes.remainder(60);

  // Format the offset to match the switch cases (e.g., UTC+05:30)
  final offsetFormatted =
      "UTC${offsetHours >= 0 ? '+' : ''}$offsetHours:${offsetMinutes.toString().padLeft(2, '0')}";

  // Use offsetFormatted with 'UTC' prefix for matching
  switch (offsetFormatted) {
    case 'UTC-12:00':
      return '-12';
    case 'UTC-11:00':
      return '-11';
    case 'UTC-10:00':
      return '-10';
    case 'UTC-09:30':
      return '-9.3';
    case 'UTC-09:00':
      return '-9';
    case 'UTC-08:00':
      return '-8';
    case 'UTC-07:00':
      return '-7';
    case 'UTC-06:00':
      return '-6';
    case 'UTC-05:00':
      return '-5';
    case 'UTC-04:00':
      return '-4';
    case 'UTC-03:30':
      return '-3.3';
    case 'UTC-03:00':
      return '-3';
    case 'UTC-02:00':
      return '-2';
    case 'UTC-01:00':
      return '-1';
    case 'UTC+00:00':
      return '0';
    case 'UTC+01:00':
      return '1';
    case 'UTC+02:00':
      return '2';
    case 'UTC+03:00':
      return '3';
    case 'UTC+03:30':
      return '3.3';
    case 'UTC+04:00':
      return '4';
    case 'UTC+04:30':
      return '4.3';
    case 'UTC+05:00':
      return '5';
    case 'UTC+05:50':
      return '5.5';
    case 'UTC+05:45':
      return '5.45';
    case 'UTC+06:00':
      return '6';
    case 'UTC+06:30':
      return '6.3';
    case 'UTC+07:00':
      return '7';
    case 'UTC+08:00':
      return '8';
    case 'UTC+09:00':
      return '9';
    case 'UTC+09:30':
      return '9.3';
    case 'UTC+10:00':
      return '10';
    case 'UTC+11:00':
      return '11';
    case 'UTC+12:00':
      return '12';
    case 'UTC+13:00':
      return '13';
    case 'UTC+14:00':
      return '14';
    default:
      return '5';
  }
}
