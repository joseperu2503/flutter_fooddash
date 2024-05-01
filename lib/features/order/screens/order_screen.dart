import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/address/providers/address_provider.dart';
import 'package:delivery_app/features/address/services/location_service.dart';
import 'package:delivery_app/features/order/widgets/order_dish_item.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:delivery_app/features/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends ConsumerState<OrderScreen> {
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
            child: const Row(
              children: [
                CustomBackButton(),
                Spacer(),
                Text(
                  'Track Your Order',
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
      body: const Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _MapView(),
              )
            ],
          ),
          BottomModal(),
        ],
      ),
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  const _MapView();

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<_MapView> {
  @override
  void initState() {
    Future.microtask(() async {
      Position location = await LocationService.getCurrentPosition();

      ref.read(addressProvider.notifier).changeCameraPosition(LatLng(
            location.latitude,
            location.longitude,
          ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(addressProvider);
    if (addressState.cameraPosition == null) return Container();
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: addressState.cameraPosition!,
        zoom: 18,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
    );
  }
}

const double heightBottomSheet = 300;

class BottomModal extends StatelessWidget {
  const BottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screen = MediaQuery.of(context);
    final dishes = menu[0].dishes;

    final double heigh =
        (heightBottomSheet + screen.padding.bottom) / screen.size.height;
    return DraggableScrollableSheet(
      initialChildSize: heigh,
      minChildSize: heigh,
      maxChildSize: 0.7,
      snap: true,
      snapSizes: [heigh, 0.7],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(42),
              topRight: Radius.circular(42),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(63, 76, 95, 0.12),
                offset: Offset(0, -4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          height: 10,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.gray200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DeliveryInfo(),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Food on the way',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.label,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const ProgressOrder(),
                      const SizedBox(
                        height: 40,
                      ),
                      const PriceInfo(),
                      const SizedBox(
                        height: 24,
                      ),
                      const OrderId(),
                      const SizedBox(
                        height: 42,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).padding.bottom + 30,
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    final dish = dishes[index];

                    return OrderDishItem(dish: dish);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 32,
                    );
                  },
                  itemCount: dishes.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OrderId extends StatelessWidget {
  const OrderId({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 65,
          height: 65,
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(11.48),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffD3D1D8).withOpacity(0.45),
                offset: const Offset(11.48, 17.22),
                blurRadius: 22.96,
                spreadRadius: 0,
              ),
            ],
          ),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.network(
              'https://www.edigitalagency.com.au/wp-content/uploads/starbucks-logo-png.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3 Items',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.label,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Starbuck',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Text(
          '#264100',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.orange,
            height: 1,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ],
    );
  }
}

class PriceInfo extends StatefulWidget {
  const PriceInfo({super.key});

  @override
  State<PriceInfo> createState() => _PriceInfoState();
}

class _PriceInfoState extends State<PriceInfo> {
  bool _isExpanded = false;

  void _toggleHeight() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xffD3D1D8).withOpacity(0.3),
            offset: const Offset(8, 12),
            blurRadius: 22.96,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          height: _isExpanded ? 240 : 60,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: TextButton(
                  onPressed: () {
                    _toggleHeight();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 240,
                    width: MediaQuery.of(context).size.width - 48,
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  height: 1,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$25.30',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.gray800,
                                  height: 1,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$27.30',
                              style: TextStyle(
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
                        Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Tax and Fees',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$5.30',
                              style: TextStyle(
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
                        Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$1.00',
                              style: TextStyle(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressOrder extends StatelessWidget {
  const ProgressOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/order.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 1,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/pot.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 1,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/delivery.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 1,
                color: AppColors.label,
              ),
            ),
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/check.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.label,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Row(
          children: [
            SizedBox(
              width: 60,
              child: Text(
                '1:30 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: 60,
              child: Text(
                '1:40 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: 60,
              child: Text(
                '1:45 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: 60,
              child: Text(
                '2:20 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.inputBorder,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg',
              fit: BoxFit.cover,
              height: 52,
              width: 52,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alexander Jr',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'ID 213752',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.label,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffEEF0F2),
                  offset: Offset(0, 20),
                  blurRadius: 30,
                  spreadRadius: 0,
                )
              ],
            ),
            height: 40,
            width: 40,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
              ),
              child: SvgPicture.asset(
                'assets/icons/phone.svg',
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
