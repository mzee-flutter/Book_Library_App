import 'package:BookMate_Pro/view_model/author_info_view_model/author_books_view_model.dart';
import 'package:BookMate_Pro/view_model/book_mark_view_model.dart';
import 'package:BookMate_Pro/view_model/search_view_model.dart';
import 'package:BookMate_Pro/view_model/success_books_view_model.dart';
import 'package:BookMate_Pro/view_model/deep_seek_summary_view_model.dart';
import 'package:BookMate_Pro/view_model/google_books_view_model.dart';
import 'package:BookMate_Pro/view_model/more_books_view_model.dart';
import 'package:BookMate_Pro/view_model/tab_bar_view_model.dart';
import 'package:BookMate_Pro/view_model/language_dropdown_view_model.dart';
import 'package:BookMate_Pro/view_model/responses_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'utils/routes/routes.dart';
import 'utils/routes/routes_names.dart';
import 'package:BookMate_Pro/view_model/bottom_navigation_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:BookMate_Pro/view_model/app_themes_view_model.dart';
import 'resources/app_themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemesViewModel()),
        ChangeNotifierProvider(create: (_) => BottomIconNavigationViewModel()),
        ChangeNotifierProvider(create: (_) => GoogleBooksViewModel()),
        ChangeNotifierProvider(create: (_) => TabBarViewModel()),
        ChangeNotifierProvider(create: (_) => AuthorBooksViewModel()),
        ChangeNotifierProvider(create: (_) => DeepSeekSummaryViewModel()),
        ChangeNotifierProvider(create: (_) => LanguageDropDownViewModel()),
        ChangeNotifierProvider(create: (_) => ResponsesViewModel()),
        ChangeNotifierProvider(create: (_) => SuccessBooksViewModel()),
        ChangeNotifierProvider(create: (_) => MoreBooksViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => BookMarkViewModel()),
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
