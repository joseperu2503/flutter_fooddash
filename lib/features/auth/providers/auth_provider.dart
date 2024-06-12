import 'dart:async';

import 'package:delivery_app/config/constants/storage_keys.dart';
import 'package:delivery_app/features/auth/services/auth_service.dart';
import 'package:delivery_app/features/core/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _checkAuthStatus();
  }

  setAuthStatus(AuthStatus authStatus) {
    state = state.copyWith(
      authStatus: authStatus,
    );

    if (authStatus == AuthStatus.authenticated) {
      _initAutoLogout();
    }
    if (authStatus == AuthStatus.notAuthenticated) {
      _cancelTimer();
    }
  }

  _checkAuthStatus() async {
    final (validToken, _) = await AuthService.verifyToken();
    if (validToken) {
      setAuthStatus(AuthStatus.authenticated);
    } else {
      await StorageService.remove(StorageKeys.token);
      setAuthStatus(AuthStatus.notAuthenticated);
    }
  }

  Timer? _timer;

  _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  _initAutoLogout() async {
    _cancelTimer();
    final (validToken, timeRemainingInSeconds) =
        await AuthService.verifyToken();

    if (validToken) {
      _timer = Timer(Duration(seconds: timeRemainingInSeconds), () {
        logout();
      });
    }
  }

  logout() async {
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
    );
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
