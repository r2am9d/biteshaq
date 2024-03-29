import 'dart:math';

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/common/widgets/failure_widget.dart';
import 'package:biteshaq/src/common/widgets/loading_widget.dart';
import 'package:biteshaq/src/common/widgets/recipe_rating_widget.dart';

class SliverAppbarCarouselWidget extends StatelessWidget {
  const SliverAppbarCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (0.35 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 0.35);
        final start = max(0.0, 0.35 - kToolbarHeight / deltaExtent);
        const end = 0.35;
        final reference =
            0.35 - Interval(start, end).transform(t).clamp(0, 0.35);

        return FlexibleSpaceBar(
          stretchModes: const <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.fadeTitle
          ],
          titlePadding: const EdgeInsets.only(),
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: kToolbarHeight,
              maxHeight: kToolbarHeight + 4.0,
              minWidth: double.infinity,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: AppColor().black.withOpacity(reference),
                backgroundBlendMode: BlendMode.overlay,
              ),
              child: Row(
                children: <Widget>[
                  if (reference == 0) ...[
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: 'https://baconmockup.com/640/230',
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            radius: 16,
                            backgroundImage: imageProvider,
                          );
                        },
                        placeholder: (context, url) => const LoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const FailureWidget(),
                      ),
                    ),
                  ],
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: (reference == 0)
                          ? const EdgeInsets.only(left: 16.0)
                          : const EdgeInsets.only(),
                      child: const Text(
                        'Pork Adobo',
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: RecipeRatingWidget(
                      rating: 5.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          background: Swiper(
            loop: false,
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: 'https://baconmockup.com/640/230',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => const LoadingWidget(),
                errorWidget: (context, url, error) => const FailureWidget(),
              );
            },
            itemCount: 10,
            autoplayDelay: 7500,
            pagination: const SwiperPagination(
              alignment: Alignment.topCenter,
              builder: SwiperPagination.fraction,
            ),
            control: SwiperControl(
              color: AppColor().primary,
              iconNext: FontAwesomeIcons.solidCaretRight,
              iconPrevious: FontAwesomeIcons.solidCaretLeft,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
            ),
          ),
        );
      },
    );
  }
}
