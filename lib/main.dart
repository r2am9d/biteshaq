import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:biteshaq/src/themes/app_theme.dart';
import 'package:biteshaq/src/utils/firebase_options.dart';
import 'package:biteshaq/src/features/home/views/home.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AppTheme appTheme = await AppTheme.instance;
  runApp(MyApp(theme: appTheme.theme));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.theme,
    Key? key,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biteshaq',
      theme: theme,
      home: const Home(title: 'Home Page'),
    );
  }
}
