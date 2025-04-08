import 'package:BookMate_Pro/repository/google_author_books/author_books_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:BookMate_Pro/model/popular_google_books_model.dart';

class AuthorBooksViewModel with ChangeNotifier {
  final AuthorBooksRepository _authorBooksRepo = AuthorBooksRepository();

  final List<Book> _allBooks = [];
  List<Book> get allBooks => _allBooks;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> fetchAuthorBooks(String name, {bool reset = false}) async {
    if (_isFetching) return;

    _isFetching = true;
    notifyListeners();

    try {
      if (reset) {
        _allBooks.clear();
      }

      final booksList = await _authorBooksRepo.fetchAuthorBooks(name);

      if (booksList.books != null && booksList.books!.isNotEmpty) {
        Set<String?> existingBooksId = _allBooks.map((b) => b.id).toSet();
        List<Book> newBooks = booksList.books!
            .where((book) => !existingBooksId.contains(book.id))
            .toList();

        if (newBooks.isNotEmpty) {
          _allBooks.addAll(newBooks);
        }
      }

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
