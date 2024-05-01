import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String urlBase = dotenv.env['URL_BASE'] ?? 'No URL_BASE';
  static String urlMapbox = dotenv.env['URL_MAPBOX'] ?? 'No URL_MAPBOX';
  static String tokenMapbox = dotenv.env['TOKEN_MAPBOX'] ?? 'No TOKEN_MAPBOX';
  static String googleMapsApiKey =
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'No GOOGLE_MAPS_API_KEY';
}
