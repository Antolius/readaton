import 'package:readaton/services/goodreads/actions/actions.dart';
import 'package:readaton/state/state.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, AddGoodreadsUserAction>(
    (state, action) => state.copyWith(
          userState: new UserState(
            credentials: new Map.from(state.userState.credentials)
              ..[Platform.GOODREADS] = action.newCredentials,
            profiles: new Map.from(state.userState.profiles)
              ..[Platform.GOODREADS] = action.newProfile,
          ),
        ),
  ),
  new ReducerBinding<AppState, SignOutFromGoodreadsAction>(
    (state, action) => state.copyWith(
          userState: new UserState(
            credentials: new Map.from(state.userState.credentials)
              ..remove(Platform.GOODREADS),
            profiles: new Map.from(state.userState.profiles)
              ..remove(Platform.GOODREADS),
          ),
        ),
  ),
];
