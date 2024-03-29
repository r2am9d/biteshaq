import 'package:flutter/material.dart';

class AppColor {
  AppColor._internal();

  static final AppColor _instance = AppColor._internal();

  factory AppColor() => _instance;

  Color get primary => const Color(0xFF246c8a);
  Color get secondary => const Color(0xFF8a4324); // 93571f
  Color get primaryColorLight => const Color(0xFFBBDEFB);
  Color get primaryColorDark => const Color(0xFF1976D2);
  Color get backgroundColor => const Color(0xFFFCFBFD);
  Color get bottomAppBarColor => const Color(0xFFFEFFFF);
  Color get canvasColor => const Color(0xFFFCFBFD);
  Color get cardColor => const Color(0xFFFEFFFF);
  Color get dialogBackgroundColor => const Color(0xFFFCFBFD);
  Color get disabledColor => const Color(0xFF000000);
  Color get dividerColor => const Color(0xFF000000);
  Color get errorColor => const Color(0xFFB00020);
  Color get focusColor => const Color(0xFF000000);
  Color get highlightColor => const Color(0xFFBCBCBC);
  Color get hintColor => const Color(0xFF000000);
  Color get hoverColor => const Color(0xFF000000);
  Color get indicatorColor => const Color(0xFFFFFFFF);
  Color get scaffoldBackgroundColor => const Color(0xFFFCFBFD);
  Color get secondaryHeaderColor => const Color(0xFFE3F2FD);
  Color get selectedRowColor => const Color(0xFFF5F5F5);
  Color get shadowColor => const Color(0xFF000000);
  Color get splashColor => const Color(0xFFC8C8C8);
  Color get toggleableActiveColor => const Color(0xFF93571F);
  Color get unselectedWidgetColor => const Color(0xFF000000);

  Color get black => const Color(0xFF000000);
  Color get white => const Color(0xFFFFFFFF);
  Color get gray => const Color(0xFFF5F5F5);

  Color get red => const Color(0xFFC62828);
  Color get green => const Color(0xFF2E7D32);
  Color get yellow => const Color(0xFFF9A825);

  Color get gold => const Color(0xFFFFD700);
  Color get silver => const Color(0xFFC0C0C0);
  Color get bronze => const Color(0xFF967444);

  Color get mint => const Color(0xFF248a76);
  Color get blue => const Color(0xFF354ca2);

  Color get pink => const Color(0xFFdf2d86);
  Color get purple => const Color(0xFF8537ad);

  Color get primaryLight20 => const Color(0xFFF0FFFF);
  Color get primaryLight30 => const Color(0xFFD7FFFF);
  Color get primaryLight40 => const Color(0xFFBDFFFF);
  Color get primaryLight50 => const Color(0xFFA3EBFF);
  Color get primaryLight60 => const Color(0xFF8AD2F0);
  Color get primaryLight70 => const Color(0xFF71B9D7);
  Color get primaryLight80 => const Color(0xFF579FBD);
  Color get primaryLight90 => const Color(0xFF3E86A4);

  Color get primaryDark10 => const Color(0xFF0B5371);
  Color get primaryDark20 => const Color(0xFF003957);
  Color get primaryDark30 => const Color(0xFF00203E);
  Color get primaryDark40 => const Color(0xFF000624);
  Color get primaryDark50 => const Color(0xFF00000B);

  Color? get shimmerStart => Colors.grey[50];
  Color? get shimmerEnd => Colors.grey[300];
  Color? get shimmerEndDark => Colors.grey[400];
}
