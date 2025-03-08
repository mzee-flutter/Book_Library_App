import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Enum for different book card sizes
enum BookCardType { small, medium, large }

class BookCoverSize extends StatelessWidget {
  final BookCardType type;
  final Widget child;

  /// Constructor
  const BookCoverSize({
    super.key,
    required this.type,
    required this.child,
  });

  /// Factory constructors for different sizes
  factory BookCoverSize.small({required Widget bookCover}) {
    return BookCoverSize(
      type: BookCardType.small,
      child: bookCover,
    );
  }

  factory BookCoverSize.medium({required Widget bookCover}) {
    return BookCoverSize(
      type: BookCardType.medium,
      child: bookCover,
    );
  }

  factory BookCoverSize.large({required Widget bookCover}) {
    return BookCoverSize(
      type: BookCardType.large,
      child: bookCover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = _getDimensions();

    return Center(
      child: SizedBox(
        width: dimensions["containerWidth"],
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: dimensions["containerWidth"],
              height: dimensions["containerHeight"],
            ),

            // D-Shaped Background
            Positioned(
              bottom: 0,
              child: Container(
                width: dimensions["containerWidth"],
                height: dimensions["bottomContainerHeight"],
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
              ),
            ),

            // Book Cover Image
            Positioned(
              top: dimensions["imageTopPadding"],
              child: Container(
                width: dimensions["imageWidth"],
                height: dimensions["imageHeight"],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the dimensions based on the selected type
  Map<String, dynamic> _getDimensions() {
    switch (type) {
      case BookCardType.small:
        return {
          "containerWidth": 120.w,
          "containerHeight": 160.h,
          "bottomContainerHeight": 65.h,
          "imageWidth": 80.w,
          "imageHeight": 130.h,
          "imageTopPadding": 15.h,
          "textWidth": 100.w,
        };

      case BookCardType.medium:
        return {
          "containerWidth": 165.w,
          "containerHeight": 190.h,
          "bottomContainerHeight": 80.h,
          "imageWidth": 110.w,
          "imageHeight": 170.h,
          "imageTopPadding": 5.h,
          "textWidth": 120.w,
        };

      case BookCardType.large:
        return {
          "containerWidth": 200.w,
          "containerHeight": 240.h,
          "bottomContainerHeight": 100.h,
          "imageWidth": 140.w,
          "imageHeight": 210.h,
          "imageTopPadding": 10.h,
          "textWidth": 160.w,
        };

      default:
        return {};
    }
  }
}
