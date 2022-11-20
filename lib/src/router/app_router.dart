import 'package:beamer/beamer.dart';

import 'package:biteshaq/src/router/locations/cook_location.dart';
import 'package:biteshaq/src/router/locations/game_location.dart';
import 'package:biteshaq/src/router/locations/recipe_location.dart';
import 'package:biteshaq/src/router/locations/favorite_location.dart';

class AppRouter {
  AppRouter._internal();

  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() => _instance;

  // Named Routes
  String get homeRoute => '/';

  String get recipeRoute => '/recipe';
  String get recipeViewRoute => '/recipe/view/:id';

  String get cookRoute => '/cook';
  String get cookViewRoute => '/cook/view/:id';

  String get favoriteRoute => '/favorite';
  String get favoriteViewRoute => '/favorite/view/:id';

  String get gameRoute => '/game';
  String get gameViewRoute => '/game/view/:id';

  // Route Locations
  BeamerDelegate get routerDelegate {
    return BeamerDelegate(
      locationBuilder: BeamerLocationBuilder(
        beamLocations: [
          RecipeLocation(),
          CookLocation(),
          GameLocation(),
          FavoriteLocation(),
        ],
      ),
    );
  }
}
