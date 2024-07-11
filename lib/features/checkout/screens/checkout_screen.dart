import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/config/constants/styles.dart';
import 'package:fooddash/features/address/providers/address_provider.dart';
import 'package:fooddash/features/cart/providers/cart_provider.dart';
import 'package:fooddash/features/checkout/widgets/order_successfully.dart';
import 'package:fooddash/features/checkout/widgets/payment_modal.dart';
import 'package:fooddash/features/shared/utils/utils.dart';
import 'package:fooddash/features/shared/widgets/back_button.dart';
import 'package:fooddash/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/features/shared/widgets/custom_label.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addMarkerDelivery();
    });
  }

//añadir marker del restaurant
  addMarkerDelivery() async {
    final icon = await Utils.bitmapDescriptorFromSvgAsset(
      'assets/icons/map_pin_solid.svg',
      const Size(32, 32),
    );

    final address = ref.read(addressProvider).selectedAddress;
    if (address == null) return;
    MarkerId id = const MarkerId('address');
    Marker marker = Marker(
      markerId: id,
      position: LatLng(address.latitude, address.longitude),
      icon: icon,
    );
    setState(() {
      markers[id] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screen = MediaQuery.of(context);
    final addressState = ref.watch(addressProvider);
    final cartResponse = ref.watch(cartProvider).cartResponse;

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
                  'Checkout',
                  style: appBarTitle,
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
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const CustomLabel('Deliver to'),
                  if (addressState.selectedAddress != null)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(211, 209, 216, 0.25),
                            offset: Offset(15, 15),
                            blurRadius: 30,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        right: 24,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    addressState.selectedAddress!.latitude,
                                    addressState.selectedAddress!.longitude,
                                  ),
                                  zoom: 16.5,
                                ),
                                myLocationEnabled: false,
                                myLocationButtonEnabled: false,
                                scrollGesturesEnabled: false,
                                zoomGesturesEnabled: false,
                                markers: Set<Marker>.from(markers.values),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 12,
                                left: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addressState.selectedAddress?.address ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.slate800,
                                      height: 1.5,
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 28,
                  ),
                  const CustomLabel(
                    'Payment Method',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(211, 209, 216, 0.25),
                          offset: Offset(15, 15),
                          blurRadius: 30,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    height: 80,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          elevation: 0,
                          showDragHandle: false,
                          builder: (context) {
                            return const PaymentModal();
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/cash.svg',
                            height: 40,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Cash',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.slate800,
                              height: 16 / 16,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/arrow_forward.svg',
                            width: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  if (cartResponse != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Subtotal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              Utils.formatCurrency(cartResponse.subtotal),
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffF1F2F3),
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'service fee',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              Utils.formatCurrency(cartResponse.serviceFee),
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffF1F2F3),
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Delivery fee',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              Utils.formatCurrency(cartResponse.deliveryFee),
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffF1F2F3),
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Total paid',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              Utils.formatCurrency(cartResponse.total),
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: screen.padding.bottom),
        height: 110,
        child: Center(
          child: CustomButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                elevation: 0,
                builder: (context) {
                  return const OrderSuccessfully();
                },
              );
            },
            text: 'Confirm',
          ),
        ),
      ),
    );
  }
}
