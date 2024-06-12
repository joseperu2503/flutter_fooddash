import 'package:delivery_app/config/router/app_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoaderService {
  static void show() {
    if (rootNavigatorKey.currentContext == null) return;
    rootNavigatorKey.currentContext?.loaderOverlay.show();
  }

  static void hide() {
    if (rootNavigatorKey.currentContext == null) return;
    rootNavigatorKey.currentContext?.loaderOverlay.hide();
  }
}
