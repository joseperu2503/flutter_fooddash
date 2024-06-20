import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/config/router/app_router.dart';
import 'package:fooddash/features/address/widgets/address_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/features/dashboard/widgets/cart_button.dart';

class AppbarDashboard extends StatelessWidget {
  const AppbarDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      floating: true,
      flexibleSpace: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 42,
              alignment: Alignment.centerLeft,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(211, 209, 216, 0.3),
                      offset:
                          Offset(5, 10), // Desplazamiento horizontal y vertical
                      blurRadius: 20, // Radio de desenfoque
                      spreadRadius: 0, // Extensión de la sombra
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    if (tabKey.currentState == null) return;
                    tabKey.currentState!.handleMenuButtonPressed();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/menu.svg',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  showAddressBottomSheet(context);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Deliver to',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.slate800,
                            height: 1.22,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        SvgPicture.asset(
                          'assets/icons/arrow_down.svg',
                          width: 10,
                          colorFilter: const ColorFilter.mode(
                            AppColors.slate800,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      '4102  Pretty View Lane ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        height: 1.22,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CartButton(),
          ],
        ),
      ),
    );
  }
}
