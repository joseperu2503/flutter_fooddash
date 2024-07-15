import 'package:fooddash/app/config/router/app_router.dart';
import 'package:flutter/material.dart';

enum SnackbarType { info, success, error, floating }

class SnackbarService {
  static void showSnackbar(
    String message, {
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    if (rootNavigatorKey.currentContext == null) return;
    ScaffoldMessenger.of(rootNavigatorKey.currentContext!)
        .hideCurrentSnackBar();
    ScaffoldMessenger.of(rootNavigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: Colors.black54,
      duration: duration,
    ));
  }
}
