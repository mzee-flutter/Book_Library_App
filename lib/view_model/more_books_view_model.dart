import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import 'package:flutter/foundation.dart';
import '../repository/more_books_repository.dart';

class MoreBooksViewModel with ChangeNotifier {
  final MoreBooksRepository _moreBooksRepo = MoreBooksRepository();
  int startIndex = 0;
  int maxResults = 10;

  final List<Book> _allBooks = [];
  List<Book> get allBooks => _allBooks;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> fetchMoreBooksList(String category,
      {bool isNewCategory = false}) async {
    if (isNewCategory) {
      _allBooks.clear();
      startIndex = 0;
      notifyListeners();
    }

    if (_isFetching) return;
    _isFetching = true;
    notifyListeners();

    try {
      final books = await _moreBooksRepo.fetchMoreBooksList(
        maxResults,
        startIndex,
        category,
      );

      _allBooks.addAll(books.books ?? []);
      startIndex += maxResults;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
