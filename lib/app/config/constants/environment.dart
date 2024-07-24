import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load();
  }

  static String baseUrl = dotenv.get('BASE_URL');
  static String mapboxUrl = dotenv.get('MAPBOX_URL');
  static String mapboxToken = dotenv.get('MAPBOX_TOKEN');
  static String googleMapsApiKey = dotenv.get('GOOGLE_MAPS_API_KEY');
  static String mpUrl = dotenv.get('MP_URL');
  static String mpPublicKey = dotenv.get('MP_PUBLIC_KEY');
}