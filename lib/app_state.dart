import 'package:flutter/foundation.dart';

class AppState {
  final AppSection currentSection;
  final bool isBooted;
  final Map<String, Book> books;
  final Map<String, Author> authors;
  final Map<String, ReadingProgression> progressions;

  AppState({
    this.currentSection,
    this.isBooted,
    this.books,
    this.authors,
    this.progressions,
  });

  const AppState.init()
      : currentSection = AppSection.BOOKS,
        isBooted = false,
        books = const {},
        authors = const {},
        progressions = const {};

  AppState copyWith({
    AppSection currentSection,
    bool isBooted,
    Map<String, Book> books,
    Map<String, Author> authors,
    Map<String, ReadingProgression> progressions,
  }) =>
      new AppState(
        currentSection: currentSection ?? this.currentSection,
        isBooted: isBooted ?? this.isBooted,
        books: books ?? this.books,
        authors: authors ?? this.authors,
        progressions: progressions ?? this.progressions,
      );
}

enum AppSection { BOOKS, GOALS, STATS }

class Book {
  final String title;
  final String subtitle;
  final String synopsis;
  final int numbedOfPages;
  final String coverImageUrl;
  final List<String> authors;

  const Book({
    @required this.title,
    this.subtitle = '',
    this.synopsis = '',
    @required this.numbedOfPages,
    @required this.coverImageUrl,
    @required this.authors,
  });
}

class Author {
  final String name;
  final String imageUrl;

  const Author({
    @required this.name,
    this.imageUrl = '',
  });
}

class ReadingProgression {
  final List<ReadingUpdate> updates;

  int get pagesRead => updates.fold(0, (sum, next) => sum + next.pagesRead);

  ReadingProgression({
    @required this.updates,
  });

  ReadingProgression copyWithUpdate({
    @required ReadingUpdate update,
  }) =>
      new ReadingProgression(
        updates: this.updates..add(update),
      );
}

class ReadingUpdate {
  final DateTime madeOn;
  final int pagesRead;

  const ReadingUpdate({
    @required this.madeOn,
    @required this.pagesRead,
  });
}