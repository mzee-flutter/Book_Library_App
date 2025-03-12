import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final Map<String, IconData> bookCategories = {
    "Money": FontAwesomeIcons.dollarSign,
    "Business": FontAwesomeIcons.briefcase,
    "Mindfulness": FontAwesomeIcons.brain,
    "Leadership": FontAwesomeIcons.userTie,
    "Wealth": FontAwesomeIcons.gem,
    "Success": FontAwesomeIcons.trophy,
    "Meditation": FontAwesomeIcons.om,
    "Habit": FontAwesomeIcons.listCheck,
    "Romance": FontAwesomeIcons.heart,
    "Philosophy": FontAwesomeIcons.book,
    "History": FontAwesomeIcons.landmark,
    "Science": FontAwesomeIcons.flask,
    "Health": FontAwesomeIcons.heartbeat,
    "Lifestyle": FontAwesomeIcons.bicycle,
    "Entrepreneurship": FontAwesomeIcons.chartLine,
    "Culture": FontAwesomeIcons.theaterMasks,
    "Psychology": FontAwesomeIcons.brain,
    "Nature": FontAwesomeIcons.tree,
    "Marketing & Sales": FontAwesomeIcons.bullhorn,
    "Religion & Spirituality": FontAwesomeIcons.prayingHands,
    "Islam": FontAwesomeIcons.mosque,
  };

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
            Container(
              color: Colors.blue,
              height: 420,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: bookCategories.entries
                          .map((entry) => CategoryCard(
                              category: entry.key, icon: entry.value))
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;

  const CategoryCard({super.key, required this.category, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: Theme.of(context)
                  .bottomNavigationBarTheme
                  .selectedIconTheme
                  ?.size,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            SizedBox(
              width: 15.r,
            ),
            Text(
              category,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
