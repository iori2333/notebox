import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/init.dart';
import 'package:notebox/app.dart';
import 'package:notebox/store/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notebox/utils/platform.dart';

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
          return const NoteBoxApp().platform();
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
      },
    );
  }
}
