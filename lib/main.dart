import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:biteshaq/src/themes/app_theme.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/utils/firebase_options.dart';
import 'package:biteshaq/src/features/home/screens/home_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AppTheme appTheme = await AppTheme.instance;
  runApp(MyApp(theme: appTheme.theme));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.theme});

  final ThemeData theme;
  final BeamerDelegate _routerDelegate = BeamerDelegate(
    initialPath: AppRouter.homeRoute,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => HomeScreen(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      title: 'Biteshaq',
      routerDelegate: _routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}
