import 'package:BookMate_Pro/view/single_book_screen/outline_tab_view.dart';
import 'package:BookMate_Pro/view_model/app_themes_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../view_model/author_info_view_model/author_books_view_model.dart';
import '../../view_model/book_mark_view_model.dart';
import '../../view_model/deep_seek_summary_view_model.dart';
import '../../view_model/tab_bar_view_model.dart';
import 'package:BookMate_Pro/utils/book_cover_sizes.dart';
import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import 'about_tab_view.dart';

class SingleBookScreen extends StatefulWidget {
  const SingleBookScreen({
    super.key,
    required this.fullBook,
  });

  final Book fullBook;

  @override
  SingleBookScreenState createState() => SingleBookScreenState();
}

class SingleBookScreenState extends State<SingleBookScreen>
    with SingleTickerProviderStateMixin {
  Book get fullBook => widget.fullBook;

  @override
  void initState() {
    final authorBooksProvider =
        Provider.of<AuthorBooksViewModel>(context, listen: false);
    final summaryProvider =
        Provider.of<DeepSeekSummaryViewModel>(context, listen: false);
    final tabProvider = Provider.of<TabBarViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabProvider.setIndex(0);
      final author = fullBook.volumeInfo?.authors;
      if (author != null && author.isNotEmpty) {
        authorBooksProvider.fetchAuthorBooks(author.first, reset: true);
        final title = fullBook.volumeInfo!.title.toString();
        summaryProvider.fetchBookSummary(title, reset: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: CustomScrollView(
          slivers: [
            Consumer<AppThemesViewModel>(
              builder: (context, themeProvider, child) {
                return SliverAppBar(
                  floating: false,
                  snap: false,
                  stretch: false,
                  backgroundColor:
                      themeProvider.getSliverAppBarBackgroundColor(context),
                  clipBehavior: Clip.none,
                  iconTheme: const IconThemeData(size: 25),
                  expandedHeight: 300,
                  pinned: true,
                  centerTitle: true,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      double percent =
                          (constraints.maxHeight - kToolbarHeight) /
                              (300 - kToolbarHeight);
                      double opacity = (1 - percent).clamp(0.0, 1.0);

                      return Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          FlexibleSpaceBar(
                            centerTitle: true,
                            title: AnimatedOpacity(
                              opacity: opacity,
                              duration: const Duration(milliseconds: 200),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    widget.fullBook.volumeInfo?.title ??
                                        'Unknown',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            background: Center(
                              child: BookCoverSize.large(
                                bookCover: CachedNetworkImage(
                                  imageUrl: widget
                                          .fullBook
                                          .volumeInfo
                                          ?.imageLinks
                                          ?.getHighQualityImageUrl ??
                                      'No_image',
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  placeholder: (context, url) =>
                                      Image.asset('images/bookcover.png'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('images/placeholder.png'),
                                ),
                              ),
                            ),
                          ),
                          Consumer<BookMarkViewModel>(
                            builder: (context, bookMarkProvider, child) {
                              bool isBookmarked = bookMarkProvider
                                  .isBookmarked(widget.fullBook);
                              return Positioned(
                                bottom: -25.r,
                                right: 25.r,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    if (isBookmarked) {
                                      bookMarkProvider
                                          .removeBookmark(widget.fullBook);
                                    } else {
                                      bookMarkProvider
                                          .addBookMark(widget.fullBook);
                                    }
                                  },
                                  shape: const CircleBorder(),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  elevation: 5,
                                  child: Icon(
                                    isBookmarked
                                        ? FontAwesomeIcons.solidBookmark
                                        : FontAwesomeIcons.bookmark,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20.h),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Consumer<TabBarViewModel>(
                  builder: (context, tabProvider, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullBook.volumeInfo?.title ?? 'Unknown',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15.r),
                          Text(
                            fullBook.volumeInfo?.subtitle ??
                                'Subtitle not available',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Serif'),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            fullBook.volumeInfo?.authors?.join(', ') ??
                                'Unknown',
                            style: const TextStyle(fontFamily: 'Roboto'),
                          ),
                          SizedBox(height: 15.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              indicatorWeight: 1,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              unselectedLabelColor: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                              indicator: UnderlineTabIndicator(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 17),
                              labelPadding: EdgeInsets.only(right: 18.r),
                              tabs: const [
                                Tab(text: 'About'),
                                Tab(text: 'Outline'),
                                Tab(text: 'More like this'),
                              ],
                              onTap: (index) {
                                tabProvider.toggleTab(index);
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          IndexedStack(
                            index: tabProvider.selectedTab,
                            children: [
                              AboutTabView(fullBook: fullBook),
                              const OutlineTabView(),
                              const Text('tab 3'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
