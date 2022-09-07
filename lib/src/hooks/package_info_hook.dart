import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';

PackageInfo usePackageInfo() => use(const _PackageInfoHook());

class _PackageInfoHook extends Hook<PackageInfo> {
  const _PackageInfoHook();

  @override
  _PackageInfoHookState createState() => _PackageInfoHookState();
}

class _PackageInfoHookState extends HookState<PackageInfo, _PackageInfoHook> {
  // Set default values
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Biteshaq',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initHook() {
    _initPackageInfo();
  }

  @override
  PackageInfo build(BuildContext context) => _packageInfo;

  @override
  void dispose() {}
}
