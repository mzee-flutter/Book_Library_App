import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import 'package:BookMate_Pro/repository/google_books_repository.dart';
import 'package:flutter/foundation.dart';

class GoogleBooksViewModel with ChangeNotifier {
  final GoogleBooksRepository _googleBooksRepo = GoogleBooksRepository();
  int startIndex = 0;
  int maxResults = 10;

  final List<Book> _allBooks = [];
  List<Book> get allBooks => _allBooks;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> fetchGoogleBooksList() async {
    if (_isFetching) return;
    _isFetching = true;
    notifyListeners();

    try {
      final books =
          await _googleBooksRepo.fetchGoogleBooksList(maxResults, startIndex);

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
