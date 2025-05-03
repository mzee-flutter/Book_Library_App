import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/snakebars_and_popUps/snake_bars.dart';
import '../../view_model/search_view_model.dart';

class SearchScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchScreenAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchProvider, child) {
        return AppBar(
          automaticallyImplyLeading: false,
          elevation: 3,
          leading: const Icon(
            Icons.arrow_back_rounded,
          ),
          actions: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.r),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                  controller: searchProvider.controller,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search Book Here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    suffixIcon: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        searchProvider.clearSearch();
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    final title = searchProvider.controller.text.trim();
                    title.isEmpty
                        ? SnakeBars.flutterToast('Invalid Input', context)
                        : searchProvider.fetchBooksBySearch(title);
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
