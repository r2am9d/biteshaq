import 'package:badges/badges.dart';
import 'package:beamer/beamer.dart';
import 'package:biteshaq/src/hooks/beamer_delegate_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/locations/cook_location.dart';
import 'package:biteshaq/src/locations/game_location.dart';
import 'package:biteshaq/src/locations/recipe_location.dart';

class BottomNavbarWidget extends HookWidget {
  const BottomNavbarWidget({
    super.key,
    required this.beamerKey,
  });

  final GlobalKey<BeamerState> beamerKey;

  @override
  Widget build(BuildContext context) {
    final beamerDelegate = useBeamerDelegate(beamerKey: beamerKey);
    final tabIndex = useMemoized(() {
      int ref = 0;
      switch (beamerDelegate.currentBeamLocation.runtimeType) {
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
    }, [beamerDelegate.currentBeamLocation]);

    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primary,
      ),
      child: SalomonBottomBar(
        currentIndex: tabIndex,
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

          beamerDelegate.beamToNamed(route);
        },
        items: [
          SalomonBottomBarItem(
            title: const Text('Recipe'),
            selectedColor: AppColor.white,
            icon: const FaIcon(FontAwesomeIcons.lightScroll),
            activeIcon: const FaIcon(FontAwesomeIcons.solidScroll),
          ),
          SalomonBottomBarItem(
            title: const Text('Cook'),
            selectedColor: AppColor.white,
            icon: Badge(
              position: BadgePosition.topEnd(top: -3, end: -6),
              child: const FaIcon(FontAwesomeIcons.lightHatChef),
            ),
            activeIcon: const FaIcon(FontAwesomeIcons.solidHatChef),
          ),
          SalomonBottomBarItem(
            title: const Text('Game'),
            selectedColor: AppColor.white,
            icon: const FaIcon(FontAwesomeIcons.lightGamepadModern),
            activeIcon: const FaIcon(FontAwesomeIcons.solidGamepadModern),
          ),
        ],
      ),
    );
  }
}
