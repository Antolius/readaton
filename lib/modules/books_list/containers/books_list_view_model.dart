import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/books_list/actions/actions.dart';
import 'package:redux/redux.dart';

class BooksListViewModel {
  final Store<AppState> _store;
  final List<String> bookIds;
  final int totalBooksCount;

  BooksListViewModel.from(this._store)
      : bookIds = _extractBookIds(_store),
        totalBooksCount = _store.state.books.length;

  BooksListPage get page => _store.state.booksListPage;

  bool get isNotEmpty => bookIds.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksListViewModel &&
          runtimeType == other.runtimeType &&
          listEquals(bookIds, other.bookIds);

  @override
  int get hashCode =>
      bookIds.fold(19, (hash, next) => hash * 31 + next.hashCode);

  void filter(ReadingStatus newFilter) {
    final newPageSpec = _store.state.booksListPage.copyWith(
      statusFilter: new Optional.fromNullable(newFilter),
    );
    _store.dispatch(new UpdateBooksListPageAction(newPageSpec));
  }

  void sort(BooksSortParam newParam, SortDirection newDirection) {
    final newPageSpec = _store.state.booksListPage.copyWith(
      sortBy: newParam,
      sortDirection: newDirection,
    );
    _store.dispatch(new UpdateBooksListPageAction(newPageSpec));
  }

  static List<String> _extractBookIds(Store<AppState> store) {
    final pageSpec = store.state.booksListPage;
    final progress = store.state.progressions;

    List<_SortableId> processedIds = [];
    store.state.books.forEach((bookId, book) {
      if (new _BookFilter(store.state).check(bookId, book)) {
        switch (pageSpec.sortBy) {
          case BooksSortParam.LAST_READ:
            final lastReadOn = _lastUpdate(progress, bookId)
                .transform((update) => update.madeOn.millisecondsSinceEpoch)
                .or(-1);
            processedIds.add(new _SortableId(bookId, lastReadOn));
            break;
          case BooksSortParam.FRACTION_DONE:
            final done = progress[bookId]?.pagesRead ?? 0 / book.numbedOfPages;
            processedIds.add(new _SortableId(bookId, done.ceil()));
            break;
        }
      }
    });
    processedIds.sort((first, second) {
      switch (pageSpec.sortDirection) {
        case SortDirection.DESC:
          return second.compareTo(first);
        case SortDirection.ASC:
          return first.compareTo(second);
      }
    });
    return processedIds.map((id) => id.id).toList(growable: false);
  }

  static Optional<ReadingUpdate> _lastUpdate(
      Map<String, ReadingProgression> progress, String id) {
    try {
      return new Optional.fromNullable(progress[id]?.updates?.last);
    } on StateError catch (_) {
      return new Optional.absent();
    }
  }
}

class _SortableId implements Comparable<_SortableId> {
  final String id;
  final double sortScore;

  _SortableId(this.id, int sortScore)
      : sortScore = sortScore + 1 / (id.hashCode + 1);

  @override
  int compareTo(_SortableId other) => sortScore.compareTo(other.sortScore);
}

class _BookFilter {
  final AppState _state;

  _BookFilter(this._state);

  bool check(String id, Book book) {
    var filterProp = _state.booksListPage.statusFilter;
    if (filterProp.isEmpty) {
      return true;
    }

    final status = _status(book, _state.progressions[id]);

    return filterProp.value == status;
  }

  ReadingStatus _status(
    Book book,
    ReadingProgression progress,
  ) {
    final read = progress?.pagesRead ?? 0;
    return read == 0
        ? ReadingStatus.UNTOUCHED
        : read < book.numbedOfPages
            ? ReadingStatus.READING
            : ReadingStatus.FINISHED;
  }
}
