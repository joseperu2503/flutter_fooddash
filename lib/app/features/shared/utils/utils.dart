import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class Utils {
  static String formatCurrency(double? amount, {bool withSymbol = true}) {
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en',
      symbol: withSymbol ? '\$' : '',
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

  static Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    String assetName, [
    Size size = const Size(24, 24),
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio =
        ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
}
