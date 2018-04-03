import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/stats_dashboard/containers/stats_view_model.dart';
import 'package:readaton/modules/stats_dashboard/utils/color_utils.dart';

class ReadingSpeedStatsCard extends StatelessWidget {
  final List<TimeSeriesPagesRead> data;
  final DataAggregation aggregation;
  final ValueChanged<DataAggregation> onAggregationChange;

  ReadingSpeedStatsCard({
    @required this.data,
    @required this.aggregation,
    @required this.onAggregationChange,
  });

  List<TimeSeriesPagesRead> _dataSince(DateTime sinceWhen) {
    var filteredList = data
        .where((datum) => datum.time.isAfter(sinceWhen))
        .toList(growable: false);
    return filteredList;
  }

  DateTime _lastYear() => new DateTime.now().subtract(new Duration(days: 365));

  DateTime _lastMonth() => new DateTime.now().subtract(new Duration(days: 30));

  DateTime _lastWeek() => new DateTime.now().subtract(new Duration(days: 7));

  @override
  Widget build(BuildContext context) => new Card(
        child: new DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: new Column(
            children: <Widget>[
              _buildTabs(context),
              new Container(
                height: 168.0,
                padding: new EdgeInsets.only(bottom: 8.0),
                child: new TabBarView(
                  children: [
                    _buildChartFor(context, _dataSince(_lastYear())),
                    _buildChartFor(context, _dataSince(_lastMonth())),
                    _buildChartFor(context, _dataSince(_lastWeek())),
                  ],
                ),
              ),
              new Divider(height: 0.0),
              _buildButtons(context),
            ],
          ),
        ),
      );

  Widget _buildTabs(BuildContext context) => new Container(
        color: Theme.of(context).primaryColor,
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(
                'Reading speed',
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Theme.of(context).dialogBackgroundColor,
                    ),
              ),
            ),
            new TabBar(
              tabs: [
                new Tab(text: 'YEARLY'),
                new Tab(text: 'MONTHLY'),
                new Tab(text: 'WEEKLY'),
              ],
            ),
          ],
        ),
      );

  Widget _buildChartFor(BuildContext context, List<TimeSeriesPagesRead> data) =>
      new charts.TimeSeriesChart(
        [
          new charts.Series<TimeSeriesPagesRead, DateTime>(
            id: 'Pages read',
            data: data,
            domainFn: (pgsRead, _) => pgsRead.time,
            measureFn: _pickMeasureFunction(),
            colorFn: (_, __) => toChartColor(Theme.of(context).accentColor),
          )
        ],
        animate: false,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      );

  _pickMeasureFunction() {
    switch (aggregation) {
      case DataAggregation.INDIVIDUAL:
        return (TimeSeriesPagesRead pgsRead, _) => pgsRead.pagesRead;
      case DataAggregation.CUMULATIVE:
        return (_, int index) => data
            .take(index + 1)
            .map((pgsRead) => pgsRead.pagesRead)
            .fold(0, (sum, next) => sum + next);
      default:
        assert(false, 'unknown enum type');
    }
  }

  Widget _buildButtons(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.body1;
    return new ButtonTheme.bar(
      child: new ButtonBar(
        mainAxisSize: MainAxisSize.max,
        alignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text('Show ', style: textTheme),
              new DropdownButton<DataAggregation>(
                value: aggregation,
                items: [
                  new DropdownMenuItem(
                    value: DataAggregation.INDIVIDUAL,
                    child: new Text('day by day', style: textTheme),
                  ),
                  new DropdownMenuItem(
                    value: DataAggregation.CUMULATIVE,
                    child: new Text('cumulative', style: textTheme),
                  ),
                ],
                onChanged: onAggregationChange,
              ),
              new Text(' data', style: textTheme),
            ],
          ),
          new FlatButton(
            child: new Text('SEE MORE'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
