import 'package:fooddash/features/shared/plugins/formx/formx.dart';
import 'package:fooddash/features/shared/widgets/custom_text_field.dart';
import 'package:fooddash/features/shared/widgets/custom_textarea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/address/providers/address_provider.dart';
import 'package:fooddash/features/shared/widgets/back_button.dart';
import 'package:fooddash/features/shared/widgets/custom_button.dart';

class ConfirmAddressScreen extends ConsumerWidget {
  const ConfirmAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressState = ref.watch(addressProvider);
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
                  'Confirm Address',
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
                  CustomTextField(
                    label: 'City, Country*',
                    value: FormxInput(
                      value:
                          '${addressState.city.value}, ${addressState.country.value}',
                    ),
                    readOnly: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextField(
                    label: 'Address or location*',
                    value: addressState.address,
                    readOnly: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextField(
                    label: 'Detail: app / flat / house',
                    value: addressState.detail,
                    hintText: 'Ex. Río de oto building apt 201',
                    onChanged: (value) {
                      ref.read(addressProvider.notifier).changeDetail(value);
                    },
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const Text(
                    'Tags',
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
                  SizedBox(
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final Tag tag = tags[index];
                        final bool isSelected = tag.id == addressState.tag?.id;
                        return GestureDetector(
                          onTap: () {
                            ref.read(addressProvider.notifier).changeTag(tag);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.inputBorder,
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  tag.icon,
                                  height: 14,
                                  width: 14,
                                  colorFilter: ColorFilter.mode(
                                    isSelected
                                        ? AppColors.primary
                                        : AppColors.input,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  tag.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.input,
                                    height: 1,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemCount: tags.length,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Delivery Details',
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
                  SizedBox(
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final DeliveryDetail delivery = deliveryDetails[index];
                        final bool isSelected =
                            delivery.id == addressState.deliveryDetail?.id;
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(addressProvider.notifier)
                                .changeDelivery(delivery);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.inputBorder,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  delivery.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.input,
                                    height: 1,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemCount: deliveryDetails.length,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextarea(
                    label: 'References',
                    value: addressState.references,
                    hintText: 'E.g. house with green bars, next to the bakery.',
                    onChanged: (value) {
                      ref
                          .read(addressProvider.notifier)
                          .changeReferences(value);
                    },
                  ),
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
              context.pop();
              context.pop();
            },
            text: 'Save',
          ),
        ),
      ),
    );
  }
}
