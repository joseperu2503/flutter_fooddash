import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/config/constants/styles.dart';
import 'package:fooddash/features/address/providers/address_provider.dart';
import 'package:fooddash/features/shared/widgets/custom_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

const double heightBottomSheet = 200;

class AddressBottomSheet extends ConsumerStatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  AddressBottomSheetState createState() => AddressBottomSheetState();
}

class AddressBottomSheetState extends ConsumerState<AddressBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addressProvider.notifier).getMyAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screen = MediaQuery.of(context);
    final double heigh = 1 - (heightBottomSheet) / screen.size.height;
    final addressState = ref.watch(addressProvider);

    return DraggableScrollableSheet(
      initialChildSize: heigh,
      minChildSize: heigh,
      maxChildSize: 1,
      snap: true,
      snapSizes: [heigh, 1],
      expand: false,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                toolbarHeight: 180,
                scrolledUnderElevation: 0,
                flexibleSpace: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Add o choose an address',
                        style: modalBottomSheetTitle,
                      ),
                      const Divider(
                        color: AppColors.slate100,
                        height: 40,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.inputBorder,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            context.push('/search-address');
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location.svg',
                                colorFilter: const ColorFilter.mode(
                                  AppColors.label2,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                'Enter a new address',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.label2,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xffD3D1D8).withOpacity(0.25),
                                  offset: const Offset(0, 20),
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.white,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/map_pin.svg',
                                width: 24,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.label2,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Current location',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.label2,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        color: AppColors.slate50,
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  final address = addressState.addresses[index];

                  return SizedBox(
                    height: 80,
                    child: TextButton(
                      onPressed: () {},
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
                              AppColors.black,
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.label2,
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
                          const CustomCheck(
                            isSelected: true,
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
                    color: AppColors.slate50,
                  );
                },
                itemCount: addressState.addresses.length,
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 30),
              )
            ],
          ),
        );
      },
    );
  }
}
