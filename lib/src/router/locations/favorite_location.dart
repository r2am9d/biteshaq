import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/features/favorite/screens/favorite_screen.dart';
// import 'package:biteshaq/src/features/favorite/screens/favorite_view_screen.dart';

class FavoriteLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns {
    return [
      AppRouter().favoriteRoute,
      // AppRouter().favoriteViewRoute,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('favorite'),
        title: 'Favorite',
        child: FavoriteScreen(),
        type: BeamPageType.noTransition,
      ),
      // if (state.pathPatternSegments.contains('view') &&
      //     state.pathParameters.containsKey('id'))
      //   const BeamPage(
      //     key: ValueKey('favorite-view'),
      //     title: 'Favorite View',
      //     child: FavoriteViewScreen(),
      //     type: BeamPageType.slideRightTransition,
      //   )
    ];
  }
}
