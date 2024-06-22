import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/features/auth/models/auth_user.dart';
import 'package:fooddash/features/auth/providers/auth_provider.dart';
import 'package:fooddash/features/shared/plugins/formx/formx.dart';
import 'package:fooddash/features/shared/plugins/formx/validators/validators.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.ref) : super(ProfileState());
  final StateNotifierProviderRef ref;

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
    );
  }

  void changeName(FormxInput<String> name) {
    state = state.copyWith(
      name: name,
    );
  }

  void changeSurname(FormxInput<String> surname) {
    state = state.copyWith(
      surname: surname,
    );
  }

  void changeEmail(FormxInput<String> email) {
    state = state.copyWith(
      email: email,
    );
  }

  void changePhone(FormxInput<String> phone) {
    state = state.copyWith(
      phone: phone,
    );
  }
}

class ProfileState {
  final FormxInput<String> name;
  final FormxInput<String> surname;
  final FormxInput<String> email;
  final FormxInput<String> phone;

  ProfileState({
    this.name = const FormxInput(value: ''),
    this.surname = const FormxInput(value: ''),
    this.email = const FormxInput(value: ''),
    this.phone = const FormxInput(value: ''),
  });

  ProfileState copyWith({
    FormxInput<String>? name,
    FormxInput<String>? surname,
    FormxInput<String>? email,
    FormxInput<String>? phone,
  }) =>
      ProfileState(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );
}
