import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/features/auth/providers/auth_provider.dart';

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  @override
  void initState() {
    ref.read(authProvider.notifier).initAutoLogout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child == null) return Container();

    return widget.child!;
  }
}
