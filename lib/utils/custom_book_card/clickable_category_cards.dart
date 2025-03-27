import 'package:BookMate_Pro/view/home_screen_view/more_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClickableCategoryCards {
  final Map<String, IconData> bookCategories = {
    "Money & Investment": FontAwesomeIcons.dollarSign,
    "Habit": FontAwesomeIcons.listCheck,
    "Business": FontAwesomeIcons.briefcase,
    "Success": FontAwesomeIcons.award,
    "Entrepreneurship": FontAwesomeIcons.chartLine,
    "Marketing & Sales": FontAwesomeIcons.bullhorn,
    "Culture": FontAwesomeIcons.masksTheater,
    "Leadership": FontAwesomeIcons.userTie,
    "Meditation": FontAwesomeIcons.om,
    "Motivation & Inspiration": FontAwesomeIcons.seedling,
    "Psychology": FontAwesomeIcons.userGroup,
    "Philosophy": FontAwesomeIcons.book,
    "Religion & Spirituality": FontAwesomeIcons.handsPraying,
    "Islam": FontAwesomeIcons.mosque,
    "Lifestyle": FontAwesomeIcons.bicycle,
    "Romance": FontAwesomeIcons.heart,
    "Nature & Environment": FontAwesomeIcons.tree,
    "Health": FontAwesomeIcons.heartPulse,
    "Mindfulness": FontAwesomeIcons.brain,
    "History": FontAwesomeIcons.landmark,
    "Science": FontAwesomeIcons.flask,
    "Wealth": FontAwesomeIcons.gem,
    "Conversation & Communication": FontAwesomeIcons.commentDots,
  };

  /// the genres works perfectly...

  List<Widget> getCardList(context) {
    final cardList = bookCategories.entries
        .map(
          (entry) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MoreBooksScreen(
                    category: entry.key,
                    name: entry.key,
                  ),
                ),
              );
            },
            child: CategoryCard(category: entry.key, icon: entry.value),
          ),
        )
        .toList();
    return cardList;
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;

  const CategoryCard({super.key, required this.category, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
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
