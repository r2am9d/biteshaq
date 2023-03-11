import 'dart:math';

import 'package:intl/intl.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/variables/app_variables.dart';
import 'package:biteshaq/src/router/locations/cook_location.dart';
import 'package:biteshaq/src/router/locations/game_location.dart';
import 'package:biteshaq/src/router/locations/recipe_location.dart';
import 'package:biteshaq/src/router/locations/favorite_location.dart';

class AppUtil {
  factory AppUtil() => _instance;

  AppUtil._internal();

  static final AppUtil _instance = AppUtil._internal();

  double randomizeRating() =>
      double.parse(((Random().nextDouble() * 4.0) + 1.0).toStringAsFixed(1));

  Map<String, Color> determineColor(double rating) {
    Map<String, Color> color = {};

    if (rating <= 2.9) {
      color = {
        'bgColor': AppColor().bronze,
        'textColor': AppColor().white,
      };
    } else if (rating >= 3 && rating <= 3.9) {
      color = {
        'bgColor': AppColor().silver,
        'textColor': AppColor().black,
      };
    } else if (rating >= 4) {
      color = {
        'bgColor': AppColor().gold,
        'textColor': AppColor().black,
      };
    }

    return color;
  }

  int determineTabIndex(
      BeamLocation<RouteInformationSerializable<dynamic>> location) {
    int ref = 0;
    switch (location.runtimeType) {
      case RecipeLocation:
        ref = 0;
        break;
      case CookLocation:
      case FavoriteLocation:
        ref = 1;
        break;
      // case GameLocation:
      //   ref = 2;
      //   break;
      default:
    }

    return ref;
  }

  String determineRoute(int tabIndex) {
    String route = '';
    switch (tabIndex) {
      case 0:
        route = AppRouter().recipeRoute;
        break;
      case 1:
        route = AppRouter().cookRoute;
        break;
      // case 2:
      //   route = AppRouter().gameRoute;
      //   break;
      default:
    }

    return route;
  }

  Future<void> ttsSpeak(List<dynamic> args) async {
    // * [text, tts, ttsText, ttsState]
    final text = args[0] as String;
    final tts = args[1] as FlutterTts;
    final ttsText = args[2] as ValueNotifier<String>;
    final ttsState = args[3] as ValueNotifier<TtsState>;

    if (ttsText.value.isEmpty) ttsText.value = text;
    if (ttsText.value != text) await tts.stop();

    ttsText.value = text;
    ttsState.value = TtsState.playing;
    await tts.speak(text);
  }

  Future<void> ttsPause(List<dynamic> args) async {
    // * [tts]
    final tts = args[0] as FlutterTts;

    await tts.pause();
  }

  Future<void> ttsStop(List<dynamic> args) async {
    // * [tts]
    final tts = args[0] as FlutterTts;

    await tts.stop();
  }

  Future<void> btnLoadingCtrlOnPressed(List<dynamic> args) async {
    // * [loadingBtnCtrl]
    final loadingBtnCtrl = args[0] as LoadingButtonController;

    try {
      // TODO: Close request properly if navigation is triggered
      await Future.delayed(const Duration(milliseconds: 500), () async {
        loadingBtnCtrl.success();
        await Future.delayed(
            const Duration(milliseconds: 500), loadingBtnCtrl.reset);
      });
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Widget Function(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) animationItemBuilder(
    Widget Function(int index) child, {
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return (BuildContext context, int index, Animation<double> animation) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: Padding(
            padding: padding,
            child: child(index),
          ),
        ),
      );
    };
  }

  String capitalizeFirst(String text) {
    final str = text.trim().split(' ');

    if (str.isEmpty) return '';
    if (str.length == 1) return toBeginningOfSentenceCase(str.first)!;
    return str.map(toBeginningOfSentenceCase).join(' ');
  }

  String convertListToString(List<String> list) => list
      .map((str) => str.endsWith('.') || str.endsWith('!') ? str : '$str.')
      .join(' ');

  String convertJsonToString(Map<String, dynamic> json) {
    final excludedKeys = ['country_code', 'badges'];

    return json.entries.fold<String>('', (acc, cur) {
      if (!excludedKeys.contains(cur.key)) {
        final key = cur.key.replaceAll('_', ' ');
        acc += ' $key. ${cur.value}.';
      }

      return acc;
    });
  }
}
