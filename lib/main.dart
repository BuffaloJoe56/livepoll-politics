import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// When Firebase is ready, also import:
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'core/constants/countries.dart';
import 'core/theme/app_theme.dart';
import 'features/results/presentation/results_screen.dart';
import 'features/auth/presentation/phone_auth_screen.dart';
import 'features/voting/presentation/vote_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ---------------------------------------------------------------------------
  // Firebase Initialization (commented until you run flutterfire configure)
  // ---------------------------------------------------------------------------
  //
  // 1. Follow the instructions in lib/firebase_options.dart
  // 2. Uncomment the two lines below
  // 3. Add the import for firebase_options.dart
  //
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // Also uncomment these imports when ready:
  // import 'package:firebase_core/firebase_core.dart';
  // import 'firebase_options.dart';

  runApp(
    const ProviderScope(
      child: LivePollPoliticsApp(),
    ),
  );
}

class LivePollPoliticsApp extends StatelessWidget {
  const LivePollPoliticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LivePoll • South Africa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'results',
      builder: (context, state) => const ResultsScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const PhoneAuthScreen(),
    ),
    GoRoute(
      path: '/vote/:countryCode',
      name: 'vote',
      builder: (context, state) {
        final code = state.pathParameters['countryCode']!;
        final country = Country.values.firstWhere(
          (c) => c.code == code,
          orElse: () => Country.southAfrica,
        );
        return VoteScreen(country: country);
      },
    ),
  ],
);
