
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ✅ Correct way
}

android {
    namespace = "com.example.employee_attendance_app"
    compileSdk = 35
    ndkVersion = "27.0.12077973" // ✅ Set correct NDK version explicitly

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.employee_attendance_app"
        minSdk =  23 // ✅ Fix for firebase_auth and others
        targetSdk = 33 // Or your target
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
