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
  final StatsDashboardPageState statsDashboardPage;

  AppState({
    this.currentSection,
    this.isBooted,
    this.books,
    this.authors,
    this.progressions,
    this.booksListPage,
    this.bookEditorPage,
    this.statsDashboardPage,
  });

  const AppState.init()
      : currentSection = AppSection.BOOKS,
        isBooted = false,
        books = const {},
        authors = const {},
        progressions = const {},
        booksListPage = const BooksListPageState(),
        bookEditorPage = const BookEditorPageState(),
        statsDashboardPage = const StatsDashboardPageState();

  AppState copyWith({
    AppSection currentSection,
    bool isBooted,
    Map<String, Book> books,
    Map<String, Author> authors,
    Map<String, ReadingProgression> progressions,
    BooksListPageState booksListPage,
    BookEditorPageState bookEditorPage,
    StatsDashboardPageState statsDashboardPage,
  }) =>
      new AppState(
        currentSection: currentSection ?? this.currentSection,
        isBooted: isBooted ?? this.isBooted,
        books: books ?? this.books,
        authors: authors ?? this.authors,
        progressions: progressions ?? this.progressions,
        booksListPage: booksListPage ?? this.booksListPage,
        bookEditorPage: bookEditorPage ?? this.bookEditorPage,
        statsDashboardPage: statsDashboardPage ?? this.statsDashboardPage,
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

enum DataAggregation { CUMULATIVE, INDIVIDUAL }

class StatsDashboardPageState {
  final DataAggregation pagesReadAggregation;

  const StatsDashboardPageState({
    this.pagesReadAggregation = DataAggregation.INDIVIDUAL,
  });

  StatsDashboardPageState copyWith({
    DataAggregation pagesReadAggregation,
  }) =>
      new StatsDashboardPageState(
        pagesReadAggregation: pagesReadAggregation ?? this.pagesReadAggregation,
      );
}

enum AppSection { BOOKS, GOALS, STATS }

class Book {
  final String title;
  final String subtitle;
  final String synopsis;
  final int numberOfPages;
  final ImageData coverImage;
  final List<String> authors;
  final String language;

  Book({
    @required this.title,
    this.subtitle = '',
    this.synopsis = '',
    final String coverImageUrl,
    @required this.numberOfPages,
    @required this.authors,
    this.language = 'unknown',
  })
      : assert(title != null),
        assert(subtitle != null),
        assert(synopsis != null),
        assert(numberOfPages != null),
        assert(authors != null),
        this.coverImage = coverImageUrl != null && coverImageUrl.isNotEmpty
            ? new UrlImageData(imageUrl: coverImageUrl)
            : const LocalImageData(
                imageName: 'assets/images/book_cover_placeholder.jpg',
              );
}

class Author {
  final String name;
  final ImageData profileImage;

  Author({
    String profileImageUrl,
    @required this.name,
  })
      : assert(name != null),
        this.profileImage =
            profileImageUrl != null && profileImageUrl.isNotEmpty
                ? new UrlImageData(imageUrl: profileImageUrl)
                : const LocalImageData(
                    imageName: 'assets/images/avatar_placeholder.png',
                  );
}

abstract class ImageData {
  const ImageData();

  T accept<T>(ImageDataVisitor<T> visitor);
}

abstract class ImageDataVisitor<T> {
  T visitUrlImage(UrlImageData urlImage);

  T visitLocalImage(LocalImageData localImage);
}

class UrlImageData extends ImageData {
  final String imageUrl;

  const UrlImageData({
    @required this.imageUrl,
  });

  @override
  T accept<T>(ImageDataVisitor<T> visitor) => visitor.visitUrlImage(this);
}

class LocalImageData extends ImageData {
  final String imageName;

  const LocalImageData({
    @required this.imageName,
  });

  @override
  T accept<T>(ImageDataVisitor<T> visitor) => visitor.visitLocalImage(this);
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
