import 'package:readaton/state/state.dart';
import 'package:readaton/modules/stats_dashboard/actions/actions.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, UpdatePagesReadAggregationAction>(
    (state, action) => state.copyWith(
          statsDashboardPage: state.statsDashboardPage
              .copyWith(pagesReadAggregation: action.newAggregation),
        ),
  ),
];
