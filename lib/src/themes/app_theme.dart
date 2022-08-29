import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

class AppTheme {
  AppTheme._internal();

  static String? _themeString;
  static dynamic _themeJson;
  static ThemeData? _theme;
  static final AppTheme _instance = AppTheme._internal();

  static Future<AppTheme> get instance async {
    _themeString =
        await rootBundle.loadString('assets/themes/appainter_theme.json');
    _themeJson = jsonDecode(_themeString!);
    _theme = ThemeDecoder.decodeThemeData(_themeJson);

    return _instance;
  }

  ThemeData get theme => _theme!;
}
