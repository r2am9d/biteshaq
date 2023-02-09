// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.description});

  final String description;

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
              Text(
                'Description',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColor().primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Content
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColor().black,
            ),
          ),
        ],
      ),
    );
  }
}
