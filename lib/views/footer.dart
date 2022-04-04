import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/utils/theme.dart';

const kFootHeight = 64.0;

class Footer extends HookConsumerWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: context.colorScheme.background,
      elevation: 10,
      child: SizedBox(
        height: kFootHeight,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                PlayingItem(),
                PlayingOperations(),
              ],
            ),
            const PlayingController(),
            const PlayingStatus(),
          ],
        ),
      ),
    );
  }
}

class PlayingItem extends ConsumerWidget {
  const PlayingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          const SizedBox(width: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.green,
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Song Name', style: context.textTheme.titleMedium),
              Text('Author', style: context.textTheme.subtitle2)
            ],
          ),
          const SizedBox(width: 8),
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class PlayingOperations extends ConsumerWidget {
  const PlayingOperations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(Icons.shuffle),
        ),
        const VolumeController(),
        IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(Icons.playlist_play),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}

class VolumeController extends HookConsumerWidget {
  const VolumeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewSlider = useState(false);
    return Row(
      children: [
        IconButton(
          splashRadius: 20,
          onPressed: () {
            viewSlider.value = !viewSlider.value;
          },
          icon: const Icon(Icons.volume_up),
        ),
        if (viewSlider.value)
          SizedBox(
            width: 150,
            child: SliderTheme(
              data: const SliderThemeData(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
              ),
              child: Slider(
                max: 100.0,
                min: 0.0,
                value: 10.0,
                onChanged: (v) {},
              ),
            ),
          )
      ],
    );
  }
}

class PlayingController extends ConsumerWidget {
  const PlayingController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(Icons.skip_previous),
        ),
        IconButton(
          iconSize: 42,
          onPressed: () {},
          icon: const Icon(Icons.play_arrow),
        ),
        IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(Icons.skip_next),
        ),
      ],
    );
  }
}

class PlayingStatus extends HookConsumerWidget {
  const PlayingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = useState(0.0);
    return SizedBox(
      height: 10,
      child: FractionalTranslation(
        translation: const Offset(0, -0.5),
        child: SliderTheme(
          data: const SliderThemeData(
            trackHeight: 2,
            trackShape: RectangularSliderTrackShape(),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
          ),
          child: Slider(
            min: 0.0,
            max: 1.0,
            value: status.value,
            onChanged: (value) {
              status.value = value;
            },
          ),
        ),
      ),
    );
  }
}
