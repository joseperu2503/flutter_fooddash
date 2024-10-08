import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/address/providers/address_provider.dart';
import 'package:fooddash/app/features/shared/services/location_service.dart';
import 'package:fooddash/app/features/shared/providers/map_provider.dart';
import 'package:fooddash/app/features/shared/widgets/back_button.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double sizeMarker = 60;

class AddressMapScreen extends ConsumerStatefulWidget {
  const AddressMapScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends ConsumerState<AddressMapScreen> {
  @override
  Widget build(BuildContext context) {
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
                  'Address Confirmation',
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    const MapView(),
                    Center(
                      child: SizedBox(
                        width: 0,
                        height: 0,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -sizeMarker,
                              left: -sizeMarker / 2,
                              child: SvgPicture.asset(
                                'assets/icons/map_pin_solid.svg',
                                height: sizeMarker,
                                width: sizeMarker,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (heightBottomSheet +
                    screen.padding.bottom -
                    radiusBottomSheet),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            child: BottomModal(),
          ),
        ],
      ),
    );
  }
}

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends ConsumerState<MapView> {
  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapProvider);

    if (mapState.cameraPosition == null) return Container();
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: mapState.cameraPosition!,
        zoom: 18,
      ),
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onCameraMove: (position) {
        ref.read(mapProvider.notifier).changeCameraPosition(LatLng(
              position.target.latitude,
              position.target.longitude,
            ));
      },
      onCameraIdle: () {
        ref.read(addressProvider.notifier).onCameraPositionChange();
      },
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapProvider.notifier).setMapController(controller);
      },
    );
  }
}

const double heightBottomSheet = 150;
const double radiusBottomSheet = 42;

class BottomModal extends ConsumerWidget {
  const BottomModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MediaQueryData screen = MediaQuery.of(context);
    final searchAddressState = ref.watch(addressProvider);

    return Container(
      width: screen.size.width,
      height: heightBottomSheet + screen.padding.bottom,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusBottomSheet),
          topRight: Radius.circular(radiusBottomSheet),
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        searchAddressState.address.value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.label2,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      Text(
                        searchAddressState.locality.value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.label,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffD3D1D8).withOpacity(0.25),
                        offset: const Offset(0, 20),
                        blurRadius: 30,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async {
                      Position? location =
                          await LocationService.getCurrentPosition();
                      if (location == null) return;
                      ref.read(mapProvider.notifier).goToLocation(
                            location.latitude,
                            location.longitude,
                          );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      backgroundColor: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/map_pin_outlined.svg',
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.label2,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Find me',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.input,
                            height: 1,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButton(
              onPressed: () {
                context.push('/confirm-address');
              },
              text: 'Confirm address',
            )
          ],
        ),
      ),
    );
  }
}
