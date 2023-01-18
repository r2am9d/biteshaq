import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

BeamerDelegate useBeamerDelegate({required BeamerDelegate routerDelegate}) =>
    use(_BeamerDelegateHook(routerDelegate: routerDelegate));

class _BeamerDelegateHook extends Hook<BeamerDelegate> {
  const _BeamerDelegateHook({required this.routerDelegate});

  final BeamerDelegate routerDelegate;

  @override
  _BeamerDelegateHookState createState() => _BeamerDelegateHookState();
}

class _BeamerDelegateHookState
    extends HookState<BeamerDelegate, _BeamerDelegateHook> {
  late BeamerDelegate _beamerDelegate;

  void _setStateListener() => setState(() {});

  @override
  void initHook() {
    super.initHook();
    _beamerDelegate = hook.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  BeamerDelegate build(BuildContext context) => _beamerDelegate;

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    _beamerDelegate.dispose();
    super.dispose();
  }
}
