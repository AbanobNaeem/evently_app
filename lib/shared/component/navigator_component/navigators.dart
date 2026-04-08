import 'package:flutter/material.dart';

class NavigationService {
  // singleton
  NavigationService._privateConstructor();
  static final NavigationService instance = NavigationService._privateConstructor();

  // Global key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Push to new screen
  Future<dynamic>? push(Widget page) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// PushReplacement
  Future<dynamic>? pushReplacement(Widget page) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// PushAndRemoveUntil (clear all stack)
  Future<dynamic>? pushAndRemoveUntil(Widget page) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
          (route) => false,
    );
  }

  Future<dynamic>? pushNamed(String routeName,{arguments}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  /// Pop
  void pop([dynamic result]) {
    return navigatorKey.currentState?.pop(result);
  }

  /// PopUntil
  void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }

  /// Check if can pop
  bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }
}