// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({super.key, required this.ingredients});

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Header
          Text(
            'Ingredients',
            style: theme.textTheme.headline5?.copyWith(
              color: AppColor().primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Ingredients List
          for (int idx = 0; idx < ingredients.length; idx++) ...[
            Row(
              children: <Widget>[
                FaIcon(
                  size: 12.0,
                  color: AppColor().secondary,
                  FontAwesomeIcons.solidCircleSmall,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    ingredients[idx],
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: AppColor().black,
                    ),
                  ),
                ),
              ],
            ),
            if (idx != ingredients.length - 1) const SizedBox(height: 8.0),
          ],
        ],
      ),
    );
  }
}
