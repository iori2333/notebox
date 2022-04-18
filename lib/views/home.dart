import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/views/footer.dart';
import 'package:notebox/views/pages/playing.dart';
import 'package:notebox/views/side.dart';
import 'package:notebox/views/header.dart';
import 'package:notebox/store/router.dart';

const kSideWidth = 275.0;

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(builder: (context, constraints) {
        return OverflowBox(
          minHeight: 480,
          maxHeight: max(constraints.maxHeight, 480),
          minWidth: 720,
          maxWidth: max(constraints.maxWidth, 720),
          child: Material(
            child: Column(
              children: const [
                Header(),
                ContentContainer(),
                Footer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ContentContainer extends ConsumerWidget {
  const ContentContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider).current;
    return Expanded(
      child: Stack(
        children: [
          const Content(),
          PlayingPage(visible: route.path == '/playing')
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          width: kSideWidth,
          child: SideView(),
        ),
        VerticalDivider(width: 0),
        Expanded(
          child: RouteView(),
        ),
      ],
    );
  }
}

class RouteView extends ConsumerWidget {
  const RouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return WillPopScope(
      child: Navigator(
        pages: List.of(router.pages),
        onPopPage: (route, result) {
          if (!router.canBack) {
            return true;
          }
          route.didPop(null);
          ref.read(routerProvider.notifier).back();
          return true;
        },
      ),
      onWillPop: () async {
        if (!router.canBack) {
          return true;
        }
        ref.read(routerProvider.notifier).back();
        return false;
      },
    );
  }
}
