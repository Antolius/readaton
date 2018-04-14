import 'package:readaton/app_state.dart';
import 'package:readaton/modules/stats_dashboard/actions/actions.dart';
import 'package:redux/redux.dart';

class StatsViewModel {
  final Store<AppState> _store;
  List<TimeSeriesPagesRead> _pagesReadData;
  List<TimeSeriesBooksFinished> _booksFinishedData;
  List<SeriesAuthor> _readAuthors;

  bool get hasReadingData => true;

  List<TimeSeriesPagesRead> get pagesReadData => _pagesReadData;

  List<TimeSeriesBooksFinished> get booksFinishedData => _booksFinishedData;

  List<SeriesAuthor> get readAuthors => _readAuthors;

  DataAggregation get pagesReadAggregation =>
      _store.state.statsDashboardPage.pagesReadAggregation;

  void updatePagesReadAggregation(DataAggregation newAggregation) {
    _store.dispatch(new UpdatePagesReadAggregationAction(newAggregation));
  }

  StatsViewModel.from(this._store) {
    final Map<DateTime, TimeSeriesPagesRead> pagesData = {};
    final Map<DateTime, TimeSeriesBooksFinished> booksData = {};
    final Map<String, SeriesAuthor> authorsData = {};

    _store.state.progressions.forEach((bookId, progress) {
      var book = _store.state.books[bookId];
      if (progress.pagesRead == book.numberOfPages) {
        var lastUpdatedAt = progress.updates.last.madeOn;
        var value = booksData.putIfAbsent(
          lastUpdatedAt,
          () => new TimeSeriesBooksFinished.zero(lastUpdatedAt),
        );
        value.booksFinished++;

        book.authors.forEach((authId) {
          var value2 = authorsData.putIfAbsent(
            authId,
            () => new SeriesAuthor(_store.state.authors[authId].name, 0),
          );
          value2.booksRead++;
        });
      }

      progress.updates.forEach((update) {
        var value = pagesData.putIfAbsent(
          update.madeOn,
          () => new TimeSeriesPagesRead.zero(update.madeOn),
        );
        value.pagesRead += update.pagesRead;
      });
    });

    _booksFinishedData = booksData.values.toList(growable: false)..sort();
    _pagesReadData = pagesData.values.toList(growable: false)..sort();
    var allAuthors = authorsData.values.toList(growable: false)..sort();
    var topAuthorsNumber = 4;
    _readAuthors = allAuthors.take(topAuthorsNumber).toList();
    if (allAuthors.length > topAuthorsNumber) {
      _readAuthors.add(new SeriesAuthor(
        'Others',
        allAuthors.skip(topAuthorsNumber).fold(0, (sum, next) => sum + next.booksRead),
      ));
    }
  }
}

class SeriesAuthor implements Comparable<SeriesAuthor> {
  String authorName;
  int booksRead;

  SeriesAuthor(this.authorName, this.booksRead);

  @override
  int compareTo(SeriesAuthor other) => other.booksRead - booksRead;
}

class TimeSeriesPagesRead implements Comparable<TimeSeriesPagesRead> {
  DateTime time;
  int pagesRead;

  TimeSeriesPagesRead.zero(this.time) : pagesRead = 0;

  @override
  int compareTo(TimeSeriesPagesRead other) =>
      time.millisecondsSinceEpoch - other.time.millisecondsSinceEpoch;
}

class TimeSeriesBooksFinished implements Comparable<TimeSeriesBooksFinished> {
  DateTime time;
  int booksFinished;

  TimeSeriesBooksFinished.zero(this.time) : booksFinished = 0;

  @override
  int compareTo(TimeSeriesBooksFinished other) =>
      time.millisecondsSinceEpoch - other.time.millisecondsSinceEpoch;
}
