import 'package:fooddash/app/config/constants/storage_keys.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/auth/models/login_response.dart';
import 'package:fooddash/app/features/auth/providers/auth_provider.dart';
import 'package:fooddash/app/features/auth/services/auth_service.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/core/services/storage_service.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/plugins/formx/formx.dart';
import 'package:fooddash/app/features/shared/plugins/formx/validators/validators.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';
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
      email: FormxInput<String>(
        value: '',
        validators: [Validators.required<String>(), Validators.email()],
      ),
      password: FormxInput(
        value: '',
        validators: [Validators.required()],
      ),
      rememberMe: rememberMe,
    );

    if (rememberMe) {
      state = state.copyWith(
        email: state.email.updateValue(email),
      );
    }
  }

  login() async {
    FocusManager.instance.primaryFocus?.unfocus();
    state = state.copyWith(
      email: state.email.touch(),
      password: state.password.touch(),
    );

    if (!Formx.validate([state.email, state.email])) return;

    state = state.copyWith(
      loading: LoadingStatus.loading,
    );

    try {
      final LoginResponse loginResponse = await AuthService.login(
        email: state.email.value,
        password: state.password.value,
      );

      await StorageService.set<String>(StorageKeys.token, loginResponse.token);

      setRemember();
      appRouter.go('/dashboard');
      ref.read(authProvider.notifier).initAutoLogout();
      state = state.copyWith(
        loading: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      SnackBarService.show(e.message);
    }
  }

  setRemember() async {
    if (state.rememberMe) {
      await StorageService.set<String>(StorageKeys.email, state.email.value);
    }
    await StorageService.set<bool>(StorageKeys.rememberMe, state.rememberMe);
  }

  changeEmail(FormxInput<String> email) {
    state = state.copyWith(
      email: email,
    );
  }

  changePassword(FormxInput<String> password) {
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
  final FormxInput<String> email;
  final FormxInput<String> password;
  final bool rememberMe;
  final LoadingStatus loading;

  LoginState({
    this.email = const FormxInput(value: ''),
    this.password = const FormxInput(value: ''),
    this.rememberMe = false,
    this.loading = LoadingStatus.none,
  });

  LoginState copyWith({
    FormxInput<String>? email,
    FormxInput<String>? password,
    bool? rememberMe,
    LoadingStatus? loading,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        rememberMe: rememberMe ?? this.rememberMe,
        loading: loading ?? this.loading,
      );
}