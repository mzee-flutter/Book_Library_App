import 'package:BookMate_Pro/view/book_mark_screen_view/book_mark_screen_appbar.dart';
import 'package:BookMate_Pro/view/home_screen_view/home_screen_app_bar.dart';
import 'package:BookMate_Pro/view/home_screen_view/home_screen_body_view.dart';
import 'package:BookMate_Pro/view/library_screen_view/library_screen_app_bar.dart';
import 'package:BookMate_Pro/view/profile_screen_view/profile_screen_app_bar.dart';
import 'package:BookMate_Pro/view/search_screen_view/search_screen_app_bar.dart';
import 'package:flutter/material.dart';

import '../view/book_mark_screen_view/book_mark_screen.dart';

import '../view/library_screen_view/library_screen.dart';
import '../view/profile_screen_view/profile_screen.dart';
import '../view/search_screen_view/search_screen.dart';

class BottomIconNavigationViewModel with ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeTab(int currentTabIndex) {
    if (_selectedIndex != currentTabIndex) {
      _selectedIndex = currentTabIndex;
      notifyListeners();
    }
  }

  final List<Widget> bottomBarScreens = [
    const HomeScreenBodyView(),
    const LibraryScreen(),
    const BookMarkScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  List<PreferredSizeWidget> get screensAppBars => [
        HomeScreenAppBar(scaffoldKey: scaffoldKey),
        const LibraryScreenAppBar(),
        const BookMarkScreenAppBar(),
        const SearchScreenAppBar(),
        const ProfileScreenAppBar(),
      ];
}
