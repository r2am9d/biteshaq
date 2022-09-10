import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:biteshaq/app.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/themes/app_theme.dart';
import 'package:biteshaq/src/firebase/config/prod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColor().primary),
  );
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseAppCheck.instance.activate();
  AppTheme appTheme = await AppTheme.instance;

  runApp(App(theme: appTheme.theme));
}
