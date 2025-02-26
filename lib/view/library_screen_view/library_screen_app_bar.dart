import 'package:flutter/material.dart';

class LibraryScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const LibraryScreenAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'My Library',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
