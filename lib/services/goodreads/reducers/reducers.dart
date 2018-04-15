import 'package:readaton/state/state.dart';
import 'package:readaton/services/goodreads/actions/actions.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, AddGoodreadsUserCredentials>((state, action) =>
      state.copyWith(
        userState: new UserState(goodreadsCredentials: action.newCredentials),
      )),
];
