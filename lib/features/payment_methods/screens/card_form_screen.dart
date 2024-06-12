import 'package:fooddash/features/payment_methods/providers/payment_method_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/shared/widgets/back_button.dart';
import 'package:fooddash/features/shared/widgets/custom_button.dart';
import 'package:fooddash/features/shared/widgets/custom_input.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:reactive_forms/reactive_forms.dart';

const double heightBottomSheet = 380;

class CardFormScreen extends ConsumerStatefulWidget {
  const CardFormScreen({super.key});

  @override
  CardFormScreenState createState() => CardFormScreenState();
}

class CardFormScreenState extends ConsumerState<CardFormScreen> {
  final FocusNode _focusNodeCcv = FocusNode();
  bool showBackView = false;
  @override
  void initState() {
    _focusNodeCcv.addListener(() {
      setState(() {
        showBackView = _focusNodeCcv.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentMethodProvider);
    final MediaQueryData screen = MediaQuery.of(context);

    final FormControl<String> cardNumberInput = paymentState.cardNumber;

    if (paymentState.cardNumber.value != null) {
      cardNumberInput.patchValue(addSpaces(cardNumberInput.value!));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: const Row(
              children: [
                CustomBackButton(),
                Spacer(),
                Text(
                  'Add New Card',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.input,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 38,
                  height: 38,
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 20,
                bottom: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CreditCardWidget(
                      cardNumber: paymentState.cardNumber.value ?? '',
                      expiryDate: paymentState.expired.value ?? '',
                      cardHolderName: paymentState.name.value ?? '',
                      cvvCode: paymentState.ccv.value ?? '',
                      showBackView: showBackView,
                      isHolderNameVisible: true,
                      onCreditCardWidgetChange: (CreditCardBrand brand) {},
                      padding: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Card Number',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.label,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInput(
                    value: cardNumberInput,
                    onChanged: (value) {
                      FormControl<String> formControl = value;
                      if (value.value != null) {
                        formControl.patchValue(removeSpaces(value.value!));
                      }
                      ref
                          .read(paymentMethodProvider.notifier)
                          .changeCardNumber(formControl);
                    },
                    hintText: 'XXXX XXXX XXXX XXXX',
                    inputFormatters: [
                      CardFormatter(),
                      LengthLimitingTextInputFormatter(19)
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const Text(
                    'Card Holder Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.label,
                      height: 16 / 16,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInput(
                    value: paymentState.name,
                    onChanged: (value) {
                      ref
                          .read(paymentMethodProvider.notifier)
                          .changeName(value);
                    },
                    hintText: 'Enter Holder Name',
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Expired',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.label,
                                height: 16 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomInput(
                              value: paymentState.expired,
                              onChanged: (value) {
                                ref
                                    .read(paymentMethodProvider.notifier)
                                    .changeExpired(value);
                              },
                              hintText: 'MM/YY',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'CVC/CCV',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.label,
                                height: 16 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomInput(
                              value: paymentState.ccv,
                              onChanged: (value) {
                                ref
                                    .read(paymentMethodProvider.notifier)
                                    .changeCcv(value);
                              },
                              hintText: 'XXX',
                              focusNode: _focusNodeCcv,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: EdgeInsets.only(bottom: screen.padding.bottom),
        height: 110,
        child: Center(
          child: CustomButton(
            onPressed: () {
              context.pop();
            },
            text: 'SAVE',
          ),
        ),
      ),
    );
  }
}

int offset(int selectionEnd) {
  if (selectionEnd >= 0 && selectionEnd <= 3) {
    return 0;
  }
  if (selectionEnd >= 4 && selectionEnd <= 8) {
    return 1;
  }
  if (selectionEnd >= 9 && selectionEnd <= 13) {
    return 2;
  }
  return 3;
}

class CardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Rechazar la entrada si ingresan espacio
    if (removeSpaces(oldValue.text) == removeSpaces(newValue.text) &&
        (newValue.text.length > oldValue.text.length)) {
      return oldValue;
    }

    final regex = RegExp(r'^[0-9]*$');
    if (!regex.hasMatch(removeSpaces(newValue.text))) {
      return oldValue; // Rechazar la entrada si no contiene solo números
    }

    var newText = addSpaces(newValue.text);

    //limitar a 19 caracteres, esto es porque al pegar de la papelera
    //el LengthLimitingTextInputFormatter(19) no funcionaba
    if (newText.length > 19) {
      newText = newText.substring(0, 19);
    }

    //variable para saber cuanto hay que aumentarle o disminuirle al puntero
    var addSelection = 0;

    // al agregar caracteres, funciona para cuando se pega del portapapeles
    if (newValue.text.length > oldValue.text.length) {
      addSelection =
          offset(newValue.selection.end) - offset(oldValue.selection.end);
      //al agregar caracter, cuando el puntero esté en las posiciones indicadas se le aumentará una posicion
      if ([4, 9, 14].contains(oldValue.selection.end)) {
        addSelection = addSelection + 1;
      }
    }
    //al remover caracter, cuando el puntero esté en las posiciones indicadas se le restara una posicion
    if (newValue.text.length < oldValue.text.length) {
      if ([5, 10, 15].contains(newValue.selection.end)) {
        addSelection = -1;
      }
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newValue.selection.end + addSelection > 19
            ? 19
            : newValue.selection.end + addSelection,
      ),
    );
  }
}

String addSpaces(String value) {
  final StringBuffer result = StringBuffer();
  int groupLength = 0;
  String stringWithoutSpaces = removeSpaces(value);

  for (int i = 0; i < stringWithoutSpaces.length; i++) {
    result.write(stringWithoutSpaces[i]);
    if ([3, 7, 11].contains(groupLength)) {
      // Agrega un espacio después de cada grupo de 4 dígitos, al final se obtiene 4 grupos de 4 dígitos
      result.write(' ');
    }
    groupLength++;
  }

  return result.toString();
}

String removeSpaces(String value) {
  return value.replaceAll(' ', '');
}
