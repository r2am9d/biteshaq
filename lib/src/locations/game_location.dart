import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/features/game/screens/game_screen.dart';

class GameLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns {
    return [
      AppRouter().gameRoute,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('game'),
        title: 'Game',
        child: GameScreen(),
        type: BeamPageType.noTransition,
      ),
    ];
  }
}
