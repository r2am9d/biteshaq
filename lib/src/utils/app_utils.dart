import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/router/locations/cook_location.dart';
import 'package:biteshaq/src/router/locations/game_location.dart';
import 'package:biteshaq/src/router/locations/recipe_location.dart';

class AppUtils {
  AppUtils._internal();

  static final AppUtils _instance = AppUtils._internal();

  factory AppUtils() => _instance;

  double randomizeRating() =>
      double.parse(((Random().nextDouble() * 4.0) + 1.0).toStringAsFixed(1));

  Map<String, Color> determineColor(rating) {
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
        ref = 1;
        break;
      case GameLocation:
        ref = 2;
        break;
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
      case 2:
        route = AppRouter().gameRoute;
        break;
      default:
    }

    return route;
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
}
