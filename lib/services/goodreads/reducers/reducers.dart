import 'package:readaton/services/goodreads/actions/actions.dart';
import 'package:readaton/state/state.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, AddGoodreadsUserAction>(
      (state, action) => state.copyWith(
            userState: new UserState(
              credentials: {}
                ..addAll(state.userState.credentials)
                ..[Platform.GOODREADS] = action.newCredentials,
              profiles: {}
                ..addAll(state.userState.profiles)
                ..[Platform.GOODREADS] = action.newProfile,
            ),
          )),
];
