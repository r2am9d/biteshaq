import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/common/widgets/failure_widget.dart';
import 'package:biteshaq/src/common/widgets/loading_widget.dart';

class CookScreen extends HookWidget {
  const CookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollCtrl = useScrollController();

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
                  return Card(
                    child: ListTile(
                      leading: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        imageUrl: 'https://baconmockup.com/640/230',
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 50,
                            width: 50,
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
                      ),
                      title: const Text('Pork Adobo'),
                      subtitle: const Text('Chef Cardo'),
                    ),
                  );
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
