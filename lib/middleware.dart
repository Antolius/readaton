import 'dart:async';

import 'package:readaton/app_state.dart';
import 'package:redux/redux.dart';

import 'modules/boot_page/boot_page.dart' as bootPage;

final _allMiddleware = <MiddlewareBinding<AppState, dynamic>>[
  new MiddlewareBinding<AppState, bootPage.BootAppAction>(
      (store, action, next) {
    new Timer(
      new Duration(seconds: 2),
      () => store.dispatch(const bootPage.AppBootedAction()),
    );
    next(action);
  })
];

final appMiddleware = combineTypedMiddleware<AppState>(_allMiddleware);
