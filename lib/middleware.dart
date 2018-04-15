import 'package:readaton/state/app_state.dart';
import 'package:readaton/modules/boot_page/boot_page.dart';
import 'package:redux/redux.dart';

import 'services/goodreads/goodreads.dart' as goodreadsServices;
import 'services/google/google.dart' as googleServices;

final _allMiddleware = <MiddlewareBinding<AppState, dynamic>>[
  new MiddlewareBinding<AppState, BootAppAction>((store, _, __) {
    store.dispatch(const AppBootedAction());
  }),
]
  ..addAll(googleServices.middleware)
  ..addAll(goodreadsServices.middleware);

final appMiddleware = combineTypedMiddleware<AppState>(_allMiddleware);
