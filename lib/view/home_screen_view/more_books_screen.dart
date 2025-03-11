import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:BookMate_Pro/view_model/more_books_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_book_card/small_book_card.dart';

class MoreBooksScreen extends StatefulWidget {
  const MoreBooksScreen({super.key, required this.category});
  final String category;

  @override
  MoreBooksScreenState createState() => MoreBooksScreenState();
}

class MoreBooksScreenState extends State<MoreBooksScreen> {
  @override
  initState() {
    super.initState();
    final booksProvider =
        Provider.of<MoreBooksViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      booksProvider.fetchMoreBooksList(widget.category, isNewCategory: true);
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
        child: Consumer<MoreBooksViewModel>(
          builder: (context, booksProvider, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (_isScrollNearToEnd(scrollInfo)) {
                  if (!booksProvider.isFetching) {
                    booksProvider.fetchMoreBooksList(widget.category);
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
