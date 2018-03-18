import 'package:readaton/app_state.dart';
import 'package:redux/redux.dart';

import 'modules/books_list/books_list.dart' as booksListPage;
import 'modules/boot_page/boot_page.dart' as bootPage;
import 'modules/tabs_page/tabs_page.dart' as tabsPage;
import 'services/google/google.dart' as googleServices;
import 'modules/book_card/book_card.dart' as bookCard;

final _allReducers = []
  ..addAll(googleServices.reducers)
  ..addAll(bookCard.reducers)
  ..addAll(booksListPage.reducers)
  ..addAll(bootPage.reducers)
  ..addAll(tabsPage.reducers);

final appStateReducer = combineTypedReducers<AppState>(_allReducers);
