plugins {
    id("com.android.application")
    id("kotlin-android")

    // Apply the Google services Gradle plugin here
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.meal_app" // Replace with your actual package
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.meal_app" // same as Firebase package name
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.10")
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.7.0")

    // Firebase BoM (manages versions automatically)
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))

    // Add Firebase libraries you need (no versions needed if using BoM)
    // implementation("com.google.firebase:firebase-firestore-ktx")
    // implementation("com.google.firebase:firebase-messaging-ktx")
}
