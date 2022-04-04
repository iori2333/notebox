import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebox/router/controller.dart';
import 'package:notebox/utils/platform.dart';
import 'package:notebox/utils/theme.dart';
import 'package:notebox/widgets/avatar.dart';
import 'package:window_manager/window_manager.dart';

const kHeaderHeight = 42.0;
const _kIconSize = 20.0;

class MovableSpace extends StatelessWidget {
  const MovableSpace({Key? key, required this.child}) : super(key: key);

  const MovableSpace.empty({Key? key})
      : child = const SizedBox.expand(),
        super(key: key);

  static wrapped({double? width, double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: const MovableSpace.empty(),
    );
  }

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var needMove = Platform.isLinux || Platform.isMacOS || Platform.isWindows;
    if (!needMove) {
      return child;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) {
        WindowManager.instance.startDragging();
      },
      onDoubleTap: () async {
        var instance = WindowManager.instance;
        if (await instance.isMaximized()) {
          instance.unmaximize();
        } else {
          instance.maximize();
        }
      },
      child: child,
    );
  }
}

class _BaseIcon extends StatelessWidget {
  const _BaseIcon({
    Key? key,
    required this.icon,
    required this.onTap,
    this.isActive,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: _kIconSize,
      color: context.inversePrimary,
      onPressed: isActive ?? true ? onTap : null,
    );
  }
}

class _WindowOperations extends HookWidget {
  const _WindowOperations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMaximized = useState(false);
    useMemoized(() async {
      isMaximized.value = await WindowManager.instance.isMaximized();
    });

    useEffect(() {
      var listener = _WindowListener(
        onMaximize: () => isMaximized.value = true,
        onMinimize: () => isMaximized.value = false,
        onUnMaximize: () => isMaximized.value = false,
        onMove: () => isMaximized.value = false,
      );
      WindowManager.instance.addListener(listener);
      return () => WindowManager.instance.removeListener(listener);
    }, [WindowManager.instance]);

    return Row(
      children: [
        _BaseIcon(
            icon: Icons.remove,
            onTap: () {
              WindowManager.instance.minimize();
            }),
        _BaseIcon(
          icon: isMaximized.value ? Icons.fullscreen_exit : Icons.fullscreen,
          onTap: () async {
            if (await WindowManager.instance.isMaximized()) {
              WindowManager.instance.unmaximize();
              isMaximized.value = false;
            } else {
              WindowManager.instance.maximize();
              isMaximized.value = true;
            }
          },
        ),
        _BaseIcon(
          icon: Icons.close,
          onTap: () {
            WindowManager.instance.close();
          },
        ),
      ],
    );
  }
}

class _SettingsIcon extends ConsumerWidget {
  const _SettingsIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider.notifier);
    return _BaseIcon(
      icon: Icons.settings,
      onTap: () => router.push('/settings'),
    );
  }
}

class RouteControl extends ConsumerWidget {
  const RouteControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);
    final router = ref.read(routerProvider.notifier);
    return Row(
      children: [
        _BaseIcon(
          icon: Icons.chevron_left,
          isActive: route.canBack,
          onTap: () => router.back(),
        ),
        _BaseIcon(
          icon: Icons.chevron_right,
          isActive: route.canForward,
          onTap: () => router.forward(),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.primaryColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SizedBox(
          height: kHeaderHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MovableSpace.wrapped(width: 12),
              const RouteControl(),
              MovableSpace.wrapped(width: 12),
              Expanded(
                child: MovableSpace(
                  child: SizedBox(
                    child: Text(
                      'NoteBox',
                      style: TextStyle(
                        color: context.inversePrimary,
                        fontSize: context.textTheme.titleMedium?.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
              const AvatarContainer(),
              MovableSpace.wrapped(width: 12),
              const _SettingsIcon(),
              if (isDesktop) const _WindowOperations(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WindowListener extends WindowListener {
  final VoidCallback? onMaximize;
  final VoidCallback? onMinimize;
  final VoidCallback? onClose;
  final VoidCallback? onUnMaximize;
  final VoidCallback? onMove;
  final VoidCallback? onResize;

  _WindowListener({
    this.onMaximize,
    this.onMinimize,
    this.onClose,
    this.onUnMaximize,
    this.onMove,
    this.onResize,
  });

  @override
  void onWindowMaximize() {
    onMaximize?.call();
  }

  @override
  void onWindowMinimize() {
    onMinimize?.call();
  }

  @override
  void onWindowResize() {
    onResize?.call();
  }

  @override
  void onWindowMove() {
    onMove?.call();
  }

  @override
  void onWindowUnmaximize() {
    onUnMaximize?.call();
  }

  @override
  void onWindowClose() {
    onClose?.call();
  }
}
