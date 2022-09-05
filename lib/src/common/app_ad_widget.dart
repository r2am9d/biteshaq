import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:biteshaq/src/utils/ad_helper.dart';
import 'package:biteshaq/src/hooks/banner_ad_hook.dart';
import 'package:biteshaq/src/constants/app_constants.dart';

class AppAdWidget extends HookWidget {
  const AppAdWidget({
    super.key,
    this.env = Environment.dev,
    this.unitName = 'test_unit',
  });

  final Environment env;
  final String unitName;

  @override
  Widget build(BuildContext context) {
    final bannerAd = useBannerAd(
      adUnitId: AdHelper().getUnitId(env: env, unitName: unitName),
    );

    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: AdWidget(ad: bannerAd),
    );
  }
}
