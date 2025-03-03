import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:BookMate_Pro/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../view_model/bottom_navigation_bar_view_model.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<BottomIconNavigationViewModel>();
    return SalomonBottomBar(
      unselectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      currentIndex: navigationProvider.selectedIndex,
      onTap: (tabIndex) {
        navigationProvider.changeTab(tabIndex);
      },
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home_rounded, size: 22),
          title: const Text("Home", style: bottomBarLabelStyle),
        ),
        SalomonBottomBarItem(
          icon: const Icon(FontAwesomeIcons.landmark, size: 17),
          title: const Text("Library", style: bottomBarLabelStyle),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.bookmark_rounded, size: 22),
          title: const Text("Bookmark", style: bottomBarLabelStyle),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.search, size: 22),
          title: const Text("Explore", style: bottomBarLabelStyle),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.person, size: 22),
          title: const Text("Profile", style: bottomBarLabelStyle),
        ),
      ],
    );
  }
}
