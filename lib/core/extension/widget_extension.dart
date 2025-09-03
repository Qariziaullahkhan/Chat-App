import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  showSnackbar(String text) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(text)));
}

extension NavigationExtension on BuildContext {
  /// Pushes [page] onto the navigation stack using a Material page route.
  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));

  /// Replaces the current route by pushing [page] and removing the previous one.
  Future<T?> pushReplacement<T, TO>(Widget page) =>
      Navigator.of(this).pushReplacement<T, TO>(
          MaterialPageRoute(builder: (_) => page));

  /// Pops the current route, optionally returning [result].
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
}
