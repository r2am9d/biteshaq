// ignore_for_file: overridden_fields, annotate_overrides

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/common/app_ad_widget.dart';
import 'package:biteshaq/src/hooks/permission_hook.dart';
import 'package:biteshaq/src/hooks/package_info_hook.dart';
import 'package:biteshaq/src/locations/cook_location.dart';
import 'package:biteshaq/src/locations/game_location.dart';
import 'package:biteshaq/src/locations/recipe_location.dart';
import 'package:biteshaq/src/common/bottom_navbar_widget.dart';
import 'package:biteshaq/src/features/home/bloc/network_bloc.dart';

class HomeScreen extends HookWidget {
  HomeScreen({super.key});

  final GlobalKey<BeamerState> _beamerKey = GlobalKey<BeamerState>();
  final BeamerDelegate _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        RecipeLocation(),
        CookLocation(),
        GameLocation(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    usePermission();
    final packageInfo = usePackageInfo();

    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: (state is NetworkFailure)
                ? const Size.fromHeight(kToolbarHeight * 2)
                : const Size.fromHeight(kToolbarHeight),
            child: Column(
              children: <Widget>[
                if (state is NetworkFailure)
                  SizedBox(
                    height: kToolbarHeight,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            size: 16.0,
                            color: AppColor().red,
                            FontAwesomeIcons.wifiSlash,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'You are currently offline :\'(',
                            style: TextStyle(
                              color: AppColor().red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    packageInfo.appName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {},
                    splashRadius: 24,
                    icon: const FaIcon(FontAwesomeIcons.lightForkKnife),
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {},
                      splashRadius: 24,
                      icon: const FaIcon(FontAwesomeIcons.lightCircleUser),
                    ),
                    const SizedBox(width: 10),
                  ],
                )
              ],
            ),
          ),
          body: Beamer(
            key: _beamerKey,
            routerDelegate: _routerDelegate,
          ),
          // persistentFooterButtons: const <Widget>[
          //   AppAdWidget(),
          // ],
          bottomNavigationBar: BottomNavbarWidget(
            beamerKey: _beamerKey,
          ),
        ),
      ),
    );
  }
}
