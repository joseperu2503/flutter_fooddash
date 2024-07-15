import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/features/address/providers/address_provider.dart';
import 'package:fooddash/app/features/address/services/address_services.dart';
import 'package:fooddash/app/features/dashboard/widgets/cart_button.dart';

class AppbarDashboard extends ConsumerWidget {
  const AppbarDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressState = ref.watch(addressProvider);

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
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  AddressService.showAddressBottomSheet(context);
                },
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
                    Text(
                      addressState.selectedAddress?.address ?? '',
                      style: const TextStyle(
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
            const SizedBox(
              width: 10,
            ),
            const CartButton(),
          ],
        ),
      ),
    );
  }
}
