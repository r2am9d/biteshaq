import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/common/bloc/appbar/appbar_bloc.dart';
import 'package:biteshaq/src/common/bloc/network/network_bloc.dart';
import 'package:biteshaq/src/features/home/screens/home_screen.dart';
import 'package:biteshaq/src/common/bloc/bottom_navbar/bottom_navbar_bloc.dart';

class App extends StatelessWidget {
  App({super.key, required this.theme});

  final ThemeData theme;
  final BeamerDelegate _routerDelegate = BeamerDelegate(
    initialPath: AppRouter().cookRoute,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NetworkBloc()
                  ..add(const NetworkCheck())
                  ..add(const NetworkObserve()),
              ),
              BlocProvider(
                create: (context) => AppbarBloc()..add(const AppbarToggle()),
              ),
              BlocProvider(
                create: (context) =>
                    BottomNavbarBloc()..add(const BottomNavbarToggle()),
              ),
            ],
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
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: _routerDelegate,
      ),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
    );
  }
}
