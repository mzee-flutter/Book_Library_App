import 'package:BookMate_Pro/view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/app_themes_view_model.dart';
import '../../view_model/bottom_navigation_bar_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<BottomIconNavigationViewModel>();

    return Scaffold(
      key: navigationProvider.scaffoldKey,
      appBar:
          navigationProvider.screensAppBars[navigationProvider.selectedIndex],
      drawer: const Drawer(),
      body:
          navigationProvider.bottomBarScreens[navigationProvider.selectedIndex],
      bottomNavigationBar: const BottomNavigationView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AppThemesViewModel>().toggleAppThemes();
        },
        child: const Icon(Icons.ads_click),
      ),
    );
  }
}

///context.read means that only necessary part of the UI will be rebuild
///final themeProvider= Provider.of(context)-->using this method is not efficient
///because it depend on specific variable and also consumer rebuild the UI when provider changes
