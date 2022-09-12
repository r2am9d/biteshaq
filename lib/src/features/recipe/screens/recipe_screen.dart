import 'package:flag/flag.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/common/widgets/failure_widget.dart';
import 'package:biteshaq/src/common/widgets/loading_widget.dart';
import 'package:biteshaq/src/common/widgets/recipe_rating_widget.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: kToolbarHeight,
        onRefresh: () async => Future<void>.delayed(const Duration(seconds: 3)),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollBehavior:
              ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              floating: true,
              title: const Text('Recipe'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  splashRadius: 24,
                  icon: const FaIcon(FontAwesomeIcons.lightMagnifyingGlass),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  splashRadius: 24,
                  icon: const FaIcon(FontAwesomeIcons.lightFilter),
                ),
                const SizedBox(width: 10),
              ],
            ),
            SliverToBoxAdapter(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: 20,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _RecipeCard(
                    title: 'Recipe ${index + 1}',
                    recipeScreenContext: context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.recipeScreenContext,
  });

  final String title;
  final BuildContext recipeScreenContext;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
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
            CachedNetworkImage(
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
            Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 80,
                  minWidth: double.infinity,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColor().black.withOpacity(.35),
                    backgroundBlendMode: BlendMode.overlay,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Special Grilled Chicken',
                                style: TextStyle(
                                  color: AppColor().white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Wrap(
                                spacing: 4.0,
                                runSpacing: 4.0,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  Flag.fromCode(
                                    FlagsCode.PH,
                                    height: 12.0,
                                    width: 12.0,
                                    borderRadius: 6.0,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    'Chef Cardo',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: AppColor().white,
                                    ),
                                  ),
                                  FaIcon(
                                    size: 8.0,
                                    color: AppColor().green,
                                    FontAwesomeIcons.solidShieldCheck,
                                  ),
                                  FaIcon(
                                    size: 8.0,
                                    color: AppColor().yellow,
                                    FontAwesomeIcons.solidGem,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 3,
                        child: RecipeRatingWidget(
                          rating: AppUtils().randomizeRating(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    recipeScreenContext
                        .beamToNamed(AppRouter().recipeViewRoute);
                  },
                  onDoubleTap: () {},
                  splashColor: AppColor().primary.withOpacity(0.15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
