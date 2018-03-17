import 'package:readaton/app_state.dart';
import 'package:redux/redux.dart';

import 'modules/boot_page/boot_page.dart' as bootPage;
import 'modules/tabs_page/tabs_page.dart' as tabsPage;

final _allReducers = <ReducerBinding<AppState, dynamic>>[]
  ..addAll(bootPage.reducers)
  ..addAll(tabsPage.reducers);

final appStateReducer = combineTypedReducers<AppState>(_allReducers);
