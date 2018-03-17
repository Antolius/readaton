import 'package:readaton/app_state.dart';
import 'package:readaton/modules/tabs_page/actions/actions.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, SelectSectionAction>(
    (state, action) => state.copyWith(currentSection: action.newSection),
  ),
];
