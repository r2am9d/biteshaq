import 'package:flutter/material.dart';
import 'package:animated_shimmer/animated_shimmer.dart';

class RecipeLoadingScreen extends StatelessWidget {
  RecipeLoadingScreen({super.key});

  final shimmerStartColor = Colors.grey[50];
  final shimmerEndColor = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: 8,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: shimmerEndColor,
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
                        color: Colors.grey[400],
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
                                  startColor: shimmerStartColor,
                                  endColor: shimmerEndColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  delayInMilliSeconds:
                                      Duration(milliseconds: index * 500),
                                ),
                                const SizedBox(height: 8.0),
                                Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    AnimatedShimmer.round(
                                      size: 14,
                                      startColor: shimmerStartColor,
                                      endColor: shimmerEndColor,
                                    ),
                                    AnimatedShimmer(
                                      height: 8,
                                      width: 56 * 1.35,
                                      startColor: shimmerStartColor,
                                      endColor: shimmerEndColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      delayInMilliSeconds:
                                          Duration(milliseconds: index * 500),
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
                              startColor: shimmerStartColor,
                              endColor: shimmerEndColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              delayInMilliSeconds:
                                  Duration(milliseconds: index * 500),
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
