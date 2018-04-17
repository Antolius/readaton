import 'dart:async';

import 'package:readaton/modules/books_import/actions/actions.dart';
import 'package:readaton/services/common/utils/wrapper.dart';
import 'package:readaton/services/goodreads/goodreads.dart';
import 'package:readaton/services/goodreads/utils/api_key_provider.dart';
import 'package:readaton/services/goodreads/utils/goodreads_client.dart';
import 'package:readaton/state/state.dart';
import 'package:redux/redux.dart';
import 'package:xml/xml.dart';

final middleware = <MiddlewareBinding<AppState, dynamic>>[
  new MiddlewareBinding<AppState, AddGoodreadsUserAction>(
      (store, action, next) async {
    next(action);
    store.dispatch(new StartLoadingShelvesAction());
  }),
  new MiddlewareBinding<AppState, StartLoadingShelvesAction>(
      (store, action, next) async {
    next(action);

    var user = store.state.userState;
    var userId = user.profiles[Platform.GOODREADS].platformId;

    var client = await _getClientFor(user);
    var shelves = await _fetchShelves(client, userId);
    store.dispatch(new AddGoodreadsShelvesAction(shelves));
  }),
];

Future<GoodreadsClient> _getClientFor(UserState userState) async {
  var apiKey = await getApiKey();
  var credentials = userState.credentials[Platform.GOODREADS];
  var userId = userState.profiles[Platform.GOODREADS].platformId;
  return new GoodreadsClient(apiKey, credentials);
}

Future<List<GoodreadsShelf>> _fetchShelves(
  GoodreadsClient client,
  String userId,
) async {
  var response = await client.read('${client.url}/user/show/$userId.xml');
  return parse(response)
      .findAllElements('user_shelf')
      .map((xmlEl) => new Wrapper.wrapXmlElement(xmlEl))
      .map((xmlEl) => new GoodreadsShelf(
            name: xmlEl.pluck('name'),
            platformId: int.parse(xmlEl.pluck('id')),
            numberOfBooks: int.parse(xmlEl.pluck('book_count')),
          ))
      .toList(growable: false);
}
