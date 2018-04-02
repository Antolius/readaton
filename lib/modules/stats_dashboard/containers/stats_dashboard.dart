import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/stats_dashboard/components/empty_stats_dashboard.dart';
import 'package:readaton/modules/stats_dashboard/components/full_stats_dashboard.dart';
import 'package:readaton/modules/stats_dashboard/containers/stats_view_model.dart';

class StatsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, StatsViewModel>(
        converter: (store) => new StatsViewModel.from(store),
        builder: (_, model) => model.hasReadingData
            ? new FullStatsDashboard(model: model)
            : new EmptyStatsDashboard(),
      );
}

