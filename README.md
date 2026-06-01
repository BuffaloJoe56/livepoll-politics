# LivePoll Politics

A safe, modern Flutter app for daily political polling.

- Login with **phone number only** (Firebase Phone Auth)
- Vote **once per day per country**
- Anyone can view **live results** without logging in
- Starts with **South Africa** and **United States**
- Dark, modern design
- Works on **mobile and web**

## Important: Firebase Setup Required

This app requires a Firebase project with the following services enabled:

1. **Firebase Authentication** → Phone sign-in method enabled
2. **Cloud Firestore** (in production mode or with proper rules)
3. **Firebase App Check** (strongly recommended, especially for web)

### Steps

1. Create a new Firebase project at https://console.firebase.google.com
2. Add Android, iOS, and Web apps
3. Enable Phone Authentication
4. Run `flutterfire configure` (after installing FlutterFire CLI)
5. Replace the generated `firebase_options.dart`
6. Deploy the security rules from `firestore.rules` (when created)

Until Firebase is configured, the app will run in a limited demo mode.

## Getting Started (Development)

```bash
flutter pub get
flutter run -d chrome     # Web
flutter run -d ios        # iOS simulator
flutter run -d android    # Android emulator
```

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── models/
│   └── theme/
├── features/
│   ├── auth/
│   ├── results/
│   └── voting/
└── shared/
```

## Current Status

This is an early MVP scaffold. Authentication and real voting are not yet functional.

Security rules and one-vote-per-day enforcement are the most critical upcoming pieces.

## License

Private project.
