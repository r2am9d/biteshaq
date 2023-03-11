import 'package:flutter/material.dart';
import 'package:animated_shimmer/animated_shimmer.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class RecipeLoadingScreen extends StatelessWidget {
  const RecipeLoadingScreen({super.key});

  static const int itemCount = 8;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: itemCount,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (BuildContext gridviewContext, int index) {
        return Card(
          elevation: 0,
          color: AppColor().shimmerEnd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: kToolbarHeight,
                      maxHeight: kToolbarHeight,
                      minWidth: double.infinity,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColor().shimmerEndDark,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                const SizedBox(height: 8.0),
                                Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    AnimatedShimmer.round(
                                      size: 14,
                                      startColor: AppColor().shimmerStart,
                                      endColor: AppColor().shimmerEnd,
                                    ),
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
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            flex: 3,
                            child: AnimatedShimmer(
                              height: kToolbarHeight / 2,
                              width: double.infinity,
                              startColor: AppColor().shimmerStart,
                              endColor: AppColor().shimmerEnd,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
