
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:employee_attendance_app/screens/manual_check_in_out_screen.dart';
import 'package:employee_attendance_app/screens/login_screen.dart';
import 'package:employee_attendance_app/screens/landing_screen.dart'; // ✅ import it
import 'package:employee_attendance_app/screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCPoGOqD-QDRLiguGuExo1hEwJO8SDFL2E",
        authDomain: "ai-app-12365.firebaseapp.com",
        projectId: "ai-app-12365",
        storageBucket: "ai-app-12365.appspot.com",
        appId: "1:108009236655:android:ca2b8157767ac7e793cc5a",
        messagingSenderId: "108009236655",
      ),
    );
  } else {
    await Firebase.initializeApp(); // For Android/iOS
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Web App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(), // 👈 Auth check screen
        '/login': (context) => const LoginScreen(),
        '/manual-check': (context) => const ManualCheckInOutScreen(),
        '/home': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
