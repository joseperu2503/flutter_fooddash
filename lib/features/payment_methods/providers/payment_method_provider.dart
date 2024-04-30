import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final paymentMethodProvider =
    StateNotifierProvider<PaymentMethodNotifier, PaymentMethodState>((ref) {
  return PaymentMethodNotifier(ref);
});

class PaymentMethodNotifier extends StateNotifier<PaymentMethodState> {
  PaymentMethodNotifier(this.ref)
      : super(PaymentMethodState(
          cardNumber: FormControl<String>(value: ''),
          name: FormControl<String>(value: ''),
          expired: FormControl<String>(value: ''),
          ccv: FormControl<String>(value: ''),
        ));
  final StateNotifierProviderRef ref;

  void changeCardNumber(FormControl<String> cardNumber) {
    state = state.copyWith(
      cardNumber: cardNumber,
    );
  }

  void changeName(FormControl<String> name) {
    state = state.copyWith(
      name: name,
    );
  }

  void changeExpired(FormControl<String> expired) {
    state = state.copyWith(
      expired: expired,
    );
  }

  void changeCcv(FormControl<String> ccv) {
    state = state.copyWith(
      ccv: ccv,
    );
  }
}

class PaymentMethodState {
  final FormControl<String> cardNumber;
  final FormControl<String> name;
  final FormControl<String> expired;
  final FormControl<String> ccv;

  PaymentMethodState({
    required this.cardNumber,
    required this.name,
    required this.expired,
    required this.ccv,
  });

  PaymentMethodState copyWith({
    FormControl<String>? cardNumber,
    FormControl<String>? name,
    FormControl<String>? expired,
    FormControl<String>? ccv,
  }) =>
      PaymentMethodState(
        cardNumber: cardNumber ?? this.cardNumber,
        name: name ?? this.name,
        expired: expired ?? this.expired,
        ccv: ccv ?? this.ccv,
      );
}
