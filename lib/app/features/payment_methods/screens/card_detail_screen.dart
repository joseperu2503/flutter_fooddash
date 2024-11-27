import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/features/payment_methods/models/payment_methods.dart';
import 'package:fooddash/app/features/payment_methods/providers/payment_method_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/shared/widgets/back_button.dart';
import 'package:go_router/go_router.dart';

class CardDetailScreen extends ConsumerStatefulWidget {
  const CardDetailScreen({
    super.key,
    required this.cardId,
  });

  final String cardId;

  @override
  CardDetailScreenState createState() => CardDetailScreenState();
}

class CardDetailScreenState extends ConsumerState<CardDetailScreen> {
  @override
  void initState() {
    getCard();
    super.initState();
  }

  PaymentMethod? paymentMethod;

  getCard() {
    final paymentMethods = ref.read(paymentMethodProvider).paymentMethods;
    final paymentMethodsIndex =
        paymentMethods.indexWhere((element) => element.id == widget.cardId);

    if (paymentMethodsIndex < 0) {
      context.pop();
      return;
    }

    setState(() {
      paymentMethod = paymentMethods[paymentMethodsIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: Row(
              children: [
                const CustomBackButton(),
                const Spacer(),
                const Text(
                  'Card Detail',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.input,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(211, 209, 216, 0.3),
                        offset: Offset(
                            5, 10), // Desplazamiento horizontal y vertical
                        blurRadius: 20, // Radio de desenfoque
                        spreadRadius: 0, // Extensión de la sombra
                      ),
                    ],
                  ),
                  height: 38,
                  width: 38,
                  child: TextButton(
                    onPressed: () {
                      if (paymentMethod == null) return;
                      ref
                          .read(paymentMethodProvider.notifier)
                          .deleteCard(paymentMethod!.id);
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/delete.svg',
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.error,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
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
                      cardNumber:
                          '${paymentMethod?.firstSixDigits.toString()}000000${paymentMethod?.lastFourDigits.toString()}',
                      expiryDate:
                          '${paymentMethod?.expirationMonth.toString()}/${paymentMethod?.expirationYear.toString().substring(2, 4)}',
                      cardHolderName: '${paymentMethod?.cardHolder.name}',
                      cvvCode: '',
                      showBackView: false,
                      isSwipeGestureEnabled: false,
                      isHolderNameVisible: true,
                      onCreditCardWidgetChange: (CreditCardBrand brand) {},
                      padding: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
