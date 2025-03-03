import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_book_card/small_book_card.dart';
import '../../view_model/google_books_view_model.dart';

class MoreBooksScreen extends StatefulWidget {
  const MoreBooksScreen({super.key});

  @override
  MoreBooksScreenState createState() => MoreBooksScreenState();
}

class MoreBooksScreenState extends State<MoreBooksScreen> {
  @override
  initState() {
    super.initState();
    final booksProvider =
        Provider.of<GoogleBooksViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      booksProvider.fetchGoogleBooksList();
    });
  }

  bool _isScrollNearToEnd(ScrollNotification scrollInfo) {
    return scrollInfo.metrics.pixels >=
        (scrollInfo.metrics.maxScrollExtent * .85);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self-Help Books'),
        centerTitle: true,
        elevation: 5,
        iconTheme: const IconThemeData(
          size: 25,
        ),
      ),
      body: SafeArea(
        child: Consumer<GoogleBooksViewModel>(
          builder: (context, booksProvider, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (_isScrollNearToEnd(scrollInfo)) {
                  if (!booksProvider.isFetching) {
                    booksProvider.fetchGoogleBooksList();
                  }
                }
                return true;
              },
              child: ListView.builder(
                itemCount: booksProvider.allBooks.length +
                    (booksProvider.isFetching ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == booksProvider.allBooks.length &&
                      booksProvider.isFetching) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final book = booksProvider.allBooks[index];
                  return SmallBookCard(
                    book: book,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  SingleBookScreen(fullBook: book)));
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
