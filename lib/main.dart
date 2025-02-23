import 'package:BookMate_Pro/view_model/author_info_view_model/author_books_view_model.dart';
import 'package:BookMate_Pro/view_model/booksList_view_model.dart';
import 'package:BookMate_Pro/view_model/google_books_view_model.dart';
import 'package:BookMate_Pro/view_model/tab_bar_view_model.dart';

import 'utils/routes/routes.dart';
import 'utils/routes/routes_names.dart';
import 'package:BookMate_Pro/view_model/bottom_navigation_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:BookMate_Pro/view_model/app_themes_view_model.dart';
import 'resources/app_themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemesViewModel()),
        ChangeNotifierProvider(create: (_) => BottomIconNavigationViewModel()),
        ChangeNotifierProvider(create: (_) => BooksListViewModel()),
        ChangeNotifierProvider(create: (_) => GoogleBooksViewModel()),
        ChangeNotifierProvider(create: (_) => TabBarViewModel()),
        ChangeNotifierProvider(create: (_) => AuthorBooksViewModel()),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Selector<AppThemesViewModel, bool>(
      selector: (context, themeProvider) => themeProvider.isThemeChange,
      builder: (context, isThemeChange, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isThemeChange ? AppThemes.lightTheme : AppThemes.darkTheme,
          initialRoute: RoutesName.homeScreen,
          onGenerateRoute: Routes.generateRouts,
        );
      },
    );
  }
}

///But if we use the themeProvider.toggleAppThemes() then whenever the state change
/// the whole UI will be rebuild.(this method is also dependent on specific variable)
