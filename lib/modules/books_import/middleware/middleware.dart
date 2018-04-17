import 'dart:async';

import 'package:readaton/modules/books_import/actions/actions.dart';
import 'package:readaton/modules/books_import/utils/book_loader.dart' as loader;
import 'package:readaton/modules/books_import/utils/pager.dart' as pager;
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
  new MiddlewareBinding<AppState, FetchBooksPageAction>(
      (store, action, next) async {
    next(action);

    var client = await _getClientFor(store.state.userState);
    var importAction = await _loadBooks(client, store.state, action);
    store.dispatch(importAction);
  }),
  new MiddlewareBinding<AppState, ImportBooksAction>(
      (store, action, next) async {
    next(action);
    store.dispatch(_prepareNextAction(store, action));
  }),
];

Future<GoodreadsClient> _getClientFor(UserState userState) async {
  var apiKey = await getApiKey();
  var credentials = userState.credentials[Platform.GOODREADS];
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

Future<ImportBooksAction> _loadBooks(
  GoodreadsClient client,
  AppState state,
  FetchBooksPageAction action,
) async {
  var newAuthors = {};
  var newBooks = {};

  var userId = state.userState.profiles[Platform.GOODREADS].platformId;
  var bookXmls = await _fetchBooks(client, userId, action);
  for (var bookXml in bookXmls) {
    loader.loadBookIfNew(bookXml, state, newAuthors, newBooks);
  }

  return new ImportBooksAction(
    newBooks: newBooks,
    newAuthors: newAuthors,
    fetchedPage: action,
  );
}

Future<Iterable<XmlElement>> _fetchBooks(
  GoodreadsClient client,
  String userId,
  FetchBooksPageAction action,
) async {
  var response = await client.read('${client.url}/review/list.xml?v=2'
      '&id=$userId'
      '&shelf=${action.shelf}'
      '&sort=date_read'
      '&order=d'
      '&per_page=${action.pageSize}'
      '&page=${action.page}');
  var bookXmls = parse(response).findAllElements('book');
  return bookXmls;
}

dynamic _prepareNextAction(
  Store<AppState> store,
  ImportBooksAction action,
) {
  if (pager.importCompleted(store)) {
    return const CompleteImportAction();
  }
  if (pager.shelfCompleted(store, action)) {
    String nextShelf = pager.pickNextShelf(store);
    return new FetchBooksPageAction(shelf: nextShelf);
  }
  return new FetchBooksPageAction(
    shelf: action.fetchedPage.shelf,
    page: action.fetchedPage.page + 1,
  );
}
