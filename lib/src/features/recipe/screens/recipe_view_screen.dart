import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/common/widgets/media_widget.dart';
import 'package:biteshaq/src/common/widgets/details_widget.dart';
import 'package:biteshaq/src/hooks/device_orientation_hook.dart';
import 'package:biteshaq/src/common/widgets/procedure_widget.dart';
import 'package:biteshaq/src/common/widgets/description_widget.dart';
import 'package:biteshaq/src/common/widgets/ingredients_widget.dart';
import 'package:biteshaq/src/hooks/scroll_controller_hook.dart' as sch;
import 'package:biteshaq/src/hooks/loading_button_controller_hook.dart';
import 'package:biteshaq/src/hooks/youtube_player_controller_hook.dart';
import 'package:biteshaq/src/common/widgets/sliver_appbar_carousel_widget.dart';

class RecipeViewScreen extends HookWidget {
  const RecipeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    useDeviceOrientation();
    final scrollCtrl = sch.useScrollController();

    final cookBtnCtrl = useLoadingButtonController();
    final favoriteBtnCtrl = useLoadingButtonController();

    /// https://www.youtube.com/watch?v=Ix5Dnud1bl0
    final youtubePlayerCtrl =
        useYoutubePlayerController(videoId: 'Ix5Dnud1bl0');

    const description =
        'Basic Filipino Pork Adobo with Soy Sauce, Vinegar, and Garlic. This delicious dish is perfect when served over newly cooked white rice.';

    const details = {
      'course': 'main',
      'country_code': 'ph',
      'cuisine': 'filipino',
      'chef': 'cardo dalisay',
      'badges': [],
      'prep_time': '10 mins',
      'cook_time': '1 hr',
      'total_time': '1 hr & 10 mins',
      'servings': '4',
      'calories': '1211 kcal'
    };

    const ingredients = [
      '2 lbs pork belly',
      '2 tablespoons garlic minced or crushed',
      '5 dried bay leaves',
      '4 tablespoons vinegar',
      '1/2 cup soy sauce',
      '1 tablespoon peppercorn',
      '2 cups water',
      'Salt to taste',
    ];

    const procedure = [
      'Combine the pork belly, soy sauce, and garlic then marinade for at least 1 hour.',
      'Heat the pot and put-in the marinated pork belly then cook for a few minutes.',
      'Pour remaining marinade including garlic.',
      'Add water, whole peppercorn, and dried bay leaves then bring to a boil. Simmer for 40 minutes to 1 hour.',
      'Put-in the vinegar and simmer for 12 to 15 minutes.',
      'Add salt to taste.',
      'Serve hot. Share and enjoy!',
    ];

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: youtubePlayerCtrl,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColor().primary,
      ),
      builder: (BuildContext context, Widget player) {
        return Scaffold(
          backgroundColor: AppColor().primaryLight20,
          body: CustomScrollView(
            controller: scrollCtrl,
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
                flexibleSpace: const SliverAppbarCarouselWidget(),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  primary: false,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      /// Description
                      const DescriptionWidget(description: description),

                      const SizedBox(height: 24),

                      /// Details
                      const DetailsWidget(details: details),

                      const SizedBox(height: 24),

                      /// Ingredients
                      const IngredientsWidget(ingredients: ingredients),

                      const SizedBox(height: 24),

                      /// Procedure
                      const ProcedureWidget(procedure: procedure),

                      const SizedBox(height: 24),

                      /// Media
                      MediaWidget(player: player),
                    ],
                  ),
                ),

                /// For testing
                // child: ListView.separated(
                //   itemCount: 24,
                //   primary: false,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) => const Text('RecipeViewScreen'),
                //   separatorBuilder: (context, index) => const Divider(),
                // ),
              ),
            ],
          ),
          persistentFooterButtons: <Widget>[
            SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: LoadingButton(
                      iconData: FontAwesomeIcons.solidHeart,
                      onPressed: () =>
                          AppUtils().btnLoadingCtrlOnPressed([favoriteBtnCtrl]),
                      controller: favoriteBtnCtrl,
                      elevation: 0,
                      primaryColor: AppColor().red,
                      child: const Text('Favorites'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 5,
                    child: LoadingButton(
                      iconData: FontAwesomeIcons.solidHatChef,
                      onPressed: () =>
                          AppUtils().btnLoadingCtrlOnPressed([cookBtnCtrl]),
                      controller: cookBtnCtrl,
                      elevation: 0,
                      primaryColor: AppColor().secondary,
                      child: const Text('Cook'),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
