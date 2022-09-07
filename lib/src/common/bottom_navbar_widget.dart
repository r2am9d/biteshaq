import 'package:badges/badges.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/hooks/beamer_delegate_hook.dart';

class BottomNavbarWidget extends HookWidget {
  const BottomNavbarWidget({
    super.key,
    required this.beamerKey,
  });

  final GlobalKey<BeamerState> beamerKey;

  @override
  Widget build(BuildContext context) {
    final beamerDelegate = useBeamerDelegate(beamerKey: beamerKey);
    final tabIndex = useMemoized(
      () => AppUtils().determineTabIndex(beamerDelegate.currentBeamLocation),
      [beamerDelegate.currentBeamLocation],
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColor().primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: SalomonBottomBar(
        currentIndex: tabIndex,
        onTap: (index) {
          beamerDelegate.beamToNamed(
            AppUtils().determineRoute(index),
          );
        },
        items: [
          SalomonBottomBarItem(
            title: const Text('Recipe'),
            selectedColor: AppColor().white,
            icon: const FaIcon(FontAwesomeIcons.lightScroll),
            activeIcon: const FaIcon(FontAwesomeIcons.solidScroll),
          ),
          SalomonBottomBarItem(
            title: const Text('Cook'),
            selectedColor: AppColor().white,
            icon: Badge(
              position: BadgePosition.topEnd(top: -3, end: -6),
              child: const FaIcon(FontAwesomeIcons.lightHatChef),
            ),
            activeIcon: const FaIcon(FontAwesomeIcons.solidHatChef),
          ),
          SalomonBottomBarItem(
            title: const Text('Game'),
            selectedColor: AppColor().white,
            icon: const FaIcon(FontAwesomeIcons.lightGamepadModern),
            activeIcon: const FaIcon(FontAwesomeIcons.solidGamepadModern),
          ),
        ],
      ),
    );
  }
}
