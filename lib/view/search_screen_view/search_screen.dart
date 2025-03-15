import 'package:BookMate_Pro/utils/custom_book_card/clickable_category_cards.dart';
import 'package:BookMate_Pro/utils/custom_book_card/small_book_card.dart';
import 'package:BookMate_Pro/view/single_book_screen/single_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../utils/snakebars_and_popUps/snake_bars.dart';
import '../../view_model/search_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final ClickableCategoryCards _cards = ClickableCategoryCards();

  bool _isScrollNearToEnd(ScrollNotification scrollInfo) {
    return scrollInfo.metrics.pixels >=
        (scrollInfo.metrics.maxScrollExtent * 0.95);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
          vertical: 15.r,
        ),
        child: Consumer<SearchViewModel>(
          builder: (context, searchProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                  controller: searchProvider.controller,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.inversePrimary,
                    hintText: 'Search Book Here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 27,
                    ),
                  ),
                  onChanged: (title) {
                    searchProvider.searchBooks(title);
                  },
                  onFieldSubmitted: (value) {
                    final title = searchProvider.controller.text.trim();
                    title.isEmpty
                        ? SnakeBars.flutterToast('Invalid Input')
                        : searchProvider.fetchBooksBySearch(title);
                  },
                ),
                Container(
                  color: Colors.orangeAccent,
                  height: 420,
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
                        if (index == searchProvider.booksList.length &&
                            searchProvider.isFetching) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                            });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.r,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Famous Authors',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 30.r,
                        ),
                        Text(
                          'Categories',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.r,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10.w,
                              runSpacing: 7.h,
                              children: _cards.getCardList(context),
                            ),
                          ),
                        )
                      ],
                    ),
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

///Integrating debouncing method for the search
///and make the UI set
