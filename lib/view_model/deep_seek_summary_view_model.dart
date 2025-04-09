import 'package:BookMate_Pro/model/deep_seek_book_summary_model.dart';
import 'package:BookMate_Pro/repository/deepseek_summary_repository.dart';
import 'package:flutter/foundation.dart';

import '../model/book_summary_model.dart';

class DeepSeekSummaryViewModel with ChangeNotifier {
  final DeepSeekSummaryRepository _summaryRepo = DeepSeekSummaryRepository();
  final List<Chapter> _chapterList = [];

  List<Chapter> get chapterList => _chapterList;

  bool _isFetching = false;
  bool get isFetching => _isFetching;
  Future<void> fetchBookSummary(String title, {bool reset = false}) async {
    try {
      if (reset) {
        _chapterList.clear();
      }
      _isFetching = true;
      notifyListeners();
      final response = await _summaryRepo.fetchBookSummary(title);

      _chapterList.addAll(response.chapters ?? []);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
