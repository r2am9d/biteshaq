import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/common/widgets/failure_widget.dart';
import 'package:biteshaq/src/common/widgets/loading_widget.dart';
import 'package:biteshaq/src/common/widgets/glass_container_widget.dart';

class CookScreen extends HookWidget {
  const CookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final scrollCtrl = useScrollController();

    return Scaffold(
      backgroundColor: AppColor().lightBlue,
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
            title: const Text('Cook'),
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
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index.isEven) {
                    return GlassContainerWidget(
                      height: kToolbarHeight + (kToolbarHeight / 2),
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
                              placeholder: (context, url) =>
                                  const LoadingWidget(),
                              errorWidget: (context, url, error) =>
                                  const FailureWidget(),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                              ),
                              child: Text(
                                'Pork Adobo',
                                style: theme.textTheme.headline6?.copyWith(
                                  color: AppColor().black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox(height: 8);
                },
                childCount: 20 * 5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
