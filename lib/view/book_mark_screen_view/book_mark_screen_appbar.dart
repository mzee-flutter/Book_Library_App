import 'package:flutter/material.dart';

class BookMarkScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookMarkScreenAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'BookMarks',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
