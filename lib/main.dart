import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rock_weather/dependencies/service_locator.dart';
import 'package:rock_weather/shared/router/app_router.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await initializeDependencies();
      runApp(const App());
    },
    (error, stack) {
      log(error.toString());
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: AppRouter.getRouter(),
    );
  }
}
