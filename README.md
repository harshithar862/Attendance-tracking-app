

## 📱 Employee Attendance Tracking App

### 📌 Overview

This mobile application automates employee sign-in and sign-out processes using geolocation, minimizing manual effort and improving accuracy in attendance tracking. Developed as part of the **Smart India Hackathon (SIH)** with a problem statement by **GAIL (India) Ltd**, the app uses GPS-based geofencing to log attendance securely and efficiently.

### 🚀 Features

* **🔒 Geolocation-Based Attendance**

  * Auto check-in/out when entering or leaving a 200-meter office radius.
  * Geofencing powered by GPS ensures accurate tracking.

* **📝 Manual Check-in/Check-out**

  * For offsite employees or remote work scenarios.
  * Allows manual entry with GPS coordinates from nearby verified locations.

* **📊 Working Hours Calculation**

  * Calculates total hours worked using time of check-in and check-out.
  * Updated in real-time for accurate working summaries.

* **🧾 Real-Time Logging**

  * Attendance logs updated and stored securely in real-time using Firebase.

* **🔐 Data Security**

  * Logs are securely stored to avoid data loss or tampering.
  * Real-time sync ensures consistent records across all devices.

* **🌐 Free and Open Source**

  * All technologies used comply with Smart India Hackathon's guidelines.

---

### 🧰 Tech Stack

* **Frontend**: Flutter (Dart)
* **Backend**: Firebase (Auth, Firestore)
* **Geolocation Services**: `geofence_service`, `geolocator`
* **Notifications**: `flutter_local_notifications`
* **State Management**: Provider / SetState (based on screen)


### 📂 Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── map_screen.dart
│   ├── summary_screen.dart
├── services/
│   ├── geofencing_service_manager.dart
│   ├── location_service.dart
│   ├── auth_service.dart
├── widgets/
│   └── custom_drawer.dart
```

### 🛠️ Setup Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/attendance-tracker.git
   ```

2. **Navigate to project:**

   ```bash
   cd attendance-tracker
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Set up Firebase:**

   * Add your `google-services.json` (Android) or `GoogleService-Info.plist` (iOS).
   * Enable Firestore and Firebase Auth in Firebase Console.

5. **Run the app:**

   ```bash
   flutter run
   ```

---

### 🧪 Testing

* Test geofence by simulating location changes in emulator or physical device.
* Verify logs in Firebase Firestore.
* Try both auto and manual check-in features.
