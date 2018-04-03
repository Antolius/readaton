import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/stats_dashboard/containers/stats_view_model.dart';

class MostReadAuthorsCard extends StatelessWidget {
  final List<SeriesAuthor> data;

  MostReadAuthorsCard({
    @required this.data,
  });

  @override
  Widget build(BuildContext context) => new Card(
        child: new Column(
          children: <Widget>[
            new Text(
              'Authors',
            ),
            new Container(
              height: 160.0,
              child: new charts.PieChart(
                [
                  new charts.Series<SeriesAuthor, String>(
                    id: 'Read authors',
                    data: data,
                    domainFn: (authStat, _) => authStat.authorName,
                    measureFn: (authStat, _) => authStat.booksRead,
                    labelAccessorFn: (authStat, _) => authStat.authorName,
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
