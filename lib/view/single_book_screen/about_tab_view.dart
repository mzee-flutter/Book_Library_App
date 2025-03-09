import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import '../../utils/custom_book_card/medium_book_card.dart';
import '../../view_model/author_info_view_model/author_books_view_model.dart';

class AboutTabView extends StatelessWidget {
  const AboutTabView({
    super.key,
    required this.fullBook,
  });

  final Book fullBook;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s it about ?',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          fullBook.volumeInfo?.description ?? 'Description not available',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              // fontStyle: FontStyle.italic,
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
              fontFamily: 'Serif'),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Related Books',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.h,
        ),
        Consumer<AuthorBooksViewModel>(
          builder: (context, authorBooksProvider, child) {
            return Container(
              height: 300.h,
              width: double.infinity,
              child: ListView.builder(
                itemExtent: 175,
                scrollDirection: Axis.horizontal,
                itemCount: authorBooksProvider.allBooks.length +
                    (authorBooksProvider.isFetching ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == authorBooksProvider.allBooks.length &&
                      authorBooksProvider.isFetching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final authorBook = authorBooksProvider.allBooks[index];
                  return MediumBookCard(
                      book: authorBook,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SingleBookScreen(fullBook: authorBook),
                          ),
                        );
                      });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
