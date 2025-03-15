import 'package:BookMate_Pro/utils/custom_book_card/clickable_category_cards.dart';
import 'package:BookMate_Pro/utils/custom_book_card/small_book_card.dart';
import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../view_model/search_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final ClickableCategoryCards _cards = ClickableCategoryCards();

  @override
  void initState() {
    super.initState();
    final searchProvider = context.read<SearchViewModel>();

    searchProvider.controller.addListener(() {
      if (searchProvider.controller.text.isEmpty) {
        searchProvider.clearSearch();
      }
    });
  }

  bool _isScrollNearToEnd(ScrollNotification scrollInfo) {
    return scrollInfo.metrics.pixels >=
        (scrollInfo.metrics.maxScrollExtent * 0.95);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
        child: Consumer<SearchViewModel>(
          builder: (context, searchProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show Loading Indicator while fetching
                if (searchProvider.isFetching &&
                    searchProvider.booksList.isEmpty)
                  const Center(child: CircularProgressIndicator())
                else if (searchProvider.booksList.isNotEmpty)
                  // Show Search Results when available
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (_isScrollNearToEnd(scrollInfo)) {
                          final title = searchProvider.controller.text.trim();
                          if (title.isNotEmpty) {
                            searchProvider.fetchBooksBySearch(title);
                          }
                        }
                        return true;
                      },
                      child: ListView.builder(
                        itemCount: searchProvider.booksList.length +
                            (searchProvider.isFetching ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == searchProvider.booksList.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final book = searchProvider.booksList[index];
                          return SmallBookCard(
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
                    ),
                  )
                else
                  // Show Default UI when not searching
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Famous Authors',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 30.r),
                        Text(
                          'Categories',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.r),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10.w,
                              runSpacing: 7.h,
                              children: _cards.getCardList(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
