import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'For You',
        style: Theme.of(context).textTheme.displayLarge,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.bell),
        ),
        IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            FontAwesomeIcons.bars,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

///whenever we want to have a custom appbar then we must have to implements the PreferredSizeWidget-class
///and also we have to specify the height of appbar which we specify as kToolbarHeight
///kToolbarHeight is standard from the flutter value is: 56 logical pixels.
