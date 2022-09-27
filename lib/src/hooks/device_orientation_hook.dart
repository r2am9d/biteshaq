import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import 'package:biteshaq/src/common/repository/appbar_repository.dart';
import 'package:biteshaq/src/common/repository/bottom_navbar_repository.dart';

void useDeviceOrientation() => use(const _DeviceOrientationHook());

class _DeviceOrientationHook extends Hook<void> {
  const _DeviceOrientationHook();

  @override
  _DeviceOrientationHookState createState() => _DeviceOrientationHookState();
}

class _DeviceOrientationHookState
    extends HookState<void, _DeviceOrientationHook> {
  // Set default values
  late StreamSubscription _streamSubs;
  final NativeDeviceOrientationCommunicator _orientationCommunicator =
      NativeDeviceOrientationCommunicator();

  void _disposeSubs() async => await _streamSubs.cancel();

  @override
  void initHook() {
    super.initHook();
    final stream = _orientationCommunicator.onOrientationChanged();
    _streamSubs = stream.listen((NativeDeviceOrientation orientation) {
      if (orientation.name.contains('portrait')) {
        AppbarRepository().toggle(isHidden: false);
        BottomNavbarRepository().toggle(isHidden: false);
      } else {
        AppbarRepository().toggle(isHidden: true);
        BottomNavbarRepository().toggle(isHidden: true);
      }
    });
  }

  @override
  void build(BuildContext context) {}

  @override
  void dispose() {
    _disposeSubs();
    super.dispose();
  }
}
