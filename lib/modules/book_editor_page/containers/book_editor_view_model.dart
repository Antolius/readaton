import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_editor_page/actions/actions.dart';
import 'package:redux/redux.dart';

class BookEditorViewModel {
  final Store<AppState> _store;
  final String _bookId;
  final Book editedBook;
  final Map<String, Author> authors;
  final String addedAuthorId;

  BookEditorViewModel.from(this._store, this._bookId)
      : editedBook = _store.state.books[_bookId],
        authors = _store.state.authors,
        addedAuthorId = _store.state.bookEditorPage.addedAuthorId;

  void onSaveBook(Book newBook) {
    if (_bookId == null) {
      _store.dispatch(new AddNewBookAction(newBook));
    } else {
      _store.dispatch(new UpdateExistingBookAction(_bookId, newBook));
    }
  }

  void onSaveAuthor(Author newAuthor) {
    _store.dispatch(new AddNewAuthorAction(newAuthor));
  }
}
