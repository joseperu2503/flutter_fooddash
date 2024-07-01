import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/config/router/app_router.dart';
import 'package:fooddash/features/auth/providers/auth_provider.dart';
import 'package:fooddash/features/core/models/service_exception.dart';
import 'package:fooddash/features/payment_methods/models/bank_card.dart';
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

  Future<void> getMyCards() async {
    if (state.loadingCards == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingCards: LoadingStatus.loading,
    );

    try {
      final List<BankCard> response = await PaymentMethodService.getMyCards();
      state = state.copyWith(
        cards: response,
        loadingCards: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        loadingCards: LoadingStatus.error,
      );
    }
  }

  Future<void> saveCard() async {
    if (state.savingCard == LoadingStatus.loading) return;

    state = state.copyWith(
      savingCard: LoadingStatus.loading,
    );

    try {
      List<String> dateParts = state.expired.value.split('/');
      int expirationMonth = int.parse(dateParts[0]);
      int expirationYear = 2000 + int.parse(dateParts[1]);

      final cardTokenResponse = await PaymentMethodService.createCardTokenMP(
        cardNumber: state.cardNumber.value.replaceAll(' ', ''),
        name: state.name.value,
        expirationMonth: expirationMonth,
        expirationYear: expirationYear,
        email: ref.read(authProvider).user?.email,
      );

      final cards = await PaymentMethodService.saveCard(
        token: cardTokenResponse.id,
      );

      state = state.copyWith(
        cards: cards,
        savingCard: LoadingStatus.success,
      );
      appRouter.pop();
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        savingCard: LoadingStatus.error,
      );
    }
  }

  Future<void> deleteCard(String cardId) async {
    if (state.savingCard == LoadingStatus.loading) return;

    state = state.copyWith(
      savingCard: LoadingStatus.loading,
    );

    try {
      final cards = await PaymentMethodService.deleteCard(
        cardId: cardId,
      );

      state = state.copyWith(
        cards: cards,
        savingCard: LoadingStatus.success,
      );
      appRouter.pop();
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
  final List<BankCard> cards;
  final LoadingStatus loadingCards;

  PaymentMethodState({
    this.cardNumber = const FormxInput(value: ''),
    this.name = const FormxInput(value: ''),
    this.expired = const FormxInput(value: ''),
    this.savingCard = LoadingStatus.none,
    this.cards = const [],
    this.loadingCards = LoadingStatus.none,
  });

  bool get isFormValue => cardNumber.isValid && name.isValid && expired.isValid;

  PaymentMethodState copyWith({
    FormxInput<String>? cardNumber,
    FormxInput<String>? name,
    FormxInput<String>? expired,
    LoadingStatus? savingCard,
    List<BankCard>? cards,
    LoadingStatus? loadingCards,
  }) =>
      PaymentMethodState(
        cardNumber: cardNumber ?? this.cardNumber,
        name: name ?? this.name,
        expired: expired ?? this.expired,
        savingCard: savingCard ?? this.savingCard,
        cards: cards ?? this.cards,
        loadingCards: loadingCards ?? this.loadingCards,
      );
}
