import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import 'package:biteshaq/src/common/repository/appbar_repository.dart';
import 'package:biteshaq/src/common/repository/bottom_navbar_repository.dart';

StreamController useDeviceOrientation() => use(const _DeviceOrientationHook());

class _DeviceOrientationHook extends Hook<StreamController> {
  const _DeviceOrientationHook();

  @override
  _DeviceOrientationHookState createState() => _DeviceOrientationHookState();
}

class _DeviceOrientationHookState
    extends HookState<StreamController, _DeviceOrientationHook> {
  // Set default values
  final StreamController<NativeDeviceOrientation> _streamCtrl =
      StreamController<NativeDeviceOrientation>();
  final NativeDeviceOrientationCommunicator _orientationCommunicator =
      NativeDeviceOrientationCommunicator();

  @override
  void initHook() {
    _streamCtrl.addStream(_orientationCommunicator.onOrientationChanged());
    _streamCtrl.stream.listen((NativeDeviceOrientation orientation) {
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
  StreamController build(BuildContext context) => _streamCtrl;

  @override
  void dispose() {
    _streamCtrl.close();
  }
}
