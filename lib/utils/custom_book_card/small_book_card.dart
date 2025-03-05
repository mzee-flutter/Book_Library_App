import 'package:cached_network_image/cached_network_image.dart';

import 'package:BookMate_Pro/model/popular_google_books_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../book_cover_sizes.dart';

class SmallBookCard extends StatelessWidget {
  const SmallBookCard({
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookCoverSize.small(
                    bookCover: CachedNetworkImage(
                      imageUrl:
                          book.volumeInfo?.imageLinks?.getHighQualityImageUrl ??
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
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(
                            book.volumeInfo?.title ?? 'Unknown',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'Authors: ${book.volumeInfo?.authors?.join(', ') ?? 'Unknown'}',
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'PublishDate: ${book.volumeInfo?.publishedDate ?? '-/-/-'}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Publisher: ${book.volumeInfo?.publisher ?? 'Unknown'}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Subtitle: ${book.volumeInfo?.subtitle ?? 'Subtitle not available'}',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
