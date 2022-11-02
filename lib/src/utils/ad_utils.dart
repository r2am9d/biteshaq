import 'dart:io' show Platform;

import 'package:biteshaq/src/variables/app_variables.dart';

class AdUtils {
  AdUtils._internal();

  static late String _platform;
  static final AdUtils _instance = AdUtils._internal();

  factory AdUtils() {
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
