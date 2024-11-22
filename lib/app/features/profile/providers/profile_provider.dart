import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/features/auth/models/auth_user.dart';
import 'package:fooddash/app/features/auth/providers/auth_provider.dart';
import 'package:fooddash/app/features/auth/services/auth_service.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/plugins/formx/formx.dart';
import 'package:fooddash/app/features/shared/plugins/formx/validators/validators.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.ref) : super(ProfileState());
  final Ref ref;

  initData() async {
    final AuthUser? user = ref.read(authProvider).user;
    if (user == null) return;

    state = state.copyWith(
      name: FormxInput(value: user.name, validators: [
        Validators.required(),
      ]),
      surname: FormxInput(value: user.surname, validators: [
        Validators.required(),
      ]),
      email: FormxInput<String>(value: user.email, validators: [
        Validators.required<String>(),
        Validators.email(),
      ]),
      phone: FormxInput(value: user.phone, validators: [
        Validators.required(),
      ]),
      showButton: false,
    );
  }

  submit() async {
    state = state.copyWith(
      loading: LoadingStatus.loading,
    );
    try {
      final response = await AuthService.changePersonalData(
        email: state.email.value,
        name: state.name.value,
        surname: state.surname.value,
        phone: state.phone.value,
      );
      ref.read(authProvider.notifier).setuser(response);
      state = state.copyWith(
        loading: LoadingStatus.success,
      );
      SnackBarService.show('Your data has been updated');
      initData();
    } catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      SnackBarService.show(e);
    }
  }

  void changeName(FormxInput<String> name) {
    state = state.copyWith(
      name: name,
      showButton: true,
    );
  }

  void changeSurname(FormxInput<String> surname) {
    state = state.copyWith(
      surname: surname,
      showButton: true,
    );
  }

  void changeEmail(FormxInput<String> email) {
    state = state.copyWith(
      email: email,
      showButton: true,
    );
  }

  void changePhone(FormxInput<String> phone) {
    state = state.copyWith(
      phone: phone,
      showButton: true,
    );
  }
}

class ProfileState {
  final FormxInput<String> name;
  final FormxInput<String> surname;
  final FormxInput<String> email;
  final FormxInput<String> phone;
  final LoadingStatus loading;
  final bool showButton;

  ProfileState({
    this.name = const FormxInput(value: ''),
    this.surname = const FormxInput(value: ''),
    this.email = const FormxInput(value: ''),
    this.phone = const FormxInput(value: ''),
    this.loading = LoadingStatus.none,
    this.showButton = false,
  });

  bool get buttonDisabled =>
      name.isInvalid || surname.isInvalid || email.isInvalid || phone.isInvalid;

  ProfileState copyWith({
    FormxInput<String>? name,
    FormxInput<String>? surname,
    FormxInput<String>? email,
    FormxInput<String>? phone,
    LoadingStatus? loading,
    bool? showButton,
  }) =>
      ProfileState(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        loading: loading ?? this.loading,
        showButton: showButton ?? this.showButton,
      );
}
