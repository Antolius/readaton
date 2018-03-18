import 'package:quiver/core.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_card/actions/actions.dart';
import 'package:redux/redux.dart';

class BookViewModel {
  final Store<AppState> _store;
  final String id;
  final String title;
  final String subtitle;
  final List<String> authorNames;
  final String coverImageUrl;
  final int numberOfPages;
  final int numberOfReadPages;
  final Optional<DateTime> lastReadOn;

  BookViewModel.from(this._store, String bookId)
      : id = bookId,
        title = _book(_store, bookId).title,
        subtitle = _book(_store, bookId).subtitle,
        coverImageUrl = _book(_store, bookId).coverImageUrl,
        authorNames = _book(_store, bookId)
            .authors
            .map((authorId) => _author(_store, authorId)?.name)
            .where((name) => name != null)
            .toList(growable: false),
        numberOfPages = _book(_store, bookId).numbedOfPages,
        numberOfReadPages = _progression(_store, bookId)?.pagesRead ?? 0,
        lastReadOn = _lastUpdate(_progression(_store, bookId))
            .transform((update) => update.madeOn);

  void onReadingUpdate(int pagesRead) {
    if (pagesRead == null) return;
    _store.dispatch(new UpdateReadingProgressAction(id, pagesRead));
  }

  static Book _book(Store<AppState> store, String bookId) =>
      store.state.books[bookId];

  static Author _author(Store<AppState> store, String authorId) =>
      store.state.authors[authorId];

  static ReadingProgression _progression(
          Store<AppState> store, String bookId) =>
      store.state.progressions[bookId];

  static Optional<ReadingUpdate> _lastUpdate(ReadingProgression progression) {
    try {
      return new Optional.fromNullable(progression?.updates?.last);
    } on StateError catch (_) {
      return new Optional.absent();
    }
  }

  ReadingStatus get status => numberOfReadPages == 0
      ? ReadingStatus.UNTOUCHED
      : numberOfReadPages < numberOfPages
          ? ReadingStatus.READING
          : ReadingStatus.FINISHED;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookViewModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
