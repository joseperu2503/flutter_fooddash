import 'package:fooddash/app/app.dart';
import 'package:fooddash/app/config/constants/environment.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Environment.initEnvironment();

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FoodDash',
      routerConfig: appRouter,
      theme: AppTheme.getTheme(),
      builder: (context, child) => App(
        child: child,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
