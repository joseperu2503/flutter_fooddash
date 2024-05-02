import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.ref)
      : super(ProfileState(
          fullName: FormControl<String>(value: 'Jose Perez'),
          email: FormControl<String>(value: 'joseperu2503@gmail.com'),
          phone: FormControl<String>(value: '993 689 145'),
        ));
  final StateNotifierProviderRef ref;

  void changeFullName(FormControl<String> fullName) {
    state = state.copyWith(
      fullName: fullName,
    );
  }

  void changeEmail(FormControl<String> email) {
    state = state.copyWith(
      email: email,
    );
  }

  void changePhone(FormControl<String> phone) {
    state = state.copyWith(
      phone: phone,
    );
  }
}

class ProfileState {
  final FormControl<String> fullName;
  final FormControl<String> email;
  final FormControl<String> phone;

  ProfileState({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  ProfileState copyWith({
    FormControl<String>? fullName,
    FormControl<String>? email,
    FormControl<String>? phone,
  }) =>
      ProfileState(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );
}
