import 'package:BookMate_Pro/view_model/google_books_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:BookMate_Pro/utils/book_cover_sizes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<GoogleBooksViewModel>(context);
    final book = bookProvider.allBooks[3];
    return SafeArea(
      child: BookCoverSize.large(
        bookCover: CachedNetworkImage(
          imageUrl:
              book.volumeInfo!.imageLinks!.getHighQualityImageUrl.toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
