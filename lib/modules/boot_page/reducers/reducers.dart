import 'package:readaton/app_state.dart';
import 'package:readaton/modules/boot_page/actions/actions.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, BootAppAction>(
    (state, _) => state.copyWith(isBooted: false),
  ),
  new ReducerBinding<AppState, AppBootedAction>(
    (state, _) => state.copyWith(isBooted: true),
  ),
];
