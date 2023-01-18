import 'package:flutter/material.dart';
import 'package:animated_shimmer/animated_shimmer.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class CookLoadingScreen extends StatelessWidget {
  const CookLoadingScreen({super.key});

  final int itemCount = 8;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.separated(
        itemCount: itemCount,
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
        itemBuilder: (BuildContext listviewContext, int index) {
          return Container(
            height: kToolbarHeight * 2,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColor().shimmerEnd,
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor().shimmerEndDark,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AnimatedShimmer(
                              height: 8,
                              width: 56 * 1.25,
                              startColor: AppColor().shimmerStart,
                              endColor: AppColor().shimmerEnd,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: VerticalDivider(
                                thickness: 1,
                                color: AppColor().black.withOpacity(.1),
                              ),
                            ),
                            AnimatedShimmer(
                              height: 8,
                              width: 56 - 18,
                              startColor: AppColor().shimmerStart,
                              endColor: AppColor().shimmerEnd,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                AnimatedShimmer.round(
                                  size: 14,
                                  startColor: AppColor().shimmerStart,
                                  endColor: AppColor().shimmerEnd,
                                ),
                                const SizedBox(width: 8.0),
                                AnimatedShimmer(
                                  height: 8,
                                  width: 56,
                                  startColor: AppColor().shimmerStart,
                                  endColor: AppColor().shimmerEnd,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: VerticalDivider(
                                thickness: 1,
                                color: AppColor().black.withOpacity(.1),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                AnimatedShimmer.round(
                                  size: 14,
                                  startColor: AppColor().shimmerStart,
                                  endColor: AppColor().shimmerEnd,
                                ),
                                const SizedBox(width: 8.0),
                                AnimatedShimmer(
                                  height: 8,
                                  width: 56 * 1.35,
                                  startColor: AppColor().shimmerStart,
                                  endColor: AppColor().shimmerEnd,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        AnimatedShimmer(
                          height: 6,
                          width: double.infinity,
                          startColor: AppColor().shimmerStart,
                          endColor: AppColor().shimmerEnd,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
