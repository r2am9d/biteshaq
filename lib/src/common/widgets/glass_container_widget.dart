import 'dart:ui';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:flutter/material.dart';

class GlassContainerWidget extends StatelessWidget {
  const GlassContainerWidget({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColor().primary.withOpacity(.6),
                AppColor().primary.withOpacity(.1),
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 50,
                spreadRadius: -10,
                color: AppColor().primary.withOpacity(.3),
              )
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColor().primary.withOpacity(.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
