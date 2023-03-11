import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

BannerAd useBannerAd({required String adUnitId}) =>
    use(_BannerAdHook(adUnitId: adUnitId));

class _BannerAdHook extends Hook<BannerAd> {
  const _BannerAdHook({required this.adUnitId});

  final String adUnitId;

  @override
  _BannerAdHookState createState() => _BannerAdHookState();
}

class _BannerAdHookState extends HookState<BannerAd, _BannerAdHook> {
  late BannerAd _bannerAd;
  late BannerAdListener _bannerAdListener;

  void _setStateListener() => setState(() {});

  // Ad Listeners
  void _onAddLoaded(Ad ad) => _setStateListener();
  Future<void> _onAdFailedToLoad(Ad ad, LoadAdError error) async =>
      ad.dispose();

  @override
  Future<void> initHook() async {
    super.initHook();
    _bannerAdListener = BannerAdListener(
      onAdLoaded: _onAddLoaded,
      onAdFailedToLoad: _onAdFailedToLoad,
      // onAdOpened: _onAdOpened,
    );

    _bannerAd = BannerAd(
      size: AdSize.fluid,
      adUnitId: hook.adUnitId,
      listener: _bannerAdListener,
      request: const AdRequest(),
    );

    await _bannerAd.load();
  }

  @override
  BannerAd build(BuildContext context) => _bannerAd;

  @override
  Future<void> dispose() async {
    await _bannerAd.dispose();
    super.dispose();
  }
}
