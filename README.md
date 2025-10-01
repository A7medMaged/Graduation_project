# Smart Home — Flutter

A cross‑platform smart home app built with Flutter, Firebase, and BLoC. It provides real‑time sensor monitoring, role‑based home screens, device controls, offline awareness, notifications, and camera utilities.

## Table of contents
- Overview
- Features
- Tech stack
- App architecture
- Project structure
- Getting started
- Running the app
- Building releases
- Distribution (Android Fastlane)
- Firebase configuration
- Routes
- Troubleshooting

## Overview
This app demonstrates a production‑ready Flutter setup with:
- Firebase initialization and auth state logging
- GoRouter for declarative routing
- MultiBlocProvider with feature‑scoped cubits
- Realtime connectivity overlay
- Local notifications
## Features
- Real‑time sensors dashboard and observers
- Control LEDs, modes, and room/kitchen devices
- Role‑based screens: Father, Mother, Child
- Camera views: FireCam and FaceCam
- Offline screen and global connectivity banner
- Shimmer/skeleton loading states and polished UI

## Tech stack
- **Flutter**: Material 3, `google_fonts`
- **State management**: `flutter_bloc`
- **Navigation**: `go_router`
- **Firebase**: `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_database`
- **UX**: `shimmer`, `skeletonizer`, `getwidget`, `flutter_svg`, `toastification`
- **Platform**: `flutter_local_notifications`, `internet_connection_checker_plus`, `webview_flutter`
- **Tooling**: `logger`, `flutter_lints`, `flutter_launcher_icons`

## App architecture
- Layered by feature and core modules under `lib/`
- Declarative routing in `core/routing/router.dart`
- Repositories encapsulate data access (e.g., sensors, leds, mode)
- Cubits expose immutable states to the UI
- `GlobalSensorsObserver` provides global listeners and side‑effects
- `ConnectivityService` streams connectivity status to a global overlay

## Project structure
```text
lib/
  core/
    helper/               # connectivity, notifications, cameras
    routing/              # go_router config and route names
    theming/              # colors, text styles
    widgets/              # shared UI widgets
  features/
    home_screen/          # rooms, devices, sensors, profile
      data/               # repos and models
      presentation/       # screens, cubits, widgets
    login/                # login cubit + screen
    register/             # register cubit + screen
    splash_screen/        # splash and animated text
  main.dart               # Firebase + app bootstrap
  smart_home.dart         # App root, theme, providers, connectivity overlay
```

## Getting started
### Prerequisites
- Flutter SDK (3.24+). This project targets Dart 3.8 beta.
  - If needed, switch to beta channel:
    ```bash
    flutter channel beta && flutter upgrade
    flutter --version
    ```
- Firebase project (for Android, iOS, Web as needed)
- Java 17+ and Android SDK for Android builds
- Xcode for iOS/macOS builds (on macOS)

### 1) Install dependencies
```bash
flutter pub get
```

### 2) Configure Firebase
This repo already includes Android `google-services.json`. Ensure your Firebase configuration matches your bundle identifiers.
- Generate platform configs with FlutterFire CLI (recommended):
  ```bash
  dart pub global activate flutterfire_cli
  flutterfire configure
  ```
  This will create/update `lib/firebase_options.dart` used in `main.dart`.
- iOS: add `GoogleService-Info.plist` to `ios/Runner` and enable required URL schemes.
- Web: ensure Firebase config is injected in `web/index.html` by FlutterFire.
- Enable the Firebase products you use: Auth, Firestore, Realtime Database, Messaging/Notifications (optional).

### 3) Platform setup (Android)
- Ensure Gradle/Android tooling is installed
- In Android Studio, open `android/` to verify the project syncs
- Optional: set your own `applicationId` and app name/icons

## Running the app
```bash
# Device selection
flutter devices

# Run on Androidflutter run -d android

# Run on iOS (macOS only)
flutter run -d ios

# Run on web
flutter run -d chrome

# Run on Windows/macOS/Linux
flutter run -d windows   # or macos / linux
```

## Building releases
```bash
# Android APK (release)
flutter build apk --release

# Android AppBundle
flutter build appbundle --release

# iOS (requires code signing on macOS)
flutter build ios --release

# Web
flutter build web --release
```

## Distribution (Android Fastlane)
A Fastlane lane is provided to build and distribute the release APK via Firebase App Distribution:
- File: `android/fastlane/Fastfile`
- Lane: `distribute`

Run from `android/` (ensure you have `fastlane` installed):
```bash
cd android
bundle install   # if Gemfile present
fastlane distribute
```
Environment variables expected:
- `FIREBASE_CLI_TOKEN`: Firebase CLI token used by `firebase_app_distribution`

The lane performs:
- `flutter clean`
- `flutter build apk --release`
- Uploads `../build/app/outputs/flutter-apk/app-release.apk`

## Firebase configuration details
- Initialization occurs in `lib/main.dart` using `DefaultFirebaseOptions.currentPlatform` (generated by FlutterFire)
- Auth state changes are logged in debug mode via `logger`
- Local notifications initialized early via `NotificationService`
- Connectivity is initialized via `ConnectivityService`

## Routes
`go_router` central configuration: `lib/core/routing/router.dart`
- `/` → `SplashScreen`
- `/home` → `FatherHomeScreen`
- `/login` → `LoginScreen`
- `/register` → `RegisterScreen`
- `/user` → `UserProfileScreen`
- `/rooms`, `/room-one`, `/room-two` → Rooms and details with `LedsCubit`
- `/kitchen` → `Kitchen` with `SensorsCubit`
- `/father`, `/mother`, `/child` → Role‑based home screens
- `/mode` → `ToggleScreen`
- `/fire-cam`, `/face-cam` → Camera utilities
- `/offline` → `OfflineScreen`

## Troubleshooting
- Firebase init errors: re‑run `flutterfire configure` and ensure platform files are present
- Connectivity overlay always shown: verify internet permission and `ConnectivityService` setup
- Dart/Flutter version mismatch: ensure Flutter channel supports Dart 3.8 beta (try beta channel)
- iOS build codesign: configure provisioning profiles and bundle identifiers

---
Made with Flutter and Firebase. PRs and suggestions are welcome!
