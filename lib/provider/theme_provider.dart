import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class ThemeProvider extends InheritedNotifier {
  final ThemeModel model;

  const ThemeProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(
          notifier: model,
        );

//listen wish subscription
  static ThemeProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }
}
