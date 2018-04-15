import 'package:readaton/services/goodreads/actions/actions.dart';
import 'package:readaton/services/goodreads/utils/api_key_provider.dart';
import 'package:readaton/services/goodreads/utils/goodreads_oauth.dart';
import 'package:readaton/services/goodreads/utils/user_profile.dart';
import 'package:readaton/state/state.dart';
import 'package:redux/redux.dart';

final middleware = <MiddlewareBinding<AppState, dynamic>>[
  _signInWithGoodreads,
];

final _signInWithGoodreads =
    new MiddlewareBinding<AppState, SignInWithGoodreadsAction>(
        (store, action, next) async {
  next(action);

  var apiKey = await getApiKey();
  var credentials = await obtainUserToken(apiKey);
  var profile = await fetchUserProfile(apiKey, credentials);

  store.dispatch(new AddGoodreadsUserAction(credentials, profile));
});
