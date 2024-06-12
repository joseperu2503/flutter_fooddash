import 'package:delivery_app/config/constants/environment.dart';
import 'package:delivery_app/config/router/app_router.dart';
import 'package:delivery_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  await Environment.initEnvironment();

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return LoaderOverlay(child: child!);
      },
    );
  }
}
