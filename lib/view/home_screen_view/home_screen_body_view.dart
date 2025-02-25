import 'package:BookMate_Pro/utils/custom_book_card/medium_book_card.dart';
import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../utils/books_category_and_more.dart';
import '../../utils/routes/routes_names.dart';
import '../../view_model/google_books_view_model.dart';

class HomeScreenBodyView extends StatefulWidget {
  const HomeScreenBodyView({super.key});

  @override
  State<HomeScreenBodyView> createState() => HomeScreenBodyViewState();
}

class HomeScreenBodyViewState extends State<HomeScreenBodyView> {
  @override
  void initState() {
    super.initState();
    final booksProvider =
        Provider.of<GoogleBooksViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      booksProvider.fetchGoogleBooksList();
    });
  }

  bool _isNearToEnd(ScrollNotification scrollInfo) {
    return scrollInfo.metrics.pixels >=
        (scrollInfo.metrics.maxScrollExtent * 0.85);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
          vertical: 7.r,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BooksCategoryAndMore(
              categoryName: 'Top Self-Help Books',
              categoryDescription: 'Your journey to a better you begins here.',
              categoryIcon: Icons.lightbulb_outline,
              onTap: () {
                Navigator.pushNamed(context, RoutesName.moreBooksScreen);
              },
            ),
            Container(
              height: 310.h,
              child: Consumer<GoogleBooksViewModel>(
                builder: (context, booksProvider, child) {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (_isNearToEnd(scrollInfo)) {
                        if (!booksProvider.isFetching &&
                            booksProvider.allBooks.length < 30) {
                          booksProvider
                              .fetchGoogleBooksList(); // Trigger load more books
                        }
                      }
                      return true;
                    },
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      itemCount: booksProvider.allBooks.length +
                          (booksProvider.isFetching
                              ? 1
                              : 0), // Add 1 for loading indicator
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisExtent: 175.h, // Adjusted to fit image + text
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 8.w),
                      itemBuilder: (context, index) {
                        if (index == booksProvider.allBooks.length &&
                            booksProvider.isFetching) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final book = booksProvider.allBooks[index];

                        return MediumBookCard(
                          book: book,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SingleBookScreen(fullBook: book),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
