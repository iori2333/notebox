import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebox/router/router.dart';
import 'package:notebox/views/pages/settings.dart';

final routerProvider =
    StateNotifierProvider<ContentRouteController, RouterState>((ref) {
  return ContentRouteController();
});

typedef PageGenerator = Widget Function(Map<String, String>? params);

class _FallbackPage extends StatelessWidget {
  const _FallbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page'),
    );
  }
}

class ContentRouteController extends RouteController {
  ContentRouteController() {
    _pages.add(_buildPagePath('/'));
    notifyListeners();
  }

  static final Map<String, PageGenerator> routeTable = {
    '/settings': (_) => const SettingsPage(),
  };

  static Widget fallbackPage(Map<String, String>? params) =>
      const _FallbackPage();

  final List<Page> _pages = [];
  final List<Page> _popPages = [];

  @override
  bool get canBack => _pages.length > 1;

  @override
  bool get canForward => _popPages.isNotEmpty;

  @override
  RouterTarget get current => (_pages.last.key as ValueKey<RouterTarget>).value;

  @override
  List<Page> get pages => _pages;

  @override
  void back() {
    if (canBack) {
      _popPages.add(_pages.removeLast());
      notifyListeners();
    }
  }

  @override
  void forward() {
    if (canForward) {
      _pages.add(_popPages.removeLast());
      notifyListeners();
    }
  }

  @override
  void push(String path, {Map<String, String>? params}) {
    var target = RouterTarget(path: path, parameters: params ?? {});
    if (current.equals(target)) {
      return;
    }

    _pages.add(_buildPage(target));
    _popPages.clear();
    notifyListeners();
  }

  @override
  void replace(String path, {Map<String, String>? params}) {
    var target = RouterTarget(path: path, parameters: params ?? {});
    if (current.equals(target)) {
      return;
    }

    _pages.removeLast();
    _pages.add(_buildPage(target));
    _popPages.clear();
    notifyListeners();
  }

  Page _buildPage(RouterTarget target) {
    final PageGenerator generator = routeTable[target.path] ?? fallbackPage;
    return MaterialPage(
      child: generator(target.parameters),
      name: target.toString(),
      key: ValueKey(target),
    );
  }

  Page _buildPagePath(String path, {Map<String, String>? params}) {
    var target = RouterTarget(path: path, parameters: params ?? {});
    return _buildPage(target);
  }
}
