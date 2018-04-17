import 'package:readaton/state/domain/author.dart';
import 'package:readaton/state/domain/book.dart';
import 'package:readaton/state/domain/reading_progression.dart';
import 'package:readaton/state/domain/user.dart';
import 'package:readaton/state/ui/book_editor.dart';
import 'package:readaton/state/ui/books_import.dart';
import 'package:readaton/state/ui/books_list.dart';
import 'package:readaton/state/ui/stats_dashboard.dart';

class AppState {
  final AppSection currentSection;
  final bool isBooted;
  final Map<String, Book> books;
  final Map<String, Author> authors;
  final Map<String, ReadingProgression> progressions;
  final BooksListPageState booksListPage;
  final BookEditorPageState bookEditorPage;
  final StatsDashboardPageState statsDashboardPage;
  final UserState userState;
  final BooksImportPageState booksImportPage;

  AppState({
    this.currentSection,
    this.isBooted,
    this.books,
    this.authors,
    this.progressions,
    this.booksListPage,
    this.bookEditorPage,
    this.statsDashboardPage,
    this.userState,
    this.booksImportPage,
  });

  const AppState.init()
      : currentSection = AppSection.BOOKS,
        isBooted = false,
        books = const {},
        authors = const {},
        progressions = const {},
        booksListPage = const BooksListPageState(),
        bookEditorPage = const BookEditorPageState(),
        statsDashboardPage = const StatsDashboardPageState(),
        userState = const UserState(),
        booksImportPage = const BooksImportPageState();

  AppState copyWith({
    AppSection currentSection,
    bool isBooted,
    Map<String, Book> books,
    Map<String, Author> authors,
    Map<String, ReadingProgression> progressions,
    BooksListPageState booksListPage,
    BookEditorPageState bookEditorPage,
    StatsDashboardPageState statsDashboardPage,
    UserState userState,
    BooksImportPageState booksImportPageState,
  }) {
    var newState = new AppState(
      currentSection: currentSection ?? this.currentSection,
      isBooted: isBooted ?? this.isBooted,
      books: books ?? this.books,
      authors: authors ?? this.authors,
      progressions: progressions ?? this.progressions,
      booksListPage: booksListPage ?? this.booksListPage,
      bookEditorPage: bookEditorPage ?? this.bookEditorPage,
      statsDashboardPage: statsDashboardPage ?? this.statsDashboardPage,
      userState: userState ?? this.userState,
      booksImportPage: booksImportPageState ?? this.booksImportPage,
    );
    return newState;
  }
}

enum AppSection { BOOKS, GOALS, STATS }

enum Platform { GOODREADS, ISBN, ISBN13 }
