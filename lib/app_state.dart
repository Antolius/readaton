import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class AppState {
  final AppSection currentSection;
  final bool isBooted;
  final Map<String, Book> books;
  final Map<String, Author> authors;
  final Map<String, ReadingProgression> progressions;
  final BooksListPageState booksListPage;
  final BookEditorPageState bookEditorPage;

  AppState({
    this.currentSection,
    this.isBooted,
    this.books,
    this.authors,
    this.progressions,
    this.booksListPage,
    this.bookEditorPage,
  });

  const AppState.init()
      : currentSection = AppSection.BOOKS,
        isBooted = false,
        books = const {},
        authors = const {},
        progressions = const {},
        booksListPage = const BooksListPageState(),
        bookEditorPage = const BookEditorPageState();

  AppState copyWith({
    AppSection currentSection,
    bool isBooted,
    Map<String, Book> books,
    Map<String, Author> authors,
    Map<String, ReadingProgression> progressions,
    BooksListPageState booksListPage,
    BookEditorPageState bookEditorPage,
  }) =>
      new AppState(
        currentSection: currentSection ?? this.currentSection,
        isBooted: isBooted ?? this.isBooted,
        books: books ?? this.books,
        authors: authors ?? this.authors,
        progressions: progressions ?? this.progressions,
        booksListPage: booksListPage ?? this.booksListPage,
        bookEditorPage: bookEditorPage ?? this.bookEditorPage,
      );
}

class BookEditorPageState {
  final String addedAuthorId;

  const BookEditorPageState({this.addedAuthorId});

  BookEditorPageState copyWith({String addedAuthorId}) =>
      new BookEditorPageState(
          addedAuthorId: addedAuthorId ?? this.addedAuthorId);
}

enum ReadingStatus { UNTOUCHED, READING, FINISHED }
enum BooksSortParam { LAST_READ, FRACTION_DONE }
enum SortDirection { ASC, DESC }

class BooksListPageState {
  final Optional<ReadingStatus> statusFilter;
  final BooksSortParam sortBy;
  final SortDirection sortDirection;

  const BooksListPageState({
    this.statusFilter = const Optional.absent(),
    this.sortBy = BooksSortParam.LAST_READ,
    this.sortDirection = SortDirection.DESC,
  });

  BooksListPageState copyWith({
    Optional<ReadingStatus> statusFilter,
    BooksSortParam sortBy,
    SortDirection sortDirection,
  }) =>
      new BooksListPageState(
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
  final int numberOfPages;
  final String coverImageUrl;
  final List<String> authors;

  const Book({
    @required this.title,
    this.subtitle = '',
    this.synopsis = '',
    @required this.numberOfPages,
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
