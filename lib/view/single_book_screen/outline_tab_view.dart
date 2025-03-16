import 'package:BookMate_Pro/view/single_book_screen/customize_book_reading_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../view_model/app_themes_view_model.dart';
import '../../view_model/deep_seek_summary_view_model.dart';

class OutlineTabView extends StatelessWidget {
  const OutlineTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DeepSeekSummaryViewModel>(
      builder: (context, provider, child) {
        if (provider.isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (provider.chapterList.isEmpty) {
          return const Center(
            child: Text('No Valid content is available'),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: provider.chapterList.map((chapter) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.r),
                child: Consumer<AppThemesViewModel>(
                  builder: (context, themeProvider, child) {
                    return ExpansionTile(
                      collapsedBackgroundColor:
                          themeProvider.getSliverAppBarBackgroundColor(context),
                      collapsedShape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      title: InkWell(
                        onTap: () {
                          final subChaptersName = chapter.subChapters
                              .map((subChapter) => subChapter.topic)
                              .toList();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomizeBookReadingScreen(
                                  title: chapter.chapterName,
                                  itsSubChapter: subChaptersName,
                                  responseType: ResponseType.chapter),
                            ),
                          );
                        },
                        child: Text(
                          chapter.chapterName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 17),
                        ),
                      ),
                      children: chapter.subChapters.map((subChapter) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.r),
                          child: ExpansionTile(
                            collapsedBackgroundColor: themeProvider
                                .getSliverAppBarBackgroundColor(context),
                            title: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CustomizeBookReadingScreen(
                                        title: subChapter.topic,
                                        itsSubChapter: subChapter.subTopics,
                                        responseType: ResponseType.subChapter),
                                  ),
                                );
                              },
                              child: Text(
                                subChapter.topic,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            collapsedShape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            children: subChapter.subTopics.map((subTopic) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.r),
                                child: ListTile(
                                  tileColor: themeProvider
                                      .getSliverAppBarBackgroundColor(context),
                                  title: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CustomizeBookReadingScreen(
                                                  title: subTopic,
                                                  itsSubChapter:
                                                      subChapter.subTopics,
                                                  responseType:
                                                      ResponseType.subTopics),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      subTopic,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

///Just testing the subChapter response with the customize class
