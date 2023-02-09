// ignore_for_file: avoid_unnecessary_containers

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/router/app_router.dart';
import 'package:biteshaq/src/features/cook/bloc/cook_bloc.dart';
import 'package:biteshaq/src/common/widgets/failure_widget.dart';
import 'package:biteshaq/src/common/widgets/loading_widget.dart';
import 'package:biteshaq/src/common/widgets/glass_container_widget.dart';
import 'package:biteshaq/src/features/cook/repository/cook_repository.dart';
import 'package:biteshaq/src/common/repository/bottom_navbar_repository.dart';
import 'package:biteshaq/src/features/cook/screens_state/cook_loading_screen.dart';

class CookScreen extends HookWidget {
  const CookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const itemCount = 20;
    final scrollCtrl = useScrollController();

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
            floating: true,
            title: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                backgroundColor: AppColor().secondary,
              ),
              onPressed: () {
                BottomNavbarRepository().toggle(isHidden: true);
                context.beamToNamed(AppRouter().favoriteRoute);
              },
              label: const Text('Cook'),
              icon: const FaIcon(FontAwesomeIcons.lightHatChef),
            ),
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
          BlocProvider(
            create: (context) =>
                CookBloc()..add(CookFetch(request: CookRepository().fetchCook)),
            child: BlocBuilder<CookBloc, CookState>(
              builder: (BuildContext context, CookState state) {
                if (state is CookInitial || state is CookLoading) {
                  return const SliverToBoxAdapter(child: CookLoadingScreen());
                } else if (state is CookSuccess) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: LiveSliverList(
                      itemCount: itemCount,
                      controller: scrollCtrl,
                      showItemInterval: const Duration(milliseconds: 100),
                      showItemDuration: const Duration(milliseconds: 100),
                      itemBuilder: AppUtils().animationItemBuilder(
                        (index) {
                          if (index.isEven) {
                            return _CookItem(cookScreenContext: context);
                          }

                          return SizedBox(
                            height: (index != itemCount - 1) ? 8 : 0,
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}

class _CookItem extends StatelessWidget {
  const _CookItem({
    required this.cookScreenContext,
  });

  final BuildContext cookScreenContext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(cookScreenContext);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          GlassContainerWidget(
            height: kToolbarHeight * 2,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
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
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Pork Adobo',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: AppColor().black,
                                  fontWeight: FontWeight.bold,
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
                              Text(
                                '4D ago',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColor().secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      size: 16.0,
                                      color: AppColor().secondary,
                                      FontAwesomeIcons.solidBasketShopping,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      '1/8',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: AppColor().black,
                                      ),
                                    ),
                                  ],
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
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      size: 16.0,
                                      color: AppColor().secondary,
                                      FontAwesomeIcons.solidTimer,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      '1hr & 10m',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: AppColor().black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          LinearProgressIndicator(
                            value: .1,
                            color: AppColor().secondary,
                            backgroundColor: AppColor().primaryLight30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  cookScreenContext.beamToNamed(AppRouter().cookViewRoute);
                },
                onDoubleTap: () {},
                splashColor: AppColor().primary.withOpacity(0.15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
