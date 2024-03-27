import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text('Login Screen'),
                  ),
                  const SizedBox(
                    height: 400,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(authProvider.notifier)
                          .setAuthStatus(AuthStatus.authenticated);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
