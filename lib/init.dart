import 'dart:async';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:notebox/utils/platform.dart';

void initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartVLC.initialize();

  if (isDesktop) {
    _initDesktop();
  }
}

void _initDesktop() async {
  await WindowManager.instance.ensureInitialized();

  const size = Size(960, 720);
  WindowManager.instance.setMinimumSize(size);
  WindowManager.instance.setTitleBarStyle(TitleBarStyle.hidden);
  scheduleMicrotask(() async {
    final size = await WindowManager.instance.getSize();
    if (size.width < size.width || size.height < size.height) {
      WindowManager.instance.setSize(size, animate: true);
    }
  });
}
