// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
                      builder: (BuildContext dialogContext) {
                        return _IngredientsListDialog(
                          dialogContext: dialogContext,
                          ingredients: ingredients,
                        );
                      },
                      axis: Axis.vertical,
                      curve: Curves.easeInOut,
                      animationType: DialogTransitionType.size,
                      duration: const Duration(milliseconds: 350),
                      barrierColor: AppColor().primaryDark20.withOpacity(.9),
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

class _IngredientsListDialog extends HookWidget {
  const _IngredientsListDialog({
    required this.dialogContext,
    required this.ingredients,
  });

  final BuildContext dialogContext;
  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(dialogContext);
    final navigator = Navigator.of(dialogContext);

    final selectedIndexes = <int>[];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: mQ.size.height * 0.75,
      ),
      child: ClassicListDialogWidget<_IngredientsListItemModel>(
        showScrollbar: true,
        titleText: 'Ingredients list',
        listType: ListType.multiSelect,
        selectedIndexes: selectedIndexes,
        activeColor: AppColor().secondary,
        dataList: List.generate(
          ingredients.length,
          (index) => _IngredientsListItemModel(
            name: ingredients[index],
            value: index,
          ),
        ),
        actions: [
          Container(
            width: mQ.size.width,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: AppColor().primary,
                    ),
                    onPressed: () {
                      // navigator.pop();
                    },
                    // icon: const FaIcon(FontAwesomeIcons.solidListCheck),
                    child: const Text('Select All'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: AppColor().secondary,
                    ),
                    onPressed: () {
                      navigator.pop();
                    },
                    // icon: const FaIcon(FontAwesomeIcons.solidCheck),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _IngredientsListItemModel {
  _IngredientsListItemModel({
    required this.name,
    required this.value,
  });

  String name;
  int value;

  @override
  String toString() => name;
}
