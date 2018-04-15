import 'package:readaton/state/state.dart';
import 'package:readaton/modules/books_list/actions/actions.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, UpdateBooksListPageAction>(
    (state, action) => state.copyWith(booksListPage: action.newPage),
  ),
];
