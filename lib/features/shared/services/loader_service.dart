import 'package:fooddash/config/router/app_router.dart';

class LoaderService {
  static void show() {
    if (rootNavigatorKey.currentContext == null) return;
  }

  static void hide() {
    if (rootNavigatorKey.currentContext == null) return;
  }
}
