import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import 'package:BookMate_Pro/repository/success_book_respository.dart';
import 'package:flutter/foundation.dart';

class SuccessBooksViewModel with ChangeNotifier {
  final SuccessBooksRepository _successBooksRepo = SuccessBooksRepository();
  int startIndex = 0;
  int maxResults = 10;

  final List<Book> _allBooks = [];
  List<Book> get allBooks => _allBooks;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> fetchSuccessBooksList() async {
    if (_isFetching) return;
    _isFetching = true;
    notifyListeners();

    try {
      final books = await _successBooksRepo.fetchGoogleConversationBooksList(
        maxResults,
        startIndex,
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
