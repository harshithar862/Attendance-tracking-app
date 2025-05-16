import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/geofence_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CheckInOutScreen extends StatefulWidget {
  const CheckInOutScreen({super.key});

  @override
  State<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  bool isInside = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    bool inside = await isUserInsideGeofence();
    if (!mounted) return;
    setState(() {
      isInside = inside;
      isLoading = false;
    });
  }

  Future<void> _checkIn() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('attendance').add({
      'uid': user.uid,
      'action': 'check-in',
      'timestamp': Timestamp.now(),
    });

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Checked in successfully')));
  }

  Future<void> _checkOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('attendance').add({
      'uid': user.uid,
      'action': 'check-out',
      'timestamp': Timestamp.now(),
    });

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Checked out successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-In/Out')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                child:
                    isInside
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _checkIn,
                              icon: const Icon(Icons.login),
                              label: const Text('Check In'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: _checkOut,
                              icon: const Icon(Icons.logout),
                              label: const Text('Check Out'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                        : const Text("You're not within the office location"),
              ),
    );
  }
}
