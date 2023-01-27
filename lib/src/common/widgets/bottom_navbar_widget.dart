import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/common/bloc/bottom_navbar/bottom_navbar_bloc.dart';

class BottomNavbarWidget extends HookWidget {
  const BottomNavbarWidget({
    super.key,
    required this.beamerDelegate,
  });

  final BeamerDelegate beamerDelegate;

  @override
  Widget build(BuildContext context) {
    final tabIndex = useMemoized(
      () => AppUtils().determineTabIndex(beamerDelegate.currentBeamLocation),
      [beamerDelegate.currentBeamLocation],
    );

    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
      builder: (context, state) {
        return AnimatedContainer(
          height: (state is BottomNavbarHidden)
              ? 0
              : kBottomNavigationBarHeight + (kBottomNavigationBarHeight / 4),
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColor().primary,
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(16.0),
            //   topRight: Radius.circular(16.0),
            // ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                SalomonBottomBar(
                  currentIndex: tabIndex,
                  onTap: (index) {
                    beamerDelegate.beamToNamed(
                      AppUtils().determineRoute(index),
                    );
                  },
                  items: <SalomonBottomBarItem>[
                    SalomonBottomBarItem(
                      title: const Text('Recipe'),
                      selectedColor: AppColor().white,
                      icon: const FaIcon(FontAwesomeIcons.lightScroll),
                      activeIcon: const FaIcon(FontAwesomeIcons.solidScroll),
                    ),
                    SalomonBottomBarItem(
                      title: const Text('Cook'),
                      selectedColor: AppColor().white,
                      icon: badges.Badge(
                        position: badges.BadgePosition.topEnd(top: -3, end: -6),
                        child: const FaIcon(FontAwesomeIcons.lightHatChef),
                      ),
                      activeIcon: const FaIcon(FontAwesomeIcons.solidHatChef),
                    ),
                    // SalomonBottomBarItem(
                    //   title: const Text('Game'),
                    //   selectedColor: AppColor().white,
                    //   icon: const FaIcon(FontAwesomeIcons.lightGamepadModern),
                    //   activeIcon:
                    //       const FaIcon(FontAwesomeIcons.solidGamepadModern),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
