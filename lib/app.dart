import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/features/home/bloc/network_bloc.dart';
import 'package:biteshaq/src/features/home/screens/home_screen.dart';

class App extends StatelessWidget {
  App({super.key, required this.theme});

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
      routerDelegate: _routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: _routerDelegate,
      ),
    );
  }
}
