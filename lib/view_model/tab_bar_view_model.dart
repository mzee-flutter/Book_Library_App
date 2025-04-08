import 'package:flutter/cupertino.dart';

class TabBarViewModel with ChangeNotifier {
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  void setIndex(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void toggleTab(int tabIndex) {
    _selectedTab = tabIndex;
    notifyListeners();
  }
}
