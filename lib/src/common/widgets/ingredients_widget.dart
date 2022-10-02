// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({
    super.key,
    required this.ingredients,
    this.withHeaderButton = false,
  });

  final List<String> ingredients;
  final bool withHeaderButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Ingredients',
                    style: theme.textTheme.headline5?.copyWith(
                      color: AppColor().primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (withHeaderButton) ...[
                    const SizedBox(width: 8),
                    Text(
                      '[8/8]',
                      style: theme.textTheme.headline5?.copyWith(
                        color: AppColor().primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ],
              ),
              if (withHeaderButton) ...[
                ElevatedButton(
                  onPressed: () async {
                    await showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext animDialogcontext) {
                        return ClassicGeneralDialogWidget(
                          titleText: 'Title',
                          contentText: 'content',
                          onPositiveClick: () {
                            Navigator.of(animDialogcontext).pop();
                          },
                          onNegativeClick: () {
                            Navigator.of(animDialogcontext).pop();
                          },
                        );
                      },
                      curve: Curves.easeInOut,
                      animationType: DialogTransitionType.fadeScale,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: AppColor().secondary,
                  ),
                  child: const FaIcon(FontAwesomeIcons.solidBasketShopping),
                ),
              ]
            ],
          ),

          const SizedBox(height: 8),

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
