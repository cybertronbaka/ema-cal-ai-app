import 'package:flutter/material.dart';

const _debug = false;

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final AppNavigatorObserver rootNavigatorObserver = AppNavigatorObserver(
  debugLabel: 'root',
);

final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final AppNavigatorObserver homeNavigatorObserver = AppNavigatorObserver(
  debugLabel: 'home',
);

final overviewNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'overview');
final AppNavigatorObserver overviewNavigatorObserver = AppNavigatorObserver(
  debugLabel: 'overview',
);

final settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');
final AppNavigatorObserver settingsNavigatorObserver = AppNavigatorObserver(
  debugLabel: 'settings',
);

class NavigationStack {
  final List<String> _stack = [];

  void push(String value) {
    _stack.add(value);
  }

  String pop() {
    if (_stack.isEmpty) throw Exception('Pop: Navigation Stack is empty');

    return _stack.removeLast();
  }

  String? get currentRoute => list.firstOrNull;
  String? get prevRoute => nthRoute(1);

  String? nthRoute(int i) {
    return list.elementAtOrNull(i);
  }

  List<String> get list => List.unmodifiable(_stack.reversed);
}

class AppNavigatorObserver extends RouteObserver<ModalRoute<void>> {
  AppNavigatorObserver({this.debugLabel = 'Root'});
  final String debugLabel;

  final NavigationStack stack = NavigationStack();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      stack.push(route.settings.name!);
    }
    if (_debug) {
      debugPrint('[$debugLabel](didPush): Current Stack: ${stack._stack}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null && oldRoute.settings.name != null) {
      stack.pop();
    }
    if (newRoute != null && newRoute.settings.name != null) {
      stack.push(newRoute.settings.name!);
    }
    if (_debug) {
      debugPrint('[$debugLabel](didReplace): Current Stack: ${stack._stack}');
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      stack.pop();
    }
    if (_debug) {
      debugPrint('[$debugLabel](didPop): Current Stack: ${stack._stack}');
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      stack.pop();
    }
    if (_debug) {
      debugPrint('[$debugLabel](didRemove): Current Stack: ${stack._stack}');
    }
    super.didRemove(route, previousRoute);
  }
}
