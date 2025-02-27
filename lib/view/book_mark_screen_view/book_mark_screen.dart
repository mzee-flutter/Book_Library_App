import 'package:flutter/material.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  BookMarkScreenState createState() => BookMarkScreenState();
}

class BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'This is the bookmark-page',
        ),
      ),
    );
  }
}
