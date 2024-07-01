import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/features/core/models/service_exception.dart';
import 'package:fooddash/features/payment_methods/services/payment_method_service.dart';
import 'package:fooddash/features/payment_methods/validators/card_validator.dart';
import 'package:fooddash/features/shared/models/loading_status.dart';
import 'package:fooddash/features/shared/plugins/formx/formx.dart';
import 'package:fooddash/features/shared/plugins/formx/validators/validators.dart';
import 'package:fooddash/features/shared/services/snackbar_service.dart';

final paymentMethodProvider =
    StateNotifierProvider<PaymentMethodNotifier, PaymentMethodState>((ref) {
  return PaymentMethodNotifier(ref);
});

class PaymentMethodNotifier extends StateNotifier<PaymentMethodState> {
  PaymentMethodNotifier(this.ref) : super(PaymentMethodState());
  final StateNotifierProviderRef ref;

  resetForm() {
    state = state.copyWith(
      cardNumber: FormxInput(value: '', validators: [
        Validators.required(),
        Validators.composeOR([
          const VisaValidator(),
          const MasterCardValidator(),
          const AmexValidator(),
        ])
      ]),
      name: FormxInput(
        value: '',
        validators: [
          Validators.required(),
        ],
      ),
      expired: FormxInput(
        value: '',
        validators: [
          Validators.required(),
          const ExpiredValidator(),
        ],
      ),
    );
  }

  void changeCardNumber(FormxInput<String> cardNumber) {
    state = state.copyWith(
      cardNumber: cardNumber,
    );
  }

  void changeName(FormxInput<String> name) {
    state = state.copyWith(
      name: name,
    );
  }

  void changeExpired(FormxInput<String> expired) {
    state = state.copyWith(
      expired: expired,
    );
  }

  Future<void> saveCard() async {
    if (state.savingCard == LoadingStatus.loading) return;

    state = state.copyWith(
      savingCard: LoadingStatus.loading,
    );

    try {
      List<String> dateParts = state.expired.value.split('/');
      int expirationMonth = int.parse(dateParts[0]);
      int expirationYear = int.parse(dateParts[1]);

      await PaymentMethodService.createCardTokenMP(
        cardNumber: state.cardNumber.value,
        name: state.name.value,
        expirationMonth: expirationMonth,
        expirationYear: expirationYear,
      );

      state = state.copyWith(
        savingCard: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        savingCard: LoadingStatus.error,
      );
    }
  }
}

class PaymentMethodState {
  final FormxInput<String> cardNumber;
  final FormxInput<String> name;
  final FormxInput<String> expired;
  final LoadingStatus savingCard;

  PaymentMethodState({
    this.cardNumber = const FormxInput(value: ''),
    this.name = const FormxInput(value: ''),
    this.expired = const FormxInput(value: ''),
    this.savingCard = LoadingStatus.none,
  });

  bool get isFormValue => cardNumber.isValid && name.isValid && expired.isValid;

  PaymentMethodState copyWith({
    FormxInput<String>? cardNumber,
    FormxInput<String>? name,
    FormxInput<String>? expired,
    LoadingStatus? savingCard,
  }) =>
      PaymentMethodState(
        cardNumber: cardNumber ?? this.cardNumber,
        name: name ?? this.name,
        expired: expired ?? this.expired,
        savingCard: savingCard ?? this.savingCard,
      );
}
