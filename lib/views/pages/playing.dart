import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/utils/theme.dart';
import 'package:notebox/widgets/image.dart';

class PlayingPage extends HookWidget {
  const PlayingPage({Key? key, required this.visible}) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: visible ? 1 : 0,
    );

    useEffect(() {
      if (visible) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return null;
    }, [visible]);

    final animation = useMemoized(() {
      return Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ));
    }, [controller]);

    final offset = useAnimation(animation);

    return FractionalTranslation(
      translation: offset,
      child: const _Playing(),
    );
  }
}

class _Playing extends ConsumerWidget {
  const _Playing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: context.theme.backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Flexible(
            flex: 4,
            child: AlbumOperation(),
          ),
          VerticalDivider(width: 0),
          Flexible(
            flex: 3,
            child: Center(
              child: Text('right'),
            ),
          ),
        ],
      ),
    );
  }
}

class AlbumOperation extends ConsumerWidget {
  const AlbumOperation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = min(MediaQuery.of(context).size.width / 3.5, 300.0);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageContainer(
            width: size,
            height: size,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {},
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
