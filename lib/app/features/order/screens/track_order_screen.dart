import 'dart:async';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:fooddash/app/features/order/providers/upcoming_order_provider.dart';
import 'package:fooddash/app/features/order/widgets/pulsating_circle.dart';
import 'package:fooddash/app/features/shared/services/location_service.dart';
import 'package:fooddash/app/features/order/widgets/bottom_modal.dart';
import 'package:fooddash/app/features/shared/providers/map_provider.dart';
import 'package:fooddash/app/features/shared/utils/utils.dart';
import 'package:fooddash/app/features/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:intl/intl.dart';

class TrackOrderScreen extends ConsumerStatefulWidget {
  const TrackOrderScreen({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  TrackOrderScreenState createState() => TrackOrderScreenState();
}

class TrackOrderScreenState extends ConsumerState<TrackOrderScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(upcomingOrdersProvider.notifier).getOrder(widget.orderId);
    });
    super.initState();
  }

  Order? order;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screen = MediaQuery.of(context);

    ref.listen(upcomingOrdersProvider, (previous, next) {
      final orders = next.orders;
      final orderIndex =
          orders.indexWhere((order) => order.id == widget.orderId);
      if (orderIndex >= 0) {
        setState(() {
          order = orders[orderIndex];
        });
      } else {
        context.pop();
      }
    });

    if (order == null) {
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbarHeightOrder,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: toolbarHeightOrder,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
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
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Estimated delivery',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.label,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const PulsatingCircle(),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${DateFormat('HH:mm a').format(order!.estimatedDelivery.min)} - ${DateFormat('HH:mm a').format(order!.estimatedDelivery.max)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.input,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                )
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
              const Expanded(
                child: _MapView(),
              ),
              Container(
                height: (minHeightBottomSheet +
                    screen.padding.bottom -
                    radiusBottomSheet),
              ),
            ],
          ),
          BottomModal(
            screen: screen,
            order: order!,
          ),
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
  late PolylineResult result;
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markers = {};
  bool showMap = false;
  LatLng house = const LatLng(0, 0);
  LatLng restaurant = const LatLng(-11.866420634086854, -77.07354500173447);
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Position? location = await LocationService.getCurrentPosition();
      if (location == null) return;

      setState(() {
        house = LatLng(
          location.latitude,
          location.longitude,
        );
      });

      ref.read(mapProvider.notifier).changeCameraPosition(LatLng(
            house.latitude,
            house.longitude,
          ));

      setState(() {
        showMap = true;
      });
      addMarkerHouse();
      addMarkerDelivery();
      addMarkerRestaurant();
      // getPolyLines();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void generatePolyLinesFromPoints() {
    PolylineId id = const PolylineId('delivery');
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColors.primary,
      points: polylineCoordinates,
      width: 4,
    );

    setState(() {
      polylines[id] = polyline;
    });

    simulateDelivery();
  }

  //añadir marker del restaurant
  addMarkerDelivery() async {
    final icon = await Utils.getBitmapDescriptorFromAssetBytes(
        'assets/images/marker_delivery.png', 100);
    if (icon != null) {
      MarkerId id = const MarkerId('delivery');
      Marker marker = Marker(
        markerId: id,
        position: LatLng(restaurant.latitude, restaurant.longitude),
        icon: icon,
      );
      setState(() {
        markers[id] = marker;
      });
    }
  }

  //añadir marker de la casa
  addMarkerHouse() async {
    final icon = await Utils.getBitmapDescriptorFromAssetBytes(
        'assets/images/marker_house.png', 150);
    if (icon != null) {
      MarkerId id = const MarkerId('house');
      Marker marker = Marker(
        markerId: id,
        position: LatLng(house.latitude, house.longitude),
        icon: icon,
      );
      setState(() {
        markers[id] = marker;
      });
    }
  }

  //añadir marker de la casa
  addMarkerRestaurant() async {
    final icon = await Utils.getBitmapDescriptorFromAssetBytes(
        'assets/images/marker_restaurant.png', 150);
    if (icon != null) {
      MarkerId id = const MarkerId('restaurant');
      Marker marker = Marker(
        markerId: id,
        position: LatLng(restaurant.latitude, restaurant.longitude),
        icon: icon,
      );
      setState(() {
        markers[id] = marker;
      });
    }
  }

  centerCamera() {
    //centrar la camara tal que se vea toda la polilinea, el marker del restaurant y el marker de la casa
    final MediaQueryData screen = MediaQuery.of(context);

    final LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
          house.latitude > restaurant.latitude
              ? restaurant.latitude
              : house.latitude,
          house.longitude > restaurant.longitude
              ? restaurant.longitude
              : house.longitude),
      northeast: LatLng(
          house.latitude > restaurant.latitude
              ? house.latitude
              : restaurant.latitude,
          house.longitude > restaurant.longitude
              ? house.longitude
              : restaurant.longitude),
    );
    ref.read(mapProvider).controller?.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, screen.size.height * 0.1));
  }

  LatLng? deliveryPosition;
  Timer? timer;

  void simulateDelivery() {
    int currentPointIndex = 0;
    const duration = Duration(seconds: 3);
    timer = Timer.periodic(duration, (Timer t) {
      if (currentPointIndex < polylineCoordinates.length) {
        setState(() {
          deliveryPosition = LatLng(
            polylineCoordinates[currentPointIndex].latitude,
            polylineCoordinates[currentPointIndex].longitude,
          );
        });
        MarkerId id = const MarkerId('delivery');
        setState(() {
          if (markers[id] != null) {
            markers[id] =
                markers[id]!.copyWith(positionParam: deliveryPosition);
          }
        });
        currentPointIndex++;
      } else {
        t.cancel(); // Detiene la simulación cuando se alcanza el último punto
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapProvider);

    if (!showMap || mapState.cameraPosition == null) return Container();
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: mapState.cameraPosition!,
        zoom: 18,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.from(markers.values),
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapProvider.notifier).setMapController(controller);
        centerCamera();
      },
    );
  }
}
