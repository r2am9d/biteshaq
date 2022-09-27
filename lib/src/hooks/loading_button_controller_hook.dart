import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

LoadingButtonController useLoadingButtonController() =>
    use(const _LoadingButtonControllerHook());

class _LoadingButtonControllerHook extends Hook<LoadingButtonController> {
  const _LoadingButtonControllerHook();

  @override
  _LoadingButtonControllerHookState createState() =>
      _LoadingButtonControllerHookState();
}

class _LoadingButtonControllerHookState
    extends HookState<LoadingButtonController, _LoadingButtonControllerHook> {
  // Set default values
  final LoadingButtonController _loadingBtnCtrl = LoadingButtonController();

  @override
  void initHook() {
    super.initHook();
  }

  @override
  LoadingButtonController build(BuildContext context) => _loadingBtnCtrl;

  @override
  void deactivate() {}

  @override
  void dispose() {
    super.dispose();
  }
}
