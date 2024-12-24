import 'package:app_tracking_transparency/app_tracking_transparency.dart';

Future<void> requestTrackingPermission() async {
  // Check the current status
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;

  // If not determined, request permission
  if (status == TrackingStatus.notDetermined) {
    final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
    print('Tracking status: $newStatus');
  }

  // Optionally show the ATT prompt
  final idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
  print('Advertising ID: $idfa');
}
