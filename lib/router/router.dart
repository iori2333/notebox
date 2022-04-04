import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouterTarget {
  final String path;
  final Map<String, String> parameters;

  RouterTarget({
    required this.path,
    required this.parameters,
  });

  bool equals(RouterTarget other) {
    if (path != other.path) {
      return false;
    }
    for (final key in parameters.keys) {
      if (parameters[key] != other.parameters[key]) {
        return false;
      }
    }
    return true;
  }

  @override
  String toString() {
    var s = StringBuffer();
    s.write(path + '#');
    for (var entry in parameters.entries) {
      s.write(entry.key + '=' + entry.value);
    }
    return s.toString();
  }
}

class RouterState with EquatableMixin {
  const RouterState({
    required this.pages,
    required this.canBack,
    required this.canForward,
    required this.current,
  });

  final List<Page> pages;

  final bool canBack;

  final bool canForward;

  final RouterTarget current;

  @override
  List<Object?> get props => [pages, canBack, canForward, current];
}

abstract class RouteController extends StateNotifier<RouterState> {
  RouteController()
      : super(RouterState(
          pages: [],
          canBack: false,
          canForward: false,
          current: RouterTarget(
            path: '/',
            parameters: {},
          ),
        ));

  List<Page> get pages;

  bool get canBack;

  bool get canForward;

  RouterTarget get current;

  void push(String path, {Map<String, String>? params});

  void replace(String path, {Map<String, String>? params});

  void back();

  void forward();

  @protected
  void notifyListeners() {
    state = RouterState(
      pages: pages,
      canBack: canBack,
      canForward: canForward,
      current: current,
    );
  }
}
