import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

class AppTheme {
  AppTheme._internal();

  static Future<AppTheme> get instance async {
    _themeString =
        await rootBundle.loadString('assets/themes/appainter_theme.json');
    _theme = ThemeDecoder.decodeThemeData(jsonDecode(_themeString))!;

    return _instance;
  }

  static late String _themeString;
  static late ThemeData _theme;
  static final AppTheme _instance = AppTheme._internal();

  ThemeData get theme => _theme;
}
