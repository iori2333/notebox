import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebox/init.dart';
import 'package:notebox/app.dart';
import 'package:notebox/store/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider.notifier);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          settings.setPreference(snapshot.requireData);
          return const NoteBoxApp();
        } else {
          return Container();
        }
      },
    );
  }
}
