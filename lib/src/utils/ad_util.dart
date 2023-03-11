import 'dart:io' show Platform;

import 'package:biteshaq/src/variables/app_variables.dart';

class AdUtil {
  factory AdUtil() => _instance;

  AdUtil._internal() {
    if (Platform.isAndroid) {
      _platform = 'android';
    } else if (Platform.isIOS) {
      _platform = 'ios';
    }
  }

  static late String _platform;
  static final AdUtil _instance = AdUtil._internal();

  String getUnitId({
    required Environment env,
    required String unitName,
  }) =>
      ADMOB[_platform]![env.name]![unitName]!;
}
