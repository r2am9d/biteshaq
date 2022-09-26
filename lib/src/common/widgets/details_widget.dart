// ignore_for_file: avoid_unnecessary_containers

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/utils/app_utils.dart';
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
            style: theme.textTheme.headline5?.copyWith(
              color: AppColor().primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Course
          Row(
            children: <Widget>[
              FaIcon(
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidBellConcierge,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Course:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                AppUtils().capitalizeFirst(details['course']),
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          /// Cuisine
          Row(
            children: <Widget>[
              FaIcon(
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidBowlHot,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Cuisine:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Flag.fromCode(
                FlagsCode.PH,
                height: 12.0,
                width: 12.0,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 8.0),
              Text(
                AppUtils().capitalizeFirst(details['cuisine']),
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          /// Chef
          Row(
            children: <Widget>[
              FaIcon(
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidHatChef,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Chef:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    AppUtils().capitalizeFirst(details['chef']),
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: AppColor().black,
                    ),
                  ),
                  FaIcon(
                    size: 12.0,
                    color: AppColor().green,
                    FontAwesomeIcons.solidShieldCheck,
                  ),
                  FaIcon(
                    size: 12.0,
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
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidKnifeKitchen,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Prep Time:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                details['prep_time'],
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          /// Cook Time
          Row(
            children: <Widget>[
              FaIcon(
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidCauldron,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Cook Time:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                details['cook_time'],
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          /// Total Time
          Row(
            children: <Widget>[
              FaIcon(
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidHourglass,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Total Time:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                details['total_time'],
                style: theme.textTheme.bodyText1?.copyWith(
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
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidUtensils,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Servings:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                details['servings'],
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          /// Calories
          Row(
            children: <Widget>[
              FaIcon(
                size: 18.0,
                color: AppColor().secondary,
                FontAwesomeIcons.solidFireFlameCurved,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Calories:',
                style: theme.textTheme.bodyText1?.copyWith(
                  color: AppColor().black,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                details['calories'],
                style: theme.textTheme.bodyText1?.copyWith(
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
