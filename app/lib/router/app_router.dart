import 'package:auto_route/auto_route.dart';
import 'package:citadel/router/auth_guard.dart';

import "app_router.gr.dart";

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard()]),
      AutoRoute(page: LoginRoute.page),
      AutoRoute(
        page: VerificationRoute.page,
      )
    ];
  }
}
