import 'package:flutter/material.dart';

import 'package:biteshaq/src/utils/app_utils.dart';

class RecipeRatingWidget extends StatelessWidget {
  const RecipeRatingWidget({
    super.key,
    required this.rating,
    this.fontWeight = FontWeight.w700,
  });

  final double rating;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final color = AppUtils().determineColor(rating);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: color['bgColor'],
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Text(
        '$rating',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color['textColor'],
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
