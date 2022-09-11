import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/common/failure_widget.dart';
import 'package:biteshaq/src/common/loading_widget.dart';
import 'package:biteshaq/src/common/recipe_rating_widget.dart';

class RecipeViewScreen extends StatelessWidget {
  const RecipeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mQ = MediaQuery.of(context);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        scrollBehavior:
            ScrollConfiguration.of(context).copyWith(scrollbars: false),
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            pinned: true,
            stretch: true,
            automaticallyImplyLeading: false,
            expandedHeight: mQ.size.height * .30,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.fadeTitle
              ],
              titlePadding: const EdgeInsets.only(),
              title: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: kToolbarHeight,
                  maxHeight: kToolbarHeight + 4,
                  minWidth: double.infinity,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: AppColor().black.withOpacity(.35),
                    backgroundBlendMode: BlendMode.overlay,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 8,
                        child: Text('Special Grilled Chicken'),
                      ),
                      Expanded(
                        flex: 2,
                        child: RecipeRatingWidget(
                          rating: AppUtils().randomizeRating(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: 'https://baconmockup.com/640/360',
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
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Text('RecipeViewScreen'),
            ),
            // child: ListView.separated(
            //   itemCount: 24,
            //   primary: false,
            //   shrinkWrap: true,
            //   separatorBuilder: (context, index) => const Divider(),
            //   itemBuilder: (context, index) => const Text('RecipeViewScreen'),
            // ),
          ),
        ],
      ),
      persistentFooterButtons: const <Widget>[
        Text('RecipeViewScreen'),
      ],
    );
  }
}
