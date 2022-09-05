import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/features/recipe/screens/recipe_screen.dart';
import 'package:biteshaq/src/features/recipe/screens/recipe_view_screen.dart';

class RecipeLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns {
    return [
      AppRouter().recipeRoute,
      AppRouter().recipeViewRoute,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('recipe'),
        title: 'Recipe',
        child: RecipeScreen(),
        type: BeamPageType.noTransition,
      ),
      if (state.pathParameters.containsKey('id'))
        const BeamPage(
          key: ValueKey('recipe-view'),
          title: 'Recipe View',
          child: RecipeViewScreen(),
          type: BeamPageType.slideRightTransition,
        ),
    ];
  }
}
