import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class AppState {
  final AppSection currentSection;
  final bool isBooted;
  final Map<String, Book> books;
  final Map<String, Author> authors;
  final Map<String, ReadingProgression> progressions;
  final BooksListPage booksListPage;

  AppState({
    this.currentSection,
    this.isBooted,
    this.books,
    this.authors,
    this.progressions,
    this.booksListPage,
  });

  const AppState.init()
      : currentSection = AppSection.BOOKS,
        isBooted = false,
        books = const {},
        authors = const {},
        progressions = const {},
        booksListPage = const BooksListPage();

  AppState copyWith({
    AppSection currentSection,
    bool isBooted,
    Map<String, Book> books,
    Map<String, Author> authors,
    Map<String, ReadingProgression> progressions,
    BooksListPage booksListPage,
  }) =>
      new AppState(
        currentSection: currentSection ?? this.currentSection,
        isBooted: isBooted ?? this.isBooted,
        books: books ?? this.books,
        authors: authors ?? this.authors,
        progressions: progressions ?? this.progressions,
        booksListPage: booksListPage ?? this.booksListPage,
      );
}

enum ReadingStatus { UNTOUCHED, READING, FINISHED }
enum BooksSortParam { LAST_READ, FRACTION_DONE }
enum SortDirection { ASC, DESC }

class BooksListPage {
  final Optional<ReadingStatus> statusFilter;
  final BooksSortParam sortBy;
  final SortDirection sortDirection;

  const BooksListPage({
    this.statusFilter = const Optional.absent(),
    this.sortBy = BooksSortParam.LAST_READ,
    this.sortDirection = SortDirection.DESC,
  });

  BooksListPage copyWith({
    Optional<ReadingStatus> statusFilter,
    BooksSortParam sortBy,
    SortDirection sortDirection,
  }) =>
      new BooksListPage(
        statusFilter: statusFilter ?? this.statusFilter,
        sortBy: sortBy ?? this.sortBy,
        sortDirection: sortDirection ?? this.sortDirection,
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
