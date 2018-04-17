import 'package:readaton/state/app_state.dart';
import 'package:redux/redux.dart';

import 'modules/book_card/book_card.dart' as bookCard;
import 'modules/book_editor_page/book_editor_page.dart' as bookEditorPage;
import 'modules/books_import/books_import.dart' as booksImportsPage;
import 'modules/books_list/books_list.dart' as booksListPage;
import 'modules/boot_page/boot_page.dart' as bootPage;
import 'modules/stats_dashboard/stats_dashboard.dart' as statsDashboardPage;
import 'modules/tabs_page/tabs_page.dart' as tabsPage;
import 'services/goodreads/goodreads.dart' as goodreadsServices;
import 'services/google/google.dart' as googleServices;

final _allReducers = []
  ..addAll(googleServices.reducers)
  ..addAll(goodreadsServices.reducers)
  ..addAll(bookCard.reducers)
  ..addAll(booksListPage.reducers)
  ..addAll(bootPage.reducers)
  ..addAll(bookEditorPage.reducers)
  ..addAll(statsDashboardPage.reducers)
  ..addAll(tabsPage.reducers)
  ..addAll(booksImportsPage.reducers);

final appStateReducer = _combineTypedReducersCumulatively<AppState>(_allReducers);

Reducer<State> _combineTypedReducersCumulatively<State>(
    List<ReducerBinding<State, dynamic>> bindings) {
  return (State state, dynamic action) {
    return bindings.fold(state, (currentState, binder) {
      if (binder.handlesAction(action)) {
        return binder.reducer(currentState, action);
      } else {
        return currentState;
      }
    });
  };
}
