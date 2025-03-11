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
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: bookCategories.entries
                  .map((entry) =>
                      CategoryCard(category: entry.key, icon: entry.value))
                  .toList(),
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

  const CategoryCard({required this.category, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Container(
        width: 120,
        height: 120,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              category,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
