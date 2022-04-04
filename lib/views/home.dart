import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/views/footer.dart';
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
          minHeight: 640,
          maxHeight: max(constraints.maxHeight, 640),
          minWidth: 800,
          maxWidth: max(constraints.maxWidth, 800),
          child: Material(
            child: Column(
              children: const [
                Header(),
                Content(),
                Footer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
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
      ),
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
