import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebox/store/settings.dart';
import 'package:notebox/utils/theme.dart';
import 'package:notebox/views/home.dart';

class NoteBoxApp extends ConsumerWidget {
  const NoteBoxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'NoteBox',
      debugShowCheckedModeBanner: false,
      home: const HomeContainer(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(settingsProvider).themeMode,
    );
  }
}
