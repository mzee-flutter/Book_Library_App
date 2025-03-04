import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:BookMate_Pro/utils/book_cover_sizes.dart';

class MediumBookCard extends StatelessWidget {
  const MediumBookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookCoverSize.medium(
            bookCover: CachedNetworkImage(
              imageUrl: book.volumeInfo?.imageLinks?.getHighQualityImageUrl ??
                  'No_image',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              placeholder: (context, url) => Image.asset(
                'images/bookcover.png',
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                'images/placeholder.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    book.volumeInfo?.title ?? 'Unknown',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(height: 1.1),
                  ),
                ),
                SizedBox(
                  height: 3.r,
                ),
                Text(
                  book.volumeInfo!.authors!.join(', ').toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book.volumeInfo?.subtitle ?? 'Not available',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
