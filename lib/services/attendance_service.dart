import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> checkIn(String userId, double lat, double long) async {
    await _db.collection('attendance').add({
      'userId': userId,
      'checkIn': DateTime.now(),
      'checkOut': null,
      'lat': lat,
      'long': long,
    });
  }

  Future<void> checkOut(String userId) async {
    var result =
        await _db
            .collection('attendance')
            .where('userId', isEqualTo: userId)
            .where('checkOut', isEqualTo: null)
            .orderBy('checkIn', descending: true)
            .limit(1)
            .get();

    if (result.docs.isNotEmpty) {
      await _db.collection('attendance').doc(result.docs.first.id).update({
        'checkOut': DateTime.now(),
      });
    }
  }
}
