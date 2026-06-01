import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Represents the current authentication state of the user.
/// This will be expanded significantly when we integrate Firebase Auth.
@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return const AuthState.unauthenticated();
  }

  // TODO: Add signInWithPhone, verifyOtp, signOut methods
}

class AuthState {
  final bool isAuthenticated;
  final String? uid;
  final String? phoneNumber; // We will store masked version only

  const AuthState._({
    required this.isAuthenticated,
    this.uid,
    this.phoneNumber,
  });

  const AuthState.unauthenticated()
      : isAuthenticated = false,
        uid = null,
        phoneNumber = null;

  const AuthState.authenticated({required String uid, String? phoneNumber})
      : isAuthenticated = true,
        this.uid = uid,
        this.phoneNumber = phoneNumber;
}
