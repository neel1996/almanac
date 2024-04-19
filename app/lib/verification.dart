import 'package:auto_route/auto_route.dart';
import 'package:citadel/router/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: Card(
                elevation: 1.5,
                child: Icon(
                  Icons.pending_actions_rounded,
                  size: 100.0,
                ),
              ),
            ),
            const Text(
              "Email verification is pending",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              width: 300,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Text(
                  "Please confirm your email using the verification link sent",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  context.router.popAndPush(const HomeRoute());
                },
                style: const ButtonStyle(
                  alignment: Alignment.center,
                ),
                child: const Text("Go Back Home"))
          ],
        ),
      ),
    );
  }
}
