import 'package:readaton/state/state.dart';
import 'package:readaton/services/goodreads/actions/actions.dart';
import 'package:readaton/services/goodreads/utils/goodreads_oauth.dart';
import 'package:redux/redux.dart';

final middleware = <MiddlewareBinding<AppState, dynamic>>[
  _signInWithGoodreads,
];

final _signInWithGoodreads =
    new MiddlewareBinding<AppState, SignInWithGoodreadsAction>(
        (store, action, next) async {
  next(action);

  try {
    var credentials = await obtainUserToken();
    store.dispatch(new AddGoodreadsUserCredentials(credentials));
  } catch (error) {
    print(error);
  }
});
