import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BooksCategoryAndMore extends StatelessWidget {
  const BooksCategoryAndMore({
    super.key,
    required this.categoryName,
    required this.categoryDescription,
    required this.categoryIcon,
    required this.onTap,
  });

  final String categoryName;
  final String categoryDescription;
  final IconData categoryIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.cyan.withOpacity(0.3),
          ),
          onPressed: () {},
          icon: Icon(
            categoryIcon,
            size: 30,
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: SizedBox(
            height: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 240.w,
                      child: Text(
                        categoryName,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onTap,
                      child: Text(
                        'More',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: 220.w,
                    child: Text(
                      categoryDescription,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
