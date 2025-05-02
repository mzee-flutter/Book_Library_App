import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/popular_google_books_model.dart';

class BookMarkViewModel with ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  List<Book> _markedBooksList = [];
  List<Book> get markedBooksList => _markedBooksList;

  /// Add a bookmark (1 book = 1 doc)
  Future<void> addBookMark(Book book) async {
    try {
      await _fireStore.collection('bookmarks').doc(book.id).set(book.toJson());
      _markedBooksList.add(book);
      notifyListeners();
      print('Bookmarked successfully');
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  /// Remove a bookmark
  Future<void> removeBookmark(Book book) async {
    try {
      await _fireStore.collection('bookmarks').doc(book.id).delete();
      _markedBooksList.removeWhere((b) => b.id == book.id);
      notifyListeners();
      print('Bookmark removed successfully');
    } catch (e) {
      print("Error removing bookmark: $e");
    }
  }

  /// Fetch all bookmarks
  Future<void> getBookMarks() async {
    try {
      final snapshot = await _fireStore.collection('bookmarks').get();

      _markedBooksList =
          snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching bookmarks: $e");
    }
  }

  /// Check if a book is bookmarked
  bool isBookmarked(Book book) {
    return _markedBooksList.any((b) => b.id == book.id);
  }
}
