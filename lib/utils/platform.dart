import 'dart:io';

bool get isDesktop =>
    Platform.isLinux || Platform.isMacOS || Platform.isWindows;
