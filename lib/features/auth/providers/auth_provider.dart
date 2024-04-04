import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    checkAuthStatus();
  }

  setAuthStatus(AuthStatus authStatus) {
    state = state.copyWith(
      authStatus: authStatus,
    );
  }

  checkAuthStatus() {
    // Future.delayed(const Duration(seconds: 1), () {
    //   setAuthStatus(AuthStatus.authenticated);
    // });
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;

  AuthState({
    this.authStatus = AuthStatus.checking,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
      );
}
