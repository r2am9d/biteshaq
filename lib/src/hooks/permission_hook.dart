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

  Future<void> _initPermission() async {
    final permissions = [
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.camera,
      Permission.photos,
      Permission.notification,
    ];

    bool f = true;
    List<bool> status = [];
    for (var permission in permissions) {
      final state = await permission.request();
      if (!f || state != PermissionStatus.granted) {
        f = false;
      }
      status.add(f);
    }
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
