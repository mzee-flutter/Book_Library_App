import 'package:BookMate_Pro/utils/routes/routes_names.dart';
import 'package:BookMate_Pro/view/book_mark_screen_view/book_mark_screen.dart';
import 'package:BookMate_Pro/view/home_screen_view/home_screen.dart';
import 'package:BookMate_Pro/view/home_screen_view/more_books_screen.dart';
import 'package:BookMate_Pro/view/library_screen_view/library_screen.dart';
import 'package:BookMate_Pro/view/profile_screen_view/profile_screen.dart';
import 'package:BookMate_Pro/view/search_screen_view/search_screen.dart';
import 'package:flutter/material.dart';

import '../../view/single_book_screen/single_book_screen.dart';

class Routes {
  static MaterialPageRoute generateRouts(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RoutesName.libraryScreen:
        return MaterialPageRoute(builder: (_) => const LibraryScreen());

      case RoutesName.bookMarkScreen:
        return MaterialPageRoute(builder: (_) => const BookMarkScreen());

      case RoutesName.searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case RoutesName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case RoutesName.moreBooksScreen:
        return MaterialPageRoute(builder: (_) => const MoreBooksScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text('No routes to this page!'),
          ),
        );
    }
  }
}
