import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooddash/config/constants/storage_keys.dart';
import 'package:fooddash/config/router/app_router.dart';
import 'package:fooddash/features/auth/models/auth_user.dart';
import 'package:fooddash/features/auth/services/auth_service.dart';
import 'package:fooddash/features/core/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/features/shared/services/snackbar_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> getUser() async {
    try {
      final (validToken, _) = await AuthService.verifyToken();
      if (!validToken) return;

      final AuthUser user = await AuthService.getUser();

      setuser(user);
    } catch (e) {
      SnackBarService.show(e);
    }
  }

  setuser(AuthUser? user) {
    state = state.copyWith(
      user: () => user,
    );
  }

  Timer? _timer;

  _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  initAutoLogout() async {
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
    await StorageService.remove(StorageKeys.token);
    _cancelTimer();
    appRouter.go('/');
  }
}

class AuthState {
  final AuthUser? user;

  AuthState({
    this.user,
  });

  AuthState copyWith({
    ValueGetter<AuthUser?>? user,
  }) =>
      AuthState(
        user: user != null ? user() : this.user,
      );
}
