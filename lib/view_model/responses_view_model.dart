import 'package:BookMate_Pro/repository/responses_repository/main_chapter_response_repository.dart';
import 'package:BookMate_Pro/repository/responses_repository/sub_chapter_response_respository.dart';
import 'package:BookMate_Pro/repository/responses_repository/sub_topics-response_repository.dart';
import 'package:BookMate_Pro/repository/responses_repository/translation_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../view/single_book_screen/customize_book_reading_screen.dart';

class ResponsesViewModel with ChangeNotifier {
  ResponsesViewModel() {
    initTts();
  }
  final FlutterTts _flutterTts = FlutterTts();
  final MainChapterResponseRepository _responseRepo =
      MainChapterResponseRepository();
  final SubChapterResponseRepository _subChapterResponseRepo =
      SubChapterResponseRepository();
  final SubTopicsResponseRepository _subTopicsResponseRepo =
      SubTopicsResponseRepository();
  final TranslationRepository _translationRepository = TranslationRepository();

  String _response = '';
  String get response => _response;

  String _selectedLanguage = 'en';
  String get selectedLanguage => _selectedLanguage;

  String _translatedText = '';
  String get translatedText => _translatedText;
  bool _isTranslating = false;
  bool get isTranslating => _isTranslating;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  bool _isTranslated = false;
  bool get isTranslated => _isTranslated;

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;
  String _processedTextForTTS = ''; // Clean text for speech

  void toggleTranslation() {
    _isTranslated = !_isTranslated;
    notifyListeners();
  }

  String get currentText => _isTranslated ? translatedText : _response;

  void initTts() {
    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });

    _flutterTts.setCancelHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  /// **Fix TTS Language Switching Issue**
  Future<void> toggleSpeak() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      notifyListeners();
    } else {
      await _flutterTts.stop(); // Reset TTS
      await _flutterTts.setLanguage(selectedLanguage);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.4);

      // Get cleaned text for TTS (no markdown/symbols)
      String speechText = getProcessedTextForTTS();
      int result = await _flutterTts.speak(speechText);
      if (result == 1) {
        _isSpeaking = true;
        notifyListeners();
      }
    }
  }

  /// **Fetch Chapter Response**
  Future<void> fetchAnyResponse(
      String title, List<String> itsSubChapters, ResponseType type) async {
    _isFetching = true;
    notifyListeners();

    try {
      switch (type) {
        case ResponseType.chapter:
          _response =
              await _responseRepo.fetchChaptersResponse(title, itsSubChapters);
          break;
        case ResponseType.subChapter:
          _response = await _subChapterResponseRepo.fetchSubChaptersResponse(
              title, itsSubChapters);
          break;
        case ResponseType.subTopics:
          _response = await _subTopicsResponseRepo.fetchSubTopicsResponse(
              title, itsSubChapters);
          break;
      }

      _translatedText = '';
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Chapter-view-model Error: ${e.toString()}');
      }
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  void updateLanguage(String languageCode) {
    _selectedLanguage = languageCode;
    notifyListeners();
  }

  /// **Translate Response**
  Future<void> translateResponse() async {
    if (_response.isEmpty) return;

    _isTranslating = true;
    notifyListeners();

    try {
      final translation = await _translationRepository.translateText(
          _response, "en", _selectedLanguage);
      _translatedText = translation;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Translation Error: ${e.toString()}');
      }
      _translatedText = "Translation failed.";
    } finally {
      _isTranslating = false;
      notifyListeners();
    }
  }

  /// **Process Text for UI and TTS**
  List<InlineSpan> processText(String inputText, BuildContext context) {
    String textWithoutHash = inputText
        .replaceAll(RegExp(r'^\s*#*\s*-?\s*', multiLine: true), '')
        .trim();

    List<InlineSpan> spans = [];
    _processedTextForTTS = ''; // Reset clean text

    RegExp exp = RegExp(r"(```[\s\S]*?```)|(\*\*.+?\*\*)|(\*.+?\*)|([^*`]+)");
    Iterable<RegExpMatch> matches = exp.allMatches(textWithoutHash);

    for (var match in matches) {
      String matchText = match.group(0)!;

      if (matchText.startsWith("**") && matchText.endsWith("**")) {
        spans.add(
          TextSpan(
            text: matchText.replaceAll("**", "").trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Serif',
                  fontSize: 16,
                ),
          ),
        );
      } else if (matchText.startsWith("*") && matchText.endsWith("*")) {
        spans.add(
          TextSpan(
            text: matchText.replaceAll("*", "").trim(),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$matchText\n',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 15, fontFamily: 'Serif'),
          ),
        );
      }

      // Store clean text for TTS (remove special symbols)
      _processedTextForTTS += '$matchText ';
    }

    // Remove symbols from TTS text
    _processedTextForTTS =
        _processedTextForTTS.replaceAll(RegExp(r'[^\w\s]'), '');

    return spans;
  }

  /// **Get Processed Text for TTS**
  String getProcessedTextForTTS() => _processedTextForTTS;
}
