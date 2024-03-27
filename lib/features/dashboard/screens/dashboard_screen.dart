import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Home Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(authProvider.notifier)
                  .setAuthStatus(AuthStatus.notAuthenticated);
            },
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
