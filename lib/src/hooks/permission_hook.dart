import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

void usePermission() => use(const _PermissionHook());

class _PermissionHook extends Hook<void> {
  const _PermissionHook();

  @override
  _PermissionHookState createState() => _PermissionHookState();
}

class _PermissionHookState extends HookState<void, _PermissionHook> {
  // Set default values
  final List<Permission> _permissions = <Permission>[
    Permission.storage,
    Permission.manageExternalStorage,
    Permission.camera,
    Permission.photos,
    Permission.notification,
  ];

  Future<void> _initPermission() async {
    final status = <PermissionStatus>[];
    for (final permission in _permissions) {
      final state = await permission.request();
      if (state != PermissionStatus.granted) {
        status.add(state);
      }
    }

    // Force grant permission
    // if (status.contains(PermissionStatus.denied) ||
    //     status.contains(PermissionStatus.permanentlyDenied)) {
    //   openAppSettings();
    // }
  }

  @override
  Future<void> initHook() async {
    super.initHook();
    await _initPermission();
  }

  @override
  void build(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
  }
}
