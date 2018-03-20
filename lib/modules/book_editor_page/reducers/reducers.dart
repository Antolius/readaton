import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_editor_page/actions/actions.dart';
import 'package:redux/redux.dart';
import 'package:uuid/uuid.dart';

final _uuid = new Uuid();

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, UpdateExistingBookAction>(
    (state, action) => state.copyWith(
          books: {}
            ..addAll(state.books)
            ..addAll({action.bookId: action.updatedBook}),
        ),
  ),
  new ReducerBinding<AppState, AddNewBookAction>(
    (state, action) => state.copyWith(
          books: {_uuid.v4(): action.newBook}..addAll(state.books),
        ),
  ),
  new ReducerBinding<AppState, AddNewAuthorAction>(
    (state, action) {
      final newAuthorId = _uuid.v4();
      return state.copyWith(
        authors: {newAuthorId: action.newAuthor}..addAll(state.authors),
        bookEditorPage:
            state.bookEditorPage.copyWith(addedAuthorId: newAuthorId),
      );
    },
  ),
];
