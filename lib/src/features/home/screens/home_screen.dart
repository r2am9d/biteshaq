import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/locations/recipe_location.dart';
import 'package:biteshaq/src/locations/cook_location.dart';
import 'package:biteshaq/src/locations/game_location.dart';
import 'package:biteshaq/src/common/bottom_navbar_widget.dart';

class HomeScreen extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Biteshaq'),
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
      ),
      body: Beamer(
        key: _beamerKey,
        routerDelegate: _routerDelegate,
      ),
      bottomNavigationBar: BottomNavbarWidget(
        beamerKey: _beamerKey,
      ),
    );
  }
}
