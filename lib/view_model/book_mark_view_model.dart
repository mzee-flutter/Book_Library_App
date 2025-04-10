import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/popular_google_books_model.dart';
import 'dart:developer';

class BookMarkViewModel with ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Book> _markedBooksList = [];
  List<Book> get markedBooksList => _markedBooksList;

  /// Add Bookmark
  Future<void> addBookMark(Book book) async {
    try {
      _markedBooksList.add(book);

      notifyListeners();

      await _fireStore.collection('bookmarks').doc(book.id).set({
        "books": _markedBooksList.map((book) => book.toJson()).toList(),
      });
      print('bookmarked successfully done');
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  /// Remove Bookmark
  Future<void> removeBookmark(Book book) async {
    // final userID = _auth.currentUser?.uid;
    // if (userID == null) return;

    try {
      _markedBooksList.removeWhere((b) => b.id == book.id);

      notifyListeners();
      print('remove successfully done...');

      await _fireStore.collection('bookmarks').doc(book.id).delete();
    } catch (e) {
      print("Error removing bookmark: $e");
    }
  }

  ///  Fetch Bookmarks
  Future<void> getBookMarks() async {
    try {
      final snapshot = await _fireStore.collection('bookmarks').get();

      log('fetch data: ${snapshot.docs.map((doc) => doc.data())}');

      _markedBooksList =
          snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching bookmarks: $e");
    }
  }

  bool isBookmarked(Book book) {
    return _markedBooksList.any((b) => b.id == book.id);
  }
}

/// ensuring the markedBook data is displaying...
