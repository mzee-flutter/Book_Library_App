import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:BookMate_Pro/utils/custom_book_card/small_book_card.dart';
import 'package:provider/provider.dart';

import '../../view_model/book_mark_view_model.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  BookMarkScreenState createState() => BookMarkScreenState();
}

class BookMarkScreenState extends State<BookMarkScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BookMarkViewModel>(context, listen: false).getBookMarks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<BookMarkViewModel>(
        builder: (context, bookmarkProvider, child) {
          return Column(
            children: [
              ListView.builder(
                  itemCount: bookmarkProvider.markedBooksList.length,
                  itemBuilder: (context, index) {
                    final book = bookmarkProvider.markedBooksList[index];

                    return SmallBookCard(
                        book: book,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SingleBookScreen(fullBook: book),
                            ),
                          );
                        });
                  })
            ],
          );
        },
      ),
    );
  }
}
