class BookSummary {
  final String bookTitle;
  final String author;
  final List<Chapter> chapters;

  BookSummary({
    required this.bookTitle,
    required this.author,
    required this.chapters,
  });

  factory BookSummary.fromJson(Map<String, dynamic> json) {
    return BookSummary(
      author: json['author'] ?? '',
      bookTitle: json['bookTitle'] ?? json['title'] ?? '', // Handle both cases
      chapters: (json['chapters'] ?? json['chapters_list'] ?? [])
          .map<Chapter>((item) => Chapter.fromJson(item))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'bookTitle': bookTitle,
      'author': author,
      'chapters': chapters.map((chapter) => chapter.toJson()).toList(),
    };
  }
}

class Chapter {
  final String chapterName;
  final List<SubChapter> subChapters;

  Chapter({
    required this.chapterName,
    required this.subChapters,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterName: json['chapterName'] ?? json['chapter_name'] ?? '',
      subChapters: (json['subChapters'] ?? json['sub_chapters'] ?? [])
          .map<SubChapter>((item) => SubChapter.fromJson(item))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'chapterName': chapterName,
      'subChapters':
          subChapters.map((subChapter) => subChapter.toJson()).toList(),
    };
  }
}

class SubChapter {
  final String topic;
  final List<String> subTopics;

  SubChapter({
    required this.topic,
    required this.subTopics,
  });

  factory SubChapter.fromJson(Map<String, dynamic> json) {
    return SubChapter(
      topic: json['topic'] ?? json['sub_topic'] ?? 'Untitled Topic',
      subTopics: (json['subTopics'] ?? json['sub_topics'] ?? [])
          .map<String>((subTopic) => subTopic.toString()) // Ensure List<String>
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'subTopics': subTopics,
    };
  }
}
