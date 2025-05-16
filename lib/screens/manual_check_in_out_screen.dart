
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ManualCheckInOutScreen extends StatefulWidget {
  const ManualCheckInOutScreen({super.key});

  @override
  State<ManualCheckInOutScreen> createState() => _ManualCheckInOutScreenState();
}

class _ManualCheckInOutScreenState extends State<ManualCheckInOutScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String? lastAction;
  String? lastTimeFormatted;

  Future<void> _fetchLastAction() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('uid', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      setState(() {
        lastAction = doc['action'];
        lastTimeFormatted = DateFormat('dd MMM yyyy, hh:mm a')
            .format(doc['timestamp'].toDate());
      });
    }
  }

  Future<void> _recordAttendance(String action) async {
    final user = _auth.currentUser;

    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User not logged in')));
      }
      return;
    }

    setState(() => isLoading = true);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .where('uid', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.first : null;
      final lastActionFromDb = lastDoc != null ? lastDoc['action'] : null;

      if (lastActionFromDb == action) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You have already $action-ed')),
          );
        }
        return;
      }

      await FirebaseFirestore.instance.collection('attendance').add({
        'uid': user.uid,
        'action': action,
        'timestamp': Timestamp.now(),
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Successfully $action-ed')));
      }

      await _fetchLastAction(); // Refresh latest timestamp
    } catch (e) {
      debugPrint('❌ Error while checking in/out: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to $action')));
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLastAction();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Initializing user...')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Manual Check-In / Check-Out")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text("Check In"),
                        onPressed: () => _recordAttendance('check-in'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text("Check Out"),
                        onPressed: () => _recordAttendance('check-out'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                if (lastAction != null && lastTimeFormatted != null)
                  Text(
                    'Last action: $lastAction on $lastTimeFormatted',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Logged in as: ${user.email}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
    );
  }
}
