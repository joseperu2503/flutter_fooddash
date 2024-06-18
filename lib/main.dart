import 'package:fooddash/config/constants/environment.dart';
import 'package:fooddash/config/router/app_router.dart';
import 'package:fooddash/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/features/auth/providers/auth_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  await Environment.initEnvironment();

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    ref.read(authProvider.notifier).initAutoLogout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FoodDash',
      routerConfig: appRouter,
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return LoaderOverlay(child: child!);
      },
    );
  }
}
