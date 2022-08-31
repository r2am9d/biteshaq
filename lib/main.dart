import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:biteshaq/src/themes/app_theme.dart';
import 'package:biteshaq/src/utils/firebase_options.dart';
import 'package:biteshaq/src/features/home/screens/home_screen.dart';

import 'package:biteshaq/src/features/home/repositories/home_repository.dart';

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
    return RepositoryProvider(
      create: (context) => HomeRepository(),
      child: MaterialApp(
        title: 'Biteshaq',
        theme: theme,
        home: const HomeScreen(title: 'Home Page'),
      ),
    );
  }
}
