import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:biteshaq/app.dart';
import 'package:biteshaq/src/utils/notif_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/themes/app_theme.dart';
import 'package:biteshaq/src/firebase/config/dev.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async =>
    NotifUtils().showNotification(message);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColor().primary,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotifUtils().init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseAppCheck.instance.activate();
  AppTheme appTheme = await AppTheme.instance;

  runApp(App(theme: appTheme.theme));
}
