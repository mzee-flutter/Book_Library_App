import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/popular_google_books_model.dart';

class BookMarkViewModel with ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  List<Book> _markedBooksList = [];
  List<Book> get markedBooksList => _markedBooksList;

  /// Add a bookmark (1 book = 1 doc)
  Future<void> addBookMark(Book book) async {
    _markedBooksList.add(book);
    notifyListeners();
    try {
      await _fireStore.collection('bookmarks').doc(book.id).set({
        ...book.toJson(),
        'saveAt': FieldValue.serverTimestamp(),
      });

      print('Bookmarked successfully');
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  /// Remove a bookmark
  Future<void> removeBookmark(Book book) async {
    _markedBooksList.removeWhere((b) => b.id == book.id);
    notifyListeners();
    try {
      await _fireStore.collection('bookmarks').doc(book.id).delete();

      print('Bookmark removed successfully');
    } catch (e) {
      print("Error removing bookmark: $e");
    }
  }

  /// Fetch all bookmarks
  Future<void> getBookMarks() async {
    try {
      _isFetching = true;
      final snapshot = await _fireStore
          .collection('bookmarks')
          .orderBy('saveAt', descending: true)
          .get();

      _markedBooksList = snapshot.docs.map((doc) {
        final data = doc.data();
        data.remove('saveAt');
        return Book.fromJson(data);
      }).toList();

      notifyListeners();

      _isFetching = false;
    } catch (e) {
      print("Error fetching bookmarks: $e");
      _isFetching = false;
    }
  }

  /// Check if a book is bookmarked
  bool isBookmarked(Book book) {
    return _markedBooksList.any((b) => b.id == book.id);
  }
}
