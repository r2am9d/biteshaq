import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/hooks/package_info_hook.dart';
import 'package:biteshaq/src/common/repository/bottom_navbar_repository.dart';

class AppDrawerWidget extends HookWidget {
  const AppDrawerWidget({
    super.key,
    required this.beamerDelegate,
    required this.sidebarController,
  });

  final BeamerDelegate beamerDelegate;
  final SidebarXController sidebarController;

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final packageInfo = usePackageInfo();
    final scaffold = Scaffold.of(context);

    return StreamBuilder<bool>(
      stream: sidebarController.extendStream,
      builder: (BuildContext streamContext, AsyncSnapshot<bool> snapshot) {
        return SidebarX(
          controller: sidebarController,
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor().secondary,
              borderRadius: BorderRadius.circular(16.0),
            ),
            hoverColor: AppColor().primary,
            textStyle: TextStyle(
              color: AppColor().white.withOpacity(0.7),
            ),
            iconTheme: IconThemeData(
              size: 20,
              color: AppColor().white.withOpacity(0.7),
            ),
            itemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: AppColor().primary,
              ),
            ),
            itemTextPadding: const EdgeInsets.only(left: 18.0),
            selectedItemTextPadding: const EdgeInsets.only(left: 18.0),
            selectedTextStyle: TextStyle(color: AppColor().white),
            selectedIconTheme: IconThemeData(
              size: 20.0,
              color: AppColor().white,
            ),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: sidebarController.extended
                    ? AppColor().secondary.withOpacity(0.37)
                    : AppColor().primary.withOpacity(0.37),
              ),
              color: sidebarController.extended
                  ? AppColor().secondary
                  : AppColor().primary,
              boxShadow: [
                BoxShadow(
                  blurRadius: 30.0,
                  color: AppColor().black.withOpacity(0.28),
                )
              ],
            ),
          ),
          extendedTheme: SidebarXTheme(
            width: mQ.size.width * .45,
            decoration: BoxDecoration(
              color: AppColor().primary,
            ),
          ),
          headerBuilder: (BuildContext context, bool extended) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset('assets/logos/logo_1024.png'),
                  if (sidebarController.extended) ...[
                    Text(
                      packageInfo.appName,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColor().white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          items: [
            SidebarXItem(
              label: 'Home',
              icon: FontAwesomeIcons.lightHome,
              onTap: () {
                beamerDelegate.beamToNamed(AppRouter().recipeRoute);
                BottomNavbarRepository().toggle(isHidden: false);
                scaffold.closeDrawer();
              },
            ),
            SidebarXItem(
              label: 'Favorites',
              icon: FontAwesomeIcons.lightHeart,
              onTap: () {
                beamerDelegate.beamToNamed(AppRouter().favoriteRoute);
                BottomNavbarRepository().toggle(isHidden: true);
                scaffold.closeDrawer();
              },
            ),
            SidebarXItem(
              label: 'Settings',
              icon: FontAwesomeIcons.lightGear,
              onTap: () {
                scaffold.closeDrawer();
              },
            ),
          ],
          footerDivider: const Divider(),
        );
      },
    );
  }
}
