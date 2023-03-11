// ignore_for_file: avoid_unnecessary_containers

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/utils/app_util.dart';
import 'package:biteshaq/src/themes/app_color.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Header
          Text(
            'Details',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColor().primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          /// Course
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidBellConcierge,
              ),
              const SizedBox(width: 8),
              Text(
                'Course:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppUtil().capitalizeFirst(details['course'] as String),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Cuisine
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidBowlHot,
              ),
              const SizedBox(width: 8),
              Text(
                'Cuisine:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Flag.fromCode(
                FlagsCode.PH,
                height: 12,
                width: 12,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 8),
              Text(
                AppUtil().capitalizeFirst(details['cuisine'] as String),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Chef
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidHatChef,
              ),
              const SizedBox(width: 8),
              Text(
                'Chef:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    AppUtil().capitalizeFirst(details['chef'] as String),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColor().black,
                    ),
                  ),
                  FaIcon(
                    size: 12,
                    color: AppColor().green,
                    FontAwesomeIcons.solidShieldCheck,
                  ),
                  FaIcon(
                    size: 12,
                    color: AppColor().yellow,
                    FontAwesomeIcons.solidGem,
                  ),
                ],
              ),
            ],
          ),

          Divider(color: AppColor().primary),

          /// Prep Time
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidKnifeKitchen,
              ),
              const SizedBox(width: 8),
              Text(
                'Prep Time:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                details['prep_time'] as String,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Cook Time
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidCauldron,
              ),
              const SizedBox(width: 8),
              Text(
                'Cook Time:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                details['cook_time'] as String,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Total Time
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidHourglass,
              ),
              const SizedBox(width: 8),
              Text(
                'Total Time:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                details['total_time'] as String,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          Divider(color: AppColor().primary),

          /// Servings
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidUtensils,
              ),
              const SizedBox(width: 8),
              Text(
                'Servings:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                details['servings'] as String,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Calories
          Row(
            children: <Widget>[
              FaIcon(
                size: 18,
                color: AppColor().secondary,
                FontAwesomeIcons.solidFireFlameCurved,
              ),
              const SizedBox(width: 8),
              Text(
                'Calories:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                details['calories'] as String,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
