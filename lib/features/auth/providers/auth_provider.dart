import 'dart:async';

import 'package:fooddash/config/constants/storage_keys.dart';
import 'package:fooddash/config/router/app_router.dart';
import 'package:fooddash/features/auth/services/auth_service.dart';
import 'package:fooddash/features/core/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(true);

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
