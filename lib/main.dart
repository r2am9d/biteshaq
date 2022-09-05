import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:biteshaq/src/themes/app_theme.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/utils/firebase_options.dart';
import 'package:biteshaq/src/features/home/bloc/network_bloc.dart';
import 'package:biteshaq/src/features/home/screens/home_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseAppCheck.instance.activate();

  AppTheme appTheme = await AppTheme.instance;
  runApp(MyApp(theme: appTheme.theme));
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.theme,
  });

  final ThemeData theme;
  final BeamerDelegate _routerDelegate = BeamerDelegate(
    initialPath: AppRouter().homeRoute,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) {
          return BlocProvider(
            create: (context) => NetworkBloc()
              ..add(const NetworkCheck())
              ..add(const NetworkObserve()),
            child: HomeScreen(),
          );
        },
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
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: _routerDelegate,
      ),
    );
  }
}
