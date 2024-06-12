import 'package:delivery_app/config/constants/storage_keys.dart';
import 'package:delivery_app/features/auth/models/login_response.dart';
import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:delivery_app/features/auth/services/auth_service.dart';
import 'package:delivery_app/features/core/services/storage_service.dart';
import 'package:delivery_app/features/shared/plugins/formx/formx.dart';
import 'package:delivery_app/features/shared/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this.ref) : super(LoginState());
  final StateNotifierProviderRef ref;

  initData() async {
    final email = await StorageService.get<String>(StorageKeys.email) ?? '';
    final rememberMe =
        await StorageService.get<bool>(StorageKeys.rememberMe) ?? false;

    state = state.copyWith(
      email:
          rememberMe ? FormxInput(value: email) : const FormxInput(value: ''),
      password: const FormxInput(value: ''),
      rememberMe: rememberMe,
    );
  }

  login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    state = state.copyWith(
      email: state.email.touch(),
      password: state.password.touch(),
    );

    if (!Formx.validate([state.email, state.email])) return;

    state = state.copyWith(
      loading: true,
    );

    try {
      final LoginResponse loginResponse = await AuthService.login(
        email: state.email.value,
        password: state.password.value,
      );

      await StorageService.set<String>(StorageKeys.token, loginResponse.token);

      setRemember();
      ref.read(authProvider.notifier).setAuthStatus(AuthStatus.authenticated);
    } catch (e) {
      SnackBarService.show(e);
    }

    state = state.copyWith(
      loading: false,
    );
  }

  setRemember() async {
    if (state.rememberMe) {
      await StorageService.set<String>(StorageKeys.email, state.email.value);
    }
    await StorageService.set<bool>(StorageKeys.rememberMe, state.rememberMe);
  }

  changeEmail(FormxInput email) {
    state = state.copyWith(
      email: email,
    );
  }

  changePassword(FormxInput password) {
    state = state.copyWith(
      password: password,
    );
  }

  toggleRememberMe() {
    state = state.copyWith(
      rememberMe: !state.rememberMe,
    );
  }
}

class LoginState {
  final FormxInput email;
  final FormxInput password;
  final bool loading;
  final bool rememberMe;

  LoginState({
    this.email = const FormxInput(value: ''),
    this.password = const FormxInput(value: ''),
    this.loading = false,
    this.rememberMe = false,
  });

  LoginState copyWith({
    FormxInput? email,
    FormxInput? password,
    bool? loading,
    bool? rememberMe,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        loading: loading ?? this.loading,
        rememberMe: rememberMe ?? this.rememberMe,
      );
}
