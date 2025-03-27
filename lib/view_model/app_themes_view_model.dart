import 'package:flutter/material.dart';

class AppThemesViewModel with ChangeNotifier {
  bool _isThemeChange = true;
  bool get isThemeChange => _isThemeChange;

  void toggleAppThemes() {
    _isThemeChange = !_isThemeChange;
    notifyListeners();
  }

  Color getSliverAppBarBackgroundColor(context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.brown.shade100
        : Theme.of(context).colorScheme.surface;
  }
}
