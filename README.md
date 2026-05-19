# cross_platform

A new Flutter project.

## CarAPI setup

Chapter 12 uses the real CarAPI VIN decode endpoint. Run the app with your API
token passed at build time:

```sh
flutter run --dart-define=CARAPI_TOKEN=your_carapi_token
```

## Drift local database

Chapter 15 stores dealership data in SQLite through Drift. Saved cars,
reservation cart items and submitted orders are written to local database tables
and restored when the app starts.

When database tables or DAOs change, regenerate Drift code:

```sh
flutter pub run build_runner build --delete-conflicting-outputs
dart compile js web/drift_worker.dart -o web/drift_worker.js
```

## Firebase advisor chat

Chapter 16 is wired as an optional Firebase-backed advisor chat. Without Firebase,
the app uses a local in-memory chat fallback so development and tests still run.

To enable real Firebase Auth + Cloud Firestore:

```sh
dart pub global activate flutterfire_cli
flutterfire configure
firebase deploy --only firestore:rules
flutter run --dart-define=USE_FIREBASE=true
```

In Firebase Console, enable Anonymous sign-in under Authentication, create a Cloud
Firestore database and publish rules that allow authenticated users to read and
create advisor messages. To use the Chapter 16 login/sign-up screen, also enable
Email/Password under Authentication.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
