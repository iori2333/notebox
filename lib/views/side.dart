import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebox/router/controller.dart';
import 'package:notebox/widgets/route_tile.dart';

class SideSplitter extends StatelessWidget {
  const SideSplitter({Key? key, required this.hint}) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Text(
          hint,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SideView extends ConsumerWidget {
  const SideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider.select((value) => value.current));
    final router = ref.read(routerProvider.notifier);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SideSplitter(hint: 'Music'),
                RouteTile(
                  icon: const Icon(Icons.star),
                  title: const Text('Discover'),
                  isActive: route.path == '/discover',
                  onTap: () => router.push('/discover'),
                ),
                RouteTile(
                  icon: const Icon(Icons.calendar_today),
                  title: const Text('Today'),
                  isActive: route.path == '/today',
                  onTap: () => router.push('/today'),
                ),
                RouteTile(
                  icon: const Icon(Icons.radio),
                  title: const Text('My FM'),
                  isActive: route.path == '/myfm',
                  onTap: () => router.push('/myfm'),
                ),
                const SideSplitter(hint: 'Favorites'),
                RouteTile(
                  icon: const Icon(Icons.favorite),
                  title: const Text('My Favorites'),
                  isActive: route.path == '/myfav',
                  onTap: () => router.push('/myfav'),
                ),
                const SideSplitter(hint: 'Playlists'),
              ],
            ),
          ),
        ),
        const Divider(),
        RouteTile(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          isActive: route.path == '/settings',
          onTap: () => router.push('/settings'),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
