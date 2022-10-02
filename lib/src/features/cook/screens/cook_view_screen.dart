// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:flutter_tts/flutter_tts.dart';
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

import 'package:biteshaq/src/hooks/tts_hook.dart';
import 'package:biteshaq/src/constants/app_constants.dart';

class CookViewScreen extends HookWidget {
  const CookViewScreen({super.key});

  final progressBarHeight = kToolbarHeight / 10;

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    useDeviceOrientation();
    final scrollCtrl = sch.useScrollController();
    final cookBtnCtrl = useLoadingButtonController();

    /// https://www.youtube.com/watch?v=Ix5Dnud1bl0
    final youtubePlayerCtrl =
        useYoutubePlayerController(videoId: 'Ix5Dnud1bl0');

    final ttsText = useState('');
    final ttsState = useState(TtsState.initial);

    final tts = useFlutterTts(ttsState: ttsState);

    const description =
        'Basic Filipino Pork Adobo with Soy Sauce, Vinegar, and Garlic. This delicious dish is perfect when served over newly cooked white rice.';

    const details = {
      'course': 'main',
      'country_code': 'ph',
      'cuisine': 'filipino',
      'chef': 'cardo dalisay',
      'badges': [],
      'prep_time': '10 m',
      'cook_time': '1 hr',
      'total_time': '1 hr & 10 m',
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
      'Add water, whole pepper corn, and dried bay leaves then bring to a boil. Simmer for 40 minutes to 1 hour.',
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
              SliverAppBar(
                elevation: 0,
                pinned: true,
                automaticallyImplyLeading: false,
                toolbarHeight: progressBarHeight,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(),
                  title: SizedBox(
                    height: progressBarHeight,
                    child: LinearProgressIndicator(
                      value: .1,
                      color: AppColor().secondary,
                      backgroundColor: AppColor().primaryLight30,
                    ),
                  ),
                ),
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
                      const IngredientsWidget(
                        ingredients: ingredients,
                        withHeaderButton: true,
                      ),

                      const SizedBox(height: 24),

                      /// Procedure
                      const ProcedureWidget(procedure: procedure),

                      const SizedBox(height: 24),

                      /// Media
                      MediaWidget(player: player),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            foregroundColor: AppColor().white,
            onPressed: ttsState.value == TtsState.playing
                ? () => AppUtils().ttsPause([tts])
                : () async {
                    await showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColor().primaryLight20,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.0)),
                      ),
                      builder: (BuildContext bottomSheetContext) {
                        return _CookViewBottomSheet(
                          tts: tts,
                          ttsText: ttsText,
                          ttsState: ttsState,
                          bottomSheetContext: bottomSheetContext,
                          description: description,
                          ingredients:
                              AppUtils().convertListToString(ingredients),
                          procedure: AppUtils().convertListToString(procedure),
                        );
                      },
                    );
                  },
            child: ttsState.value == TtsState.playing
                ? SiriWave(
                    style: SiriWaveStyle.ios_7,
                    options: const SiriWaveOptions(
                      backgroundColor: Colors.transparent,
                    ),
                  )
                : const FaIcon(FontAwesomeIcons.solidPlayPause),
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
                    child: LoadingButton(
                      iconData: FontAwesomeIcons.solidCauldron,
                      onPressed: () {
                        AppUtils().btnLoadingCtrlOnPressed([cookBtnCtrl]);
                      },
                      controller: cookBtnCtrl,
                      elevation: 0,
                      primaryColor: AppColor().secondary,
                      child: const Text('Cook'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CookViewBottomSheet extends StatelessWidget {
  const _CookViewBottomSheet({
    required this.tts,
    required this.ttsText,
    required this.ttsState,
    required this.bottomSheetContext,
    required this.description,
    // required this.details,
    required this.ingredients,
    required this.procedure,
  });

  final FlutterTts tts;
  final ValueNotifier<String> ttsText;
  final ValueNotifier<TtsState> ttsState;
  final BuildContext bottomSheetContext;

  final String description;
  // final String details;
  final String ingredients;
  final String procedure;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mQ = MediaQuery.of(context);
    final navigator = Navigator.of(bottomSheetContext);

    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: .10,
                  color: AppColor().primary,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Play audio',
                style: theme.textTheme.headline5?.copyWith(
                  color: AppColor().secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
            // clipBehavior: Clip.hardEdge,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: mQ.size.height / 8,
                          width: double.infinity,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.solidCircleInfo,
                                      color: AppColor().primary,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Description',
                                      style:
                                          theme.textTheme.headline6?.copyWith(
                                        color: AppColor().primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        AppUtils().ttsSpeak([
                                          description,
                                          tts,
                                          ttsText,
                                          ttsState
                                        ]);
                                        navigator.pop();
                                      },
                                      splashColor:
                                          AppColor().primary.withOpacity(0.15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: mQ.size.height / 8,
                          width: double.infinity,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.solidRectangleList,
                                      color: AppColor().primary,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Details',
                                      style:
                                          theme.textTheme.headline6?.copyWith(
                                        color: AppColor().primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor:
                                          AppColor().primary.withOpacity(0.15),
                                    ),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: mQ.size.height / 8,
                          width: double.infinity,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.solidBasketShopping,
                                      color: AppColor().primary,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Ingredients',
                                      style:
                                          theme.textTheme.headline6?.copyWith(
                                        color: AppColor().primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        AppUtils().ttsSpeak([
                                          ingredients,
                                          tts,
                                          ttsText,
                                          ttsState
                                        ]);
                                        navigator.pop();
                                      },
                                      splashColor:
                                          AppColor().primary.withOpacity(0.15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: mQ.size.height / 8,
                          width: double.infinity,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.solidCauldron,
                                      color: AppColor().primary,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Procedure',
                                      style:
                                          theme.textTheme.headline6?.copyWith(
                                        color: AppColor().primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        AppUtils().ttsSpeak([
                                          procedure,
                                          tts,
                                          ttsText,
                                          ttsState
                                        ]);
                                        navigator.pop();
                                      },
                                      splashColor:
                                          AppColor().primary.withOpacity(0.15),
                                    ),
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
              ],
            ),
          ),
        )
      ],
    );
  }
}
