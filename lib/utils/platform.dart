import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notebox/app.dart';

bool get isDesktop =>
    Platform.isLinux || Platform.isMacOS || Platform.isWindows;

extension PlatformOpt on NoteBoxApp {
  Widget platform() {
    return FocusableActionDetector(
      child: this,
    );
  }
}
