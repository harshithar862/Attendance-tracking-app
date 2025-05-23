// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCFJBgqKC-TXzJm8Bw41v-ImVVR0zrsius',
    appId: '1:108009236655:web:77ebc1cbf0f5638f93cc5a',
    messagingSenderId: '108009236655',
    projectId: 'ai-app-12365',
    authDomain: 'ai-app-12365.firebaseapp.com',
    storageBucket: 'ai-app-12365.firebasestorage.app',
    measurementId: 'G-M07FD4KDKL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPoGOqD-QDRLiguGuExo1hEwJO8SDFL2E',
    appId: '1:108009236655:android:ca2b8157767ac7e793cc5a',
    messagingSenderId: '108009236655',
    projectId: 'ai-app-12365',
    storageBucket: 'ai-app-12365.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyGqvOFCTjMeUkGGcWfZQiyhUtApNepUQ',
    appId: '1:108009236655:ios:aaf3d94ddd80012693cc5a',
    messagingSenderId: '108009236655',
    projectId: 'ai-app-12365',
    storageBucket: 'ai-app-12365.firebasestorage.app',
    iosBundleId: 'com.example.employeeAttendanceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyGqvOFCTjMeUkGGcWfZQiyhUtApNepUQ',
    appId: '1:108009236655:ios:aaf3d94ddd80012693cc5a',
    messagingSenderId: '108009236655',
    projectId: 'ai-app-12365',
    storageBucket: 'ai-app-12365.firebasestorage.app',
    iosBundleId: 'com.example.employeeAttendanceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCFJBgqKC-TXzJm8Bw41v-ImVVR0zrsius',
    appId: '1:108009236655:web:d184498afc2e12ad93cc5a',
    messagingSenderId: '108009236655',
    projectId: 'ai-app-12365',
    authDomain: 'ai-app-12365.firebaseapp.com',
    storageBucket: 'ai-app-12365.firebasestorage.app',
    measurementId: 'G-04ZMH5BQ6J',
  );
}
