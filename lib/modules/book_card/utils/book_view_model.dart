import 'package:readaton/app_state.dart';
import 'package:redux/redux.dart';

class BookViewModel {
  final String id;
  final String title;
  final String subtitle;
  final List<String> authorNames;
  final String coverImageUrl;
  final int numberOfPages;
  final int numberOfReadPages;

  BookViewModel.from(Store<AppState> store, String bookId)
      : id = bookId,
        title = _book(store, bookId).title,
        subtitle = _book(store, bookId).subtitle,
        coverImageUrl = _book(store, bookId).coverImageUrl,
        authorNames = _book(store, bookId)
            .authors
            .map((authorId) => _author(store, authorId)?.name)
            .where((name) => name != null)
            .toList(growable: false),
        numberOfPages = _book(store, bookId).numbedOfPages,
        numberOfReadPages = _progression(store, bookId)?.pagesRead ?? 0;

  static Book _book(Store<AppState> store, String bookId) =>
      store.state.books[bookId];

  static Author _author(Store<AppState> store, String authorId) =>
      store.state.authors[authorId];

  static ReadingProgression _progression(
          Store<AppState> store, String bookId) =>
      store.state.progressions[bookId];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookViewModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
