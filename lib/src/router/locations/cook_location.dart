import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/features/cook/screens/cook_screen.dart';
import 'package:biteshaq/src/features/cook/screens/cook_view_screen.dart';

class CookLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns {
    return [
      AppRouter().cookRoute,
      AppRouter().cookViewRoute,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('cook'),
        title: 'Cook',
        child: CookScreen(),
        type: BeamPageType.noTransition,
      ),
      if (state.pathPatternSegments.contains('view') &&
          state.pathParameters.containsKey('id'))
        const BeamPage(
          key: ValueKey('cook-view'),
          title: 'Cook View',
          child: CookViewScreen(),
          type: BeamPageType.slideRightTransition,
        )
    ];
  }
}
