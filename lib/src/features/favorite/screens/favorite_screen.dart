import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/common/repository/bottom_navbar_repository.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            backgroundColor: AppColor().red,
          ),
          onPressed: () {
            BottomNavbarRepository().toggle(isHidden: false);
            context.beamToNamed(AppRouter().cookRoute);
          },
          label: const Text('Favorite'),
          icon: const FaIcon(FontAwesomeIcons.lightHeart),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: const FaIcon(FontAwesomeIcons.lightMagnifyingGlass),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: const FaIcon(FontAwesomeIcons.lightFilter),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Text('FavoriteScreen'),
      ),
    );
  }
}
