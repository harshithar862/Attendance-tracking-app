
import 'package:geolocator/geolocator.dart';
import 'constants.dart';
import 'package:flutter/foundation.dart';

Future<bool> isUserInsideGeofence() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }
    }

    // ✅ Updated to use LocationSettings instead of desiredAccuracy
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    double distance = Geolocator.distanceBetween(
      officeLatitude,
      officeLongitude,
      position.latitude,
      position.longitude,
    );

    return distance <= geofenceRadius;
  } catch (e) {
    debugPrint('❌ Geofence check failed: $e');
    return false;
  }
}
