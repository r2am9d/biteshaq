import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

SidebarXController useSidebarController() =>
    use(const _SidebarControllerHook());

class _SidebarControllerHook extends Hook<SidebarXController> {
  const _SidebarControllerHook();

  @override
  _SidebarControllerHookState createState() => _SidebarControllerHookState();
}

class _SidebarControllerHookState
    extends HookState<SidebarXController, _SidebarControllerHook> {
  // Set default values
  late SidebarXController _sidebarCtrl;

  @override
  void initHook() {
    super.initHook();
    _sidebarCtrl = SidebarXController(extended: true, selectedIndex: 0);
  }

  @override
  SidebarXController build(BuildContext context) => _sidebarCtrl;

  @override
  void dispose() {
    _sidebarCtrl.dispose();
    super.dispose();
  }
}
