import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/address/providers/address_provider.dart';
import 'package:fooddash/app/features/shared/widgets/back_button.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
import 'package:fooddash/app/features/shared/widgets/custom_check.dart';
import 'package:go_router/go_router.dart';

class MyAddressesScreen extends ConsumerStatefulWidget {
  const MyAddressesScreen({super.key});

  @override
  MyAddressesState createState() => MyAddressesState();
}

class MyAddressesState extends ConsumerState<MyAddressesScreen> {
  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(addressProvider);

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
                  'My Addresses',
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
          SliverList.separated(
            itemBuilder: (context, index) {
              final address = addressState.addresses[index];
              final bool isSelected =
                  addressState.selectedAddress?.id == address.id;

              return SizedBox(
                height: 80,
                child: TextButton(
                  onPressed: () {
                    ref
                        .read(addressProvider.notifier)
                        .changeSelectedAddress(address);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/tabs/home_outlined.svg',
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.label2,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              address.address,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppColors.orange
                                    : AppColors.label2,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            Text(
                              address.addressTag != null
                                  ? address.addressTag!.name
                                  : 'Other',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.label,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomCheck(
                        isSelected: isSelected,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                color: AppColors.inputBorder,
              );
            },
            itemCount: addressState.addresses.length,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          top: 8,
          left: 24,
          right: 24,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                width: 200,
                onPressed: () {
                  context.push('/search-address');
                },
                text: 'Add new address',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
