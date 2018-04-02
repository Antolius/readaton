import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/stats_dashboard/components/reading_speed_stats_card.dart';
import 'package:readaton/modules/stats_dashboard/containers/stats_view_model.dart';

class FullStatsDashboard extends StatelessWidget {
  final StatsViewModel model;

  FullStatsDashboard({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) => new ListView(
        children: <Widget>[
          new ReadingSpeedStatsCard(
            data: model.pagesReadData,
            aggregation: model.pagesReadAggregation,
            onAggregationChange: model.updatePagesReadAggregation,
          ),
        ],
      );
}
