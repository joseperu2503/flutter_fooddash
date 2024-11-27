import 'package:fooddash/app/features/payment_methods/providers/payment_method_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/widgets/custom_text_field.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/shared/widgets/back_button.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';

class CardFormScreen extends ConsumerStatefulWidget {
  const CardFormScreen({super.key});

  @override
  CardFormScreenState createState() => CardFormScreenState();
}

class CardFormScreenState extends ConsumerState<CardFormScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paymentMethodProvider.notifier).resetForm();
    });
    super.initState();
  }

  MaskInputFormatter cardNumberFormatter = MaskInputFormatter(
    mask: '#### #### #### ####',
  );

  MaskInputFormatter ccvFormatter = MaskInputFormatter(
    mask: '###',
  );

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentMethodProvider);
    final MediaQueryData screen = MediaQuery.of(context);

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
                  // Center(
                  //   child: CreditCardWidget(
                  //     cardNumber: paymentState.cardNumber.value,
                  //     expiryDate: paymentState.expired.value,
                  //     cardHolderName: paymentState.name.value,
                  //     cvvCode: '',
                  //     showBackView: false,
                  //     isSwipeGestureEnabled: false,
                  //     isHolderNameVisible: true,
                  //     onCreditCardWidgetChange: (CreditCardBrand brand) {
                  //       if (brand.brandName == CardType.visa ||
                  //           brand.brandName == CardType.mastercard) {
                  //         cardNumberFormatter = MaskInputFormatter(
                  //           mask: '#### #### #### ####',
                  //         );
                  //         ccvFormatter = MaskInputFormatter(
                  //           mask: '###',
                  //         );
                  //       }
                  //       if (brand.brandName == CardType.americanExpress) {
                  //         cardNumberFormatter =
                  //             MaskInputFormatter(mask: '#### ###### #####');
                  //         ccvFormatter = MaskInputFormatter(
                  //           mask: '####',
                  //         );
                  //       }
                  //     },
                  //     padding: 0,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    label: 'Card Number',
                    value: paymentState.cardNumber,
                    onChanged: (value) {
                      ref
                          .read(paymentMethodProvider.notifier)
                          .changeCardNumber(value);
                    },
                    hintText: 'XXXX XXXX XXXX XXXX',
                    inputFormatters: [
                      cardNumberFormatter,
                      LengthLimitingTextInputFormatter(19)
                    ],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextField(
                    label: 'Card Holder Name',
                    value: paymentState.name,
                    onChanged: (value) {
                      ref
                          .read(paymentMethodProvider.notifier)
                          .changeName(value);
                    },
                    hintText: 'Enter Holder Name',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
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
                            CustomTextField(
                              label: 'Expired',
                              value: paymentState.expired,
                              onChanged: (value) {
                                ref
                                    .read(paymentMethodProvider.notifier)
                                    .changeExpired(value);
                              },
                              hintText: 'MM/YY',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                expiredFormatter,
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 24,
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
              ref.read(paymentMethodProvider.notifier).saveCard();
            },
            disabled: !paymentState.isFormValue,
            text: 'Save',
            loading: paymentState.savingCard == LoadingStatus.loading,
          ),
        ),
      ),
    );
  }
}

MaskInputFormatter expiredFormatter = MaskInputFormatter(
  mask: '##/##',
);
