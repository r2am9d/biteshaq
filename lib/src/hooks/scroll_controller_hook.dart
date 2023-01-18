import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:biteshaq/src/common/repository/fab_repository.dart';
import 'package:biteshaq/src/common/repository/bottom_navbar_repository.dart';

ScrollController useScrollController() => use(const _ScrollControllerHook());

class _ScrollControllerHook extends Hook<ScrollController> {
  const _ScrollControllerHook();

  @override
  _ScrollControllerHookState createState() => _ScrollControllerHookState();
}

class _ScrollControllerHookState
    extends HookState<ScrollController, _ScrollControllerHook> {
  // Set default values
  final ScrollController _scrollCtrl = ScrollController();

  void _bottomNavListener() {
    if (_scrollCtrl.position.pixels >= kTextTabBarHeight * 4) {
      BottomNavbarRepository().toggle(isHidden: true);
    } else {
      BottomNavbarRepository().toggle(isHidden: false);
    }
  }

  void _fabListener() {
    final scrollValue =
        _scrollCtrl.position.maxScrollExtent - kTextTabBarHeight * 4;

    if (_scrollCtrl.position.pixels >= scrollValue) {
      FabRepository().toggle(isHidden: true);
    } else {
      FabRepository().toggle(isHidden: false);
    }
  }

  @override
  void initHook() {
    super.initHook();
    _scrollCtrl.addListener(_bottomNavListener);
    _scrollCtrl.addListener(_fabListener);
  }

  @override
  ScrollController build(BuildContext context) => _scrollCtrl;

  @override
  void dispose() {
    BottomNavbarRepository().toggle(isHidden: false);
    FabRepository().toggle(isHidden: false);
    _scrollCtrl.removeListener(_bottomNavListener);
    _scrollCtrl.removeListener(_fabListener);
    _scrollCtrl.dispose();
    super.dispose();
  }
}
