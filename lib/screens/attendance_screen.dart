import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference attendanceRef = FirebaseFirestore.instance
        .collection('attendance')
        .doc(uid)
        .collection('records');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            attendanceRef.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No attendance records found.'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children:
                snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final action = data['action'];
                  final timestamp = (data['timestamp'] as Timestamp).toDate();
                  final formattedTime = DateFormat(
                    'yyyy-MM-dd – kk:mm',
                  ).format(timestamp);

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(
                        action == 'check-in' ? Icons.login : Icons.logout,
                        color: action == 'check-in' ? Colors.green : Colors.red,
                      ),
                      title: Text(
                        action == 'check-in' ? 'Checked In' : 'Checked Out',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(formattedTime),
                    ),
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}
