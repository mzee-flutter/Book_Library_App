import 'package:flutter/material.dart';

class ProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileScreenAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Profile',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
