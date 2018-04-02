import 'package:readaton/app_state.dart';
import 'package:readaton/modules/stats_dashboard/actions/actions.dart';
import 'package:redux/redux.dart';

class StatsViewModel {
  final Store<AppState> _store;
  List<TimeSeriesPagesRead> _pagesReadData;
  List<TimeSeriesBooksFinished> _booksFinishedData;

  bool get hasReadingData => true;

  List<TimeSeriesPagesRead> get pagesReadData => _pagesReadData;

  List<TimeSeriesBooksFinished> get booksFinishedData => _booksFinishedData;

  DataAggregation get pagesReadAggregation => _store.state.statsDashboardPage.pagesReadAggregation;

  void updatePagesReadAggregation(DataAggregation newAggregation) {
    _store.dispatch(new UpdatePagesReadAggregationAction(newAggregation));
  }

  StatsViewModel.from(this._store) {
    final Map<DateTime, TimeSeriesPagesRead> pagesData = {};
    final Map<DateTime, TimeSeriesBooksFinished> booksData = {};

    _store.state.progressions.forEach((_, progress) {
      var lastUpdatedAt = progress.updates.last.madeOn;
      var value = booksData.putIfAbsent(
        lastUpdatedAt,
        () => new TimeSeriesBooksFinished.zero(lastUpdatedAt),
      );
      value.booksFinished++;

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
  }
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
