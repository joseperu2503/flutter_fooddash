import 'dart:async';

import 'package:flutter_fooddash/config/constants/storage_keys.dart';
import 'package:flutter_fooddash/features/auth/services/auth_service.dart';
import 'package:flutter_fooddash/features/core/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _checkAuthStatus();
  }

  setAuthStatus(AuthStatus authStatus) async {
    if (authStatus == AuthStatus.authenticated) {
      _initAutoLogout();
    }
    if (authStatus == AuthStatus.notAuthenticated) {
      await StorageService.remove(StorageKeys.token);
      _cancelTimer();
    }
    state = state.copyWith(
      authStatus: authStatus,
    );
  }

  _checkAuthStatus() async {
    final (validToken, _) = await AuthService.verifyToken();
    if (validToken) {
      setAuthStatus(AuthStatus.authenticated);
    } else {
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
    setAuthStatus(AuthStatus.notAuthenticated);
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
