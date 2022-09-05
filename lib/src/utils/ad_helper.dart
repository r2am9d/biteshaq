import 'dart:io' show Platform;

import 'package:biteshaq/src/constants/app_constants.dart';

class AdHelper {
  AdHelper._internal();

  static late String _platform;
  static final AdHelper _instance = AdHelper._internal();

  factory AdHelper() {
    if (Platform.isAndroid) {
      _platform = 'android';
    } else if (Platform.isIOS) {
      _platform = 'ios';
    }

    return _instance;
  }

  String getUnitId({
    required Environment env,
    required String unitName,
  }) =>
      ADMOB[_platform]![env.name]![unitName]!;
}
