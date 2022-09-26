// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class ProcedureWidget extends StatelessWidget {
  const ProcedureWidget({super.key, required this.procedure});

  final List<String> procedure;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Header
          Text(
            'Procedure',
            style: theme.textTheme.headline5?.copyWith(
              color: AppColor().primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Procedure List
          for (int idx = 0; idx < procedure.length; idx++) ...[
            Row(
              children: <Widget>[
                Text(
                  '${idx + 1}.',
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: AppColor().secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    procedure[idx],
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: AppColor().black,
                    ),
                  ),
                ),
              ],
            ),
            if (idx != procedure.length - 1) const SizedBox(height: 8.0),
          ],
        ],
      ),
    );
  }
}
