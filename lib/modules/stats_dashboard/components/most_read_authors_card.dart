import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/common/components/colored_static_data_table.dart';
import 'package:readaton/modules/stats_dashboard/containers/stats_view_model.dart';
import 'package:readaton/modules/stats_dashboard/utils/color_utils.dart';

var colors = []..addAll(Colors.primaries)..shuffle(new math.Random());

class MostReadAuthorsCard extends StatelessWidget {
  final List<SeriesAuthor> data;
  final Map<String, Color> _authorToColor;

  MostReadAuthorsCard({
    @required this.data,
  })
      : _authorToColor = data.asMap().map((index, stat) => new MapEntry(
              stat.authorName,
              colors[index % colors.length],
            ));

  @override
  Widget build(BuildContext context) => new Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildTable(context),
                  _buildChart(context),
                ],
              ),
            ),
          ],
        ),
      );

  Padding _buildTitle(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: new Text(
        'Authors',
        style: Theme.of(context).textTheme.title.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }

  Widget _buildTable(BuildContext context) => new Container(
        width: MediaQuery.of(context).size.width * 0.40,
        child: new StaticDataTable(
          rows: data
              .map((authStat) => new StaticColoredDataRow(
                    color: _authorToColor[authStat.authorName].withAlpha(180),
                    cells: <DataCell>[
                      new DataCell(new Text(
                        authStat.authorName,
                        style: _small(context),
                      )),
                      new DataCell(new Text(
                        authStat.booksRead.toString(),
                        style: _small(context),
                      )),
                    ],
                  ))
              .toList(growable: false),
        ),
      );

  Widget _buildChart(BuildContext context) => new Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.width * 0.45,
        child: new charts.PieChart(
          [
            new charts.Series<SeriesAuthor, String>(
              id: 'Read authors',
              data: data,
              domainFn: (authStat, _) => authStat.authorName,
              measureFn: (authStat, _) => authStat.booksRead,
              labelAccessorFn: (authStat, _) => authStat.authorName,
              colorFn: (authStat, _) =>
                  toChartColor(_authorToColor[authStat.authorName]),
            )
          ],
        ),
      );

  TextStyle _small(BuildContext context) =>
      Theme.of(context).textTheme.title.copyWith(fontSize: 10.0);
}
