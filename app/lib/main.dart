import 'package:almanac/router/app_router.dart';
import 'package:almanac/supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await initializeSupabase();

  runApp(const AlmanacApp());
}

class AlmanacApp extends StatelessWidget {
  const AlmanacApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();

    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
