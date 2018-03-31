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
  var googleBooks = googleResponse['items'].take(3);
  Map<String, Book> books = {};
  Map<String, Author> authors = {};
  for (Map<String, dynamic> googleBook in googleBooks) {
    final pageCount = googleBook['volumeInfo']['pageCount'];
    if (pageCount != null && pageCount > 0) {
      new GoogleBookParser(googleBook).populate(books, authors);
    }
  }
  store.dispatch(new MockAction(
    mockBooks: books,
    mockAuthors: authors,
//    mockProgressions: _mockProgressionsFor(books),
  ));
});

final _completeBootOnMocksCompletion =
    new MiddlewareBinding<AppState, MockAction>((store, action, next) {
  next(action);
  store.dispatch(const AppBootedAction());
});

Map<String, ReadingProgression> _mockProgressionsFor(Map<String, Book> books) {
  final now = new DateTime.now();
  final random = new Random();
  final _rnd10 = () => random.nextInt(10);
  final _rndDateTime = () => now.subtract(new Duration(
        days: _rnd10(),
        hours: _rnd10(),
        minutes: _rnd10(),
      ));
  final _rndUpdate = (Book book) => new ReadingUpdate(
        madeOn: _rndDateTime(),
        pagesRead: random.nextInt((book.numberOfPages / 3).ceil()),
      );

  Map<String, ReadingProgression> progression = {};
  //mock in progress books:
  for (String id in books.keys.skip(3).take(3)) {
    final book = books[id];
    progression.putIfAbsent(id, () {
      return new ReadingProgression(
        updates: [_rndUpdate(book), _rndUpdate(book)],
      );
    });
  }
  //mock read books:
  for (String id in books.keys.skip(6)) {
    final book = books[id];
    progression.putIfAbsent(id, () {
      return new ReadingProgression(
        updates: [
          new ReadingUpdate(
            madeOn: _rndDateTime().subtract(new Duration(days: 20)),
            pagesRead: book.numberOfPages,
          )
        ],
      );
    });
  }
  return progression;
}
