import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class Utils {
  static String formatCurrency(double? amount) {
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en',
      symbol: '\$',
    );

    return currencyFormat.format(amount ?? 0);
  }

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }
    return null;
  }

  static Future<BitmapDescriptor?> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List? imageData = await getBytesFromAsset(path, width);
    if (imageData != null) {
      return BitmapDescriptor.fromBytes(imageData);
    }
    return null;
  }
}
