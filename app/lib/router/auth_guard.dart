import 'package:auto_route/auto_route.dart';
import 'package:citadel/router/app_router.gr.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    var currentSession = Supabase.instance.client.auth.currentSession;

    if (currentSession != null && !currentSession.isExpired) {
      if (currentSession.user.emailConfirmedAt!.isEmpty) {
        router.push(const VerificationRoute());
      }

      resolver.next();
    } else {
      router.push(const LoginRoute());
    }
  }
}
