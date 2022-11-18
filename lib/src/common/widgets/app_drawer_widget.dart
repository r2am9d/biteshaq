import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/hooks/package_info_hook.dart';

class AppDrawerWidget extends HookWidget {
  AppDrawerWidget({super.key});

  final _sidebarCtrl = SidebarXController(extended: false, selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final packageInfo = usePackageInfo();

    return StreamBuilder<bool>(
      stream: _sidebarCtrl.extendStream,
      builder: (BuildContext streamContext, AsyncSnapshot<bool> snapshot) {
        return SidebarX(
          controller: _sidebarCtrl,
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
                color: _sidebarCtrl.extended
                    ? AppColor().secondary.withOpacity(0.37)
                    : AppColor().primary.withOpacity(0.37),
              ),
              color: _sidebarCtrl.extended
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
                  if (_sidebarCtrl.extended) ...[
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
              onTap: () {},
            ),
            SidebarXItem(
              label: 'Favorites',
              icon: FontAwesomeIcons.lightHeart,
              onTap: () {},
            ),
            SidebarXItem(
              label: 'Settings',
              icon: FontAwesomeIcons.lightGear,
              onTap: () {},
            ),
          ],
          footerDivider: const Divider(),
        );
      },
    );
  }
}
