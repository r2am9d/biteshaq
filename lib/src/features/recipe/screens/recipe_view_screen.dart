// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/hooks/tts_hook.dart';
import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/constants/app_constants.dart';
import 'package:biteshaq/src/common/widgets/failure_widget.dart';
import 'package:biteshaq/src/common/widgets/loading_widget.dart';
import 'package:biteshaq/src/hooks/scroll_controller_hook.dart' as sch;
import 'package:biteshaq/src/common/widgets/recipe_rating_widget.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

class RecipeViewScreen extends HookWidget {
  const RecipeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mQ = MediaQuery.of(context);

    final tts = useFlutterTts();
    final ttsState = useState(TtsState.initial);
    final scrollCtrl = sch.useScrollController();

    void ttsSpeak(String text) async {
      await tts.speak(text);
      ttsState.value = TtsState.playing;
    }

    void ttsStop() async {
      await tts.stop();
      ttsState.value = TtsState.stopped;
    }

    final LoadingButtonController btnCtrl = LoadingButtonController();

    void btnOnPressed() async {
      await Future.delayed(const Duration(seconds: 1), () async {
        btnCtrl.success();
        await Future.delayed(const Duration(seconds: 1), () {
          btnCtrl.reset();
        });
      });
    }

    return Scaffold(
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
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final settings = context.dependOnInheritedWidgetOfExactType<
                    FlexibleSpaceBarSettings>();
                final deltaExtent = settings!.maxExtent - settings.minExtent;
                final t = (0.35 -
                        (settings.currentExtent - settings.minExtent) /
                            deltaExtent)
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
                                placeholder: (context, url) =>
                                    const LoadingWidget(),
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
                        errorWidget: (context, url, error) =>
                            const FailureWidget(),
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
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              primary: false,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  /// Description
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Header
                        Text(
                          'Description',
                          style: theme.textTheme.headline5?.copyWith(
                            color: AppColor().primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        /// Content
                        Text(
                          'Basic Filipino Pork Adobo with Soy Sauce, Vinegar, and Garlic. This delicious dish is perfect when served over newly cooked white rice.',
                          style: theme.textTheme.bodyText1?.copyWith(
                            color: AppColor().black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Details
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Header
                        Text(
                          'Details',
                          style: theme.textTheme.headline5?.copyWith(
                            color: AppColor().primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        /// Course
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidBellConcierge,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Course:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Main',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                          ],
                        ),

                        /// Cuisine
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidBowlHot,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Cuisine:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Flag.fromCode(
                              FlagsCode.PH,
                              height: 12.0,
                              width: 12.0,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Filipino',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                          ],
                        ),

                        /// Chef
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidHatChef,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Chef:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Cardo Dalisay',
                                  style: theme.textTheme.bodyText1?.copyWith(
                                    color: AppColor().black,
                                  ),
                                ),
                                FaIcon(
                                  size: 12.0,
                                  color: AppColor().green,
                                  FontAwesomeIcons.solidShieldCheck,
                                ),
                                FaIcon(
                                  size: 12.0,
                                  color: AppColor().yellow,
                                  FontAwesomeIcons.solidGem,
                                ),
                              ],
                            ),
                          ],
                        ),

                        Divider(color: AppColor().primary),

                        /// Prep Time
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidKnifeKitchen,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Prep Time:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '10 min',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                          ],
                        ),

                        /// Cook Time
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidCauldron,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Cook Time:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '1 hr',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                          ],
                        ),

                        /// Total Time
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidHourglass,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Total Time:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '1 hr & 10 min',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                          ],
                        ),

                        Divider(color: AppColor().primary),

                        /// Servings
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidUtensils,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Servings:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '4',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                          ],
                        ),

                        /// Calories
                        Row(
                          children: <Widget>[
                            FaIcon(
                              size: 18.0,
                              color: AppColor().secondary,
                              FontAwesomeIcons.solidFireFlameCurved,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Calories:',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '1211 kcal',
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: AppColor().black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Ingredients
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Header
                        Text(
                          'Ingredients',
                          style: theme.textTheme.headline5?.copyWith(
                            color: AppColor().primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        /// Content List
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Laborum magna ut reprehenderit reprehenderit id fugiat qui ea consequat. Eu elit aliqua laborum excepteur officia excepteur commodo labore. Labore mollit duis pariatur consectetur ullamco velit sint consequat dolore pariatur commodo eu aute adipisicing.',
                                style: theme.textTheme.bodyText1?.copyWith(
                                  color: AppColor().black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Procedure
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Header
                        Text(
                          'Procedure',
                          style: theme.textTheme.headline5?.copyWith(
                            color: AppColor().primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        /// Content List
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Est esse deserunt pariatur pariatur eiusmod id Lorem id mollit in esse. Do cupidatat proident ad eu non consectetur pariatur minim incididunt ad. Tempor enim deserunt qui veniam nisi nostrud Lorem in eiusmod. Veniam tempor esse nisi minim veniam sint excepteur esse esse deserunt et. Aliqua nulla fugiat mollit minim est ad.',
                                style: theme.textTheme.bodyText1?.copyWith(
                                  color: AppColor().black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                  onPressed: null,
                  controller: btnCtrl,
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
                  onPressed: btnOnPressed,
                  controller: btnCtrl,
                  elevation: 0,
                  primaryColor: AppColor().secondary,
                  child: const Text('Cook'),
                ),
              )
            ],
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        tooltip: 'Talk',
        backgroundColor: AppColor().primary,
        onPressed: ttsState.value.name == 'playing'
            ? () => ttsStop()
            : () => ttsSpeak(
                'Basic Filipino Pork Adobo with Soy Sauce, Vinegar, and Garlic. This delicious dish is perfect when served over newly cooked white rice.'),
        child: FaIcon(
          color: AppColor().white,
          FontAwesomeIcons.solidMicrophoneStand,
        ),
      ),
    );
  }
}
