import 'package:readaton/app_state.dart';
import 'package:redux/redux.dart';

import 'services/google/google.dart' as googleServices;

final _allMiddleware = []..addAll(googleServices.middleware);

final appMiddleware = combineTypedMiddleware<AppState>(_allMiddleware);
