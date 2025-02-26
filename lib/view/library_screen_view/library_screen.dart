import 'package:BookMate_Pro/utils/custom_book_card/medium_book_card.dart';
import 'package:BookMate_Pro/view_model/google_books_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  LibraryScreenState createState() => LibraryScreenState();
}

class LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    final googleBooksProvider =
        Provider.of<GoogleBooksViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      googleBooksProvider.fetchGoogleBooksList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(),
    );
  }
}
