import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/locations/cook_location.dart';
import 'package:biteshaq/src/locations/game_location.dart';
import 'package:biteshaq/src/locations/recipe_location.dart';

class BottomNavbarWidget extends StatefulWidget {
  const BottomNavbarWidget({
    super.key,
    required this.beamerKey,
  });

  final GlobalKey<BeamerState> beamerKey;

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  late BeamerDelegate _beamerDelegate;
  int _tabIndex = 0;

  void _setStateListener() => setState(() {});

  int _determineTabIndex(
    BeamLocation<RouteInformationSerializable<dynamic>> beamLocation,
  ) {
    int ref = 0;
    switch (beamLocation.runtimeType) {
      case RecipeLocation:
        ref = 0;
        break;
      case CookLocation:
        ref = 1;
        break;
      case GameLocation:
        ref = 2;
        break;
      default:
    }

    return ref;
  }

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    _tabIndex = _determineTabIndex(_beamerDelegate.currentBeamLocation);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: .2,
            color: AppColor.secondary,
          ),
        ),
      ),
      child: SalomonBottomBar(
        currentIndex: _tabIndex,
        onTap: (index) {
          String route = '';
          switch (index) {
            case 0:
              route = AppRouter.recipeRoute;
              break;
            case 1:
              route = AppRouter.cookRoute;
              break;
            case 2:
              route = AppRouter.gameRoute;
              break;
            default:
          }

          _beamerDelegate.beamToNamed(route);
        },
        items: [
          SalomonBottomBarItem(
            title: const Text('Recipe'),
            selectedColor: AppColor.secondary,
            icon: const FaIcon(FontAwesomeIcons.lightScroll),
            activeIcon: const FaIcon(FontAwesomeIcons.solidScroll),
          ),
          SalomonBottomBarItem(
            title: const Text('Cook'),
            selectedColor: AppColor.secondary,
            icon: const FaIcon(FontAwesomeIcons.lightHatChef),
            activeIcon: const FaIcon(FontAwesomeIcons.solidHatChef),
          ),
          SalomonBottomBarItem(
            title: const Text('Game'),
            selectedColor: AppColor.secondary,
            icon: const FaIcon(FontAwesomeIcons.lightGamepadModern),
            activeIcon: const FaIcon(FontAwesomeIcons.solidGamepadModern),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}