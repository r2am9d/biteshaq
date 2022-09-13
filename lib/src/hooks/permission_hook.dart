import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

Permission usePermission() => use(const _PermissionHook());

class _PermissionHook extends Hook<Permission> {
  const _PermissionHook();

  @override
  _PermissionHookState createState() => _PermissionHookState();
}

class _PermissionHookState extends HookState<Permission, _PermissionHook> {
  // Set default values
  final Permission _permission = Permission.unknown;
  final List<Permission> _permissions = <Permission>[
    Permission.storage,
    Permission.manageExternalStorage,
    Permission.camera,
    Permission.photos,
    Permission.notification,
  ];

  void _initPermission() async {
    List<PermissionStatus> status = [];
    for (var permission in _permissions) {
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

    setState(() {});
  }

  @override
  void initHook() {
    _initPermission();
  }

  @override
  Permission build(BuildContext context) => _permission;

  @override
  void dispose() {}
}
