import 'dart:math';

import 'package:readaton/app_state.dart';
import 'package:readaton/modules/boot_page/boot_page.dart';
import 'package:readaton/services/google/actions/actions.dart';
import 'package:readaton/services/google/utils/google_book_parser.dart';
import 'package:readaton/services/google/utils/search_google_books.dart';
import 'package:redux/redux.dart';

final middleware = <MiddlewareBinding<AppState, dynamic>>[
  _mockBooksOnBoot,
  _completeBootOnMocksCompletion,
];

final appMiddleware = combineTypedMiddleware<AppState>(middleware);

final _mockBooksOnBoot =
    new MiddlewareBinding<AppState, BootAppAction>((store, action, next) async {
  next(action);

  var googleResponse = await searchFor('Red Mars');
  Map<String, Book> books = {};
  Map<String, Author> authors = {};
  for (Map<String, dynamic> googleBook in googleResponse['items']) {
    final pageCount = googleBook['volumeInfo']['pageCount'];
    if (pageCount != null && pageCount > 0) {
      new GoogleBookParser(googleBook).populate(books, authors);
    }
  }
  store.dispatch(new MockAction(
    mockBooks: books,
    mockAuthors: authors,
    mockProgressions: _mockProgressionsFor(books),
  ));
});

final _completeBootOnMocksCompletion =
    new MiddlewareBinding<AppState, MockAction>((store, action, next) {
  next(action);
  store.dispatch(const AppBootedAction());
});

Map<String, ReadingProgression> _mockProgressionsFor(Map<String, Book> books) {
  Map<String, ReadingProgression> bookToProgress = {};
  final now = new DateTime.now();
  final random = new Random();
  var currentlyReadingBooks = books.keys.toList();

  for (int d = 365; d > 0; d--) {
    var readAt = now.subtract(new Duration(days: d, hours: random.nextInt(12)));
    var pagesRead = random.nextInt(50) + 1;
    var bookIndex = min(random.nextInt(3), currentlyReadingBooks.length - 1);
    var bookId = currentlyReadingBooks[bookIndex];

    if (bookToProgress.containsKey(bookId)) {
      var existingProgress = bookToProgress[bookId];
      pagesRead = min(
        pagesRead,
        books[bookId].numberOfPages - existingProgress.pagesRead,
      );
      bookToProgress[bookId] = new ReadingProgression(
        updates: []
          ..addAll(existingProgress.updates)
          ..add(new ReadingUpdate(
            madeOn: readAt,
            pagesRead: pagesRead,
          )),
      );
    } else {
      pagesRead = min(pagesRead, books[bookId].numberOfPages);
      bookToProgress[bookId] = new ReadingProgression(
        updates: [
          new ReadingUpdate(
            madeOn: readAt,
            pagesRead: pagesRead,
          )
        ],
      );
    }
    if (bookToProgress[bookId].pagesRead == books[bookId].numberOfPages) {
      currentlyReadingBooks.remove(bookId);
      if (currentlyReadingBooks.isEmpty) {
        return bookToProgress;
      }
    }
  }

  return bookToProgress;
}
