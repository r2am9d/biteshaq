import 'package:flutter/material.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor().red,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FaIcon(
              color: AppColor().white,
              FontAwesomeIcons.solidCircleExclamation,
            ),
            Text(
              'Unexpected error occured',
              style: TextStyle(
                color: AppColor().white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
