import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/hooks/permission_hook.dart';
import 'package:biteshaq/src/hooks/package_info_hook.dart';
import 'package:biteshaq/src/common/widgets/app_ad_widget.dart';
import 'package:biteshaq/src/hooks/firebase_messaging_hook.dart';
import 'package:biteshaq/src/common/bloc/appbar/appbar_bloc.dart';
import 'package:biteshaq/src/router/locations/cook_location.dart';
import 'package:biteshaq/src/router/locations/game_location.dart';
import 'package:biteshaq/src/router/locations/recipe_location.dart';
import 'package:biteshaq/src/common/bloc/network/network_bloc.dart';
import 'package:biteshaq/src/common/widgets/app_drawer_widget.dart';
import 'package:biteshaq/src/common/widgets/bottom_navbar_widget.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    usePermission();
    useFirebaseMessaging();
    final packageInfo = usePackageInfo();

    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (BuildContext networkContext, NetworkState networkState) =>
          Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawerWidget(),
        drawerScrimColor: AppColor().primaryDark20.withOpacity(.7),
        appBar: PreferredSize(
          preferredSize: (networkState is NetworkFailure)
              ? const Size.fromHeight(kToolbarHeight * 2)
              : const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<AppbarBloc, AppbarState>(
            builder: (BuildContext appbarContext, AppbarState appbarState) {
              return Container(
                height: (appbarState is AppbarHidden) ? 0 : null,
                color: AppColor().primary,
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      if (networkState is NetworkFailure)
                        Container(
                          height: kToolbarHeight,
                          color: AppColor().white,
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
                        toolbarHeight:
                            (appbarState is AppbarHidden) ? 0 : kToolbarHeight,
                        centerTitle: true,
                        title: Text(
                          packageInfo.appName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: IconButton(
                          onPressed: () =>
                              _scaffoldKey.currentState?.openDrawer(),
                          splashRadius: 24,
                          icon: const FaIcon(FontAwesomeIcons.lightForkKnife),
                        ),
                        actions: <Widget>[
                          IconButton(
                            onPressed: () {},
                            splashRadius: 24,
                            icon:
                                const FaIcon(FontAwesomeIcons.lightCircleUser),
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
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
    );
  }
}
