import 'dart:async';

import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/config/constants/environment.dart';
import 'package:delivery_app/config/constants/sizes.dart';
import 'package:delivery_app/features/address/providers/address_provider.dart';
import 'package:delivery_app/features/address/services/location_service.dart';
import 'package:delivery_app/features/order/widgets/bottom_modal.dart';
import 'package:delivery_app/features/shared/providers/map_controller_provider.dart';
import 'package:delivery_app/features/shared/utils/utils.dart';
import 'package:delivery_app/features/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData screen = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: toolbarHeight,
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
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(
                child: _MapView(),
              ),
              Container(
                height: (heightBottomSheet +
                    screen.padding.bottom -
                    radiusBottomSheet),
              ),
            ],
          ),
          BottomModal(screen: screen),
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
    Future.microtask(() async {
      Position location = await LocationService.getCurrentPosition();
      setState(() {
        house = LatLng(
          location.latitude,
          location.longitude,
        );
      });

      ref.read(addressProvider.notifier).changeCameraPosition(LatLng(
            house.latitude,
            house.longitude,
          ));

      setState(() {
        showMap = true;
      });
      addMarkerHouse();
      addMarkerDelivery();
      addMarkerRestaurant();
      getPolyLines();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  getPolyLines() async {
    //obtener polylinea con la libreria flutter_polyline_points y un key de google maps
    PolylinePoints polylinePoints = PolylinePoints();
    result = await polylinePoints.getRouteBetweenCoordinates(
      Environment.googleMapsApiKey,
      PointLatLng(restaurant.latitude, restaurant.longitude),
      PointLatLng(
        house.latitude,
        house.longitude,
      ),
      travelMode: TravelMode.driving,
    );

    //mapear la polilinea en una lista de LatLng
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        setState(() {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    }
    //generar la polilinea para mostrar en el mapa
    generatePolyLinesFromPoints();
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
    ref.read(mapControllerProvider).controller?.animateCamera(
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
    final addressState = ref.watch(addressProvider);
    if (!showMap || addressState.cameraPosition == null) return Container();
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: addressState.cameraPosition!,
        zoom: 18,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.from(markers.values),
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
        centerCamera();
      },
    );
  }
}
