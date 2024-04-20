import 'package:auto_route/auto_route.dart';
import 'package:almanac/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login to almanac",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 26.0,
              ),
            ),
            SizedBox(
              width: 350,
              child: SupaEmailAuth(
                onSignInComplete: (AuthResponse response) {
                  context.router.popAndPush(const HomeRoute());
                },
                onSignUpComplete: (AuthResponse response) {
                  context.router.popAndPush(const HomeRoute());
                },
                onError: (error) {
                  SnackBar(content: Text(error.toString()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
