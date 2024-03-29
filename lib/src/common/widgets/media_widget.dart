// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget({super.key, required this.player});

  final Widget player;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Header
          Text(
            'Media',
            style: theme.textTheme.headline5?.copyWith(
              color: AppColor().primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          /// Content
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColor().secondary,
              ),
            ),
            child: player,
          ),
        ],
      ),
    );
  }
}
