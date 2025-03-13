import 'package:BookMate_Pro/utils/custom_book_card/clickable_category_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final ClickableCategoryCards _cards = ClickableCategoryCards();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
          vertical: 15.r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Theme.of(context).colorScheme.inversePrimary,
                hintText: 'Search Book Here...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 27,
                ),
              ),
            ),
            SizedBox(
              height: 40.r,
            ),
            Text(
              'Famous Authors',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 30.r,
            ),
            Text(
              'Categories',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.r,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 7,
                    children: _cards.getCardList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
