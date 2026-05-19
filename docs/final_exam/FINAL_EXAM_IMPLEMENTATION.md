# Final Exam Implementation Notes

Course: Cross-platform mobile development
App: CarStore

## Implemented animation requirements

- Page transition animation: all main GoRouter routes now use CustomTransitionPage with fade + slide transitions.
- Button animation: major action buttons are wrapped with AnimatedTapButton, which scales the button while pressed.
- Loading animation: the search button now uses a pulsing animated indicator while car search is running.
- Scale animation: favorite state changes use AnimatedSwitcher with ScaleTransition.
- Lottie animation: the Account page displays `assets/animations/car_pulse.json` using the Lottie package.
- Hero animation: showroom cards and car images use Hero tags for smooth image transitions.
- Slide animation: search results, showroom cards and inventory rows use StaggeredSlideIn.

## Firebase integrations

- Advisor chat: real-time Firestore-backed chat when running with `--dart-define=USE_FIREBASE=true`.
- Favorite cars: saved/removed favorite car IDs sync to Firestore.
- Car feedback/comments: feedback is saved to Firestore and streamed back into the car sheet.
- Order history: completed reservation orders are synced to Firestore.

## Chapter 20 Android build notes

Commands for Android release preparation:

```bash
flutter clean
flutter pub get
flutter test
flutter build appbundle --release
```

The generated Android release artifact is usually located at:

```text
build/app/outputs/bundle/release/app-release.aab
```

Before real Play Store submission, configure a production app ID, signing key, privacy policy, store listing, and release track in Google Play Console.

## Chapter 21 iOS build notes

Commands for iOS release preparation on macOS:

```bash
flutter clean
flutter pub get
flutter test
flutter build ios --release
```

Then open:

```text
ios/Runner.xcworkspace
```

In Xcode, configure Bundle Identifier, Signing & Capabilities, version/build number, archive the app, and upload to App Store Connect/TestFlight.

## How to run

Local mode:

```bash
flutter run
```

Firebase mode:

```bash
flutter run --dart-define=USE_FIREBASE=true
```

Tests:

```bash
flutter test
```

Golden toolkit test baseline update:

```bash
flutter test test/goldens/login_page_golden_test.dart --update-goldens
```
