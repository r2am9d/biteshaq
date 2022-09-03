import 'dart:math';

import 'package:flutter/material.dart';
import 'package:biteshaq/src/themes/app_color.dart';

class AppUtils {
  static double randomizeRating() =>
      double.parse(((Random().nextDouble() * 4.0) + 1.0).toStringAsFixed(1));

  static Map<String, Color> determineColor(rating) {
    Map<String, Color> color = {};

    if (rating <= 2.9) {
      color = {
        'bgColor': AppColor.bronze,
        'textColor': AppColor.white,
      };
    } else if (rating >= 3 && rating <= 3.9) {
      color = {
        'bgColor': AppColor.silver,
        'textColor': AppColor.black,
      };
    } else if (rating >= 4) {
      color = {
        'bgColor': AppColor.gold,
        'textColor': AppColor.black,
      };
    }

    return color;
  }
}
