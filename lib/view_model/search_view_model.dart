import 'dart:async';

import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import 'package:BookMate_Pro/repository/search_books_respository.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class SearchViewModel with ChangeNotifier {
  final SearchBooksRepository _searchRepo = SearchBooksRepository();
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  int _startIndex = 0;
  final int _maxResults = 10;

  final List<Book> _booksList = [];
  List<Book> get booksList => _booksList;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  void clearSearch() {
    _booksList.clear();
    _startIndex = 0;
    controller.clear();
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchBooksBySearch(String title) async {
    if (_isFetching) return;
    _isFetching = true;
    notifyListeners();
    try {
      final books =
          await _searchRepo.fetchBooksBySearch(_maxResults, _startIndex, title);
      final newBooks = books.books
          ?.where((newBook) =>
              !_booksList.any((existingBook) => existingBook.id == newBook.id))
          .toList();
      _booksList.addAll(newBooks ?? []);
      _startIndex += _maxResults;
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
