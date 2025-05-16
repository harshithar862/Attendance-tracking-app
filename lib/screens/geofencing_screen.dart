
import 'package:fluttertoast/fluttertoast.dart;

import 'package:geofence_service/geofence_service.dart';import 'package:geofence_service/geofence_service.dart;
import 'package:flutter/foundation.dart;
import 'package:cloud_firestore/cloud_firestore.dart;
import 'package:firebase_auth/firebase_auth.dart';

class GeofencingServiceManager {
  final _geofenceService = GeofenceService.instance;

  final double officeLat = 12.9380;
  final double officeLng = 77.6096;
  final double radius = 200;

  Function()? onEnter;
  Function()? onExit;

  bool _geofenceStarted = false;
  
  GeofencingServiceManager{this.onEnter, this.onExit});

  void startGeofenceMonitoring() {
    if (_geofenceStarted) return;

    final geofence = Geofence(
      id: 'office',
      latitude: officeLat,
      longitude: officeLng,
      radius: [GeofenceRadius(id: 'radius_200m', length: radius)],
    _geofenceService
    .start([geofence])
    .then((_) {
      _geofenceStarted = true;
    })
    .catchError(e) {
      debugPrint(' Failed to start geofence service: $e');
    });
    
  }
  Future<void> _onGeofencestatusChangedWrapper(
    Geofence geofence,
    GeofenceRadius radius,
    GeofenceStatus status,
    Location location,
} async {
  debugPrint(
    ' Geofence Status: ${geofence.id} -> $status @ (${location.latitude}, $(location.longitude)}',
  );

  await _handleStatusChange (geofence, radius, status);
}

Future<void> _handleStatusChange(
  Geofence geofence,
  GeofenceRadius radius,
  GeofenceStatus status,
} async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  string? action;
  if (status == GeofenceStatus.Enter) {
    action = 'check-in';
    if (onEnter != null) onEnter!();
    
  } else if (status == GeofenceStatus.EXIT) {
    action = 'checkout';
    if (onEXIT != null) onExit!();
  }
  if (action == null) return;
  final now = Timestamp.now();

  try {
    final snapshot = 
        await FirebaseFirestore.instance 
            .collection('attendance')
            .where('uid', isEqualTo: user.uid)
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

    final lastAction = snapshot.docs.isNotEmpty ? snapshot.docs.first['action'] : null;

    if (lastAction != action) {
      await FirebaseFirestore.instance.collection('attendance').add({
        'uid': user.uid,
        'action' : action,
        'timestamp': now,
        'method' : auto,
      });
      debugPrint('Auto $action recorded at $now');
      Fluttertoast.showToast(msg: 'Auto $action recorded');
    }
  }
}