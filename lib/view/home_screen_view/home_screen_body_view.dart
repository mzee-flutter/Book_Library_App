import 'package:BookMate_Pro/utils/custom_book_card/medium_book_card.dart';
import 'package:BookMate_Pro/view/home_screen_view/more_books_screen.dart';
import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../utils/books_category_and_more.dart';
import '../../view_model/success_books_view_model.dart';
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
    final conversationBookProvider =
        Provider.of<SuccessBooksViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      booksProvider.fetchGoogleBooksList();
      conversationBookProvider.fetchSuccessBooksList();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BooksCategoryAndMore(
                categoryName: 'Top Self-Help Books',
                categoryDescription:
                    'Your journey to a better you begins here.',
                categoryIcon: Icons.lightbulb_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoreBooksScreen(
                        category: 'self_help',
                        name: 'Top Self-Help Books',
                      ),
                    ),
                  );
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
                            mainAxisExtent:
                                175.h, // Adjusted to fit image + text
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
              SizedBox(
                height: 10.r,
              ),
              BooksCategoryAndMore(
                  categoryName: 'Success and Career',
                  categoryDescription: 'From Dreams to Reality.',
                  categoryIcon: FontAwesomeIcons.award,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MoreBooksScreen(
                          category: 'success',
                          name: 'Success and Career',
                        ),
                      ),
                    );
                  }),
              Container(
                height: 310.h,
                child: Consumer<SuccessBooksViewModel>(
                  builder: (context, conversationBooksProvider, child) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (_isNearToEnd(scrollInfo)) {
                          if (!conversationBooksProvider.isFetching &&
                              conversationBooksProvider.allBooks.length < 30) {
                            conversationBooksProvider
                                .fetchSuccessBooksList(); // Trigger load more books
                          }
                        }
                        return true;
                      },
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                        itemCount: conversationBooksProvider.allBooks.length +
                            (conversationBooksProvider.isFetching
                                ? 1
                                : 0), // Add 1 for loading indicator
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent:
                                175.h, // Adjusted to fit image + text
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 8.w),
                        itemBuilder: (context, index) {
                          if (index ==
                                  conversationBooksProvider.allBooks.length &&
                              conversationBooksProvider.isFetching) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final book =
                              conversationBooksProvider.allBooks[index];

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
      ),
    );
  }
}

// Master the art of meaningful conversations and effective communication.
