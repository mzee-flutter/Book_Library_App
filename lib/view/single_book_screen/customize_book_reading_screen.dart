import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:BookMate_Pro/view_model/responses_view_model.dart';
import '../../../view_model/language_dropdown_view_model.dart';

enum ResponseType { chapter, subChapter, subTopics }

/// we only need to pass 3 things to this class
/// 1: chapter or topic name
/// 2: its sub-chapters or subTopics name
/// 3: its the ResponseType means these MainChapter or SubChapters orTopics.
/// we will use this class to all three type of responses
class CustomizeBookReadingScreen extends StatefulWidget {
  const CustomizeBookReadingScreen({
    super.key,
    required this.title,
    required this.itsSubChapter,
    required this.responseType,
  });

  final String title;
  final List<String> itsSubChapter;
  final ResponseType responseType;

  @override
  BookReadingScreenState createState() => BookReadingScreenState();
}

class BookReadingScreenState extends State<CustomizeBookReadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        final responseProvider =
            Provider.of<ResponsesViewModel>(context, listen: false);
        responseProvider.fetchAnyResponse(
            widget.title, widget.itsSubChapter, widget.responseType);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageDropDownViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 8.r),
            child: Consumer<ResponsesViewModel>(
              builder: (context, responseProvider, child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        languageProvider.getLanguageDropdown(
                          context,
                          (language) {
                            final languageValue =
                                languageProvider.languageMap[language] ?? 'en';
                            responseProvider.updateLanguage(languageValue);
                            if (responseProvider.isTranslated) {
                              responseProvider.translateResponse();
                            }
                          },
                        ),
                        ElevatedButton(
                          onPressed: responseProvider.selectedLanguage == 'en'
                              ? null
                              : () {
                                  responseProvider.toggleTranslation();

                                  if (responseProvider.isTranslated) {
                                    responseProvider.translateResponse();
                                  } else {
                                    languageProvider.updateLanguage('English');
                                    responseProvider.updateLanguage('en');
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                responseProvider.selectedLanguage == 'en'
                                    ? Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .unselectedItemColor
                                    : Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              responseProvider.isTranslated
                                  ? 'Show Original'
                                  : 'Translate',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Translation are limited use it wisely',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 20.r,
                    ),
                    Consumer<ResponsesViewModel>(
                      builder: (context, responseProvider, child) {
                        if (responseProvider.isFetching) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        String displayText = responseProvider.isTranslated
                            ? responseProvider.isTranslating
                                ? "" // Empty text while loading
                                : responseProvider.translatedText.isNotEmpty
                                    ? responseProvider.translatedText
                                    : "Translation not available."
                            : responseProvider.response;

                        return SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: responseProvider.isTranslating
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    children: responseProvider.processText(
                                        displayText, context),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<ResponsesViewModel>(
        builder: (context, audioProvider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
            child: FloatingActionButton(
              onPressed: () {
                audioProvider.toggleSpeak();
              },
              child: audioProvider.isSpeaking
                  ? const Icon(Icons.square_rounded)
                  : const Icon(Icons.play_arrow_rounded),
            ),
          );
        },
      ),
    );
  }
}
