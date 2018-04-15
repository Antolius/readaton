import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/modules/books_import/components/import_stepper.dart';
import 'package:readaton/services/goodreads/goodreads.dart';
import 'package:readaton/state/state.dart';
import 'package:redux/redux.dart';

class BooksImportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, BooksImportViewModel>(
        distinct: true,
        converter: (store) => new BooksImportViewModel.from(store),
        builder: (_, model) => new ImportStepper(model: model),
      );
}

class BooksImportViewModel {
  final Store<AppState> _store;
  final UserState _userState;
  final BooksImportPageState _pageState;

  BooksImportViewModel.from(this._store)
      : _userState = _store.state.userState,
        _pageState = _store.state.booksImportPageState;

  bool get hasUser => _userState.credentials[Platform.GOODREADS] != null;

  UserProfile get userProfile => _userState.profiles[Platform.GOODREADS];

  BooksImportPageState get pageState => _pageState;

  void onSignIn() {
    _store.dispatch(new SignInWithGoodreadsAction());
  }

  void onSignOut() {}

  void onPickStep(int pickedStep) {}

  void onSelectShelf(String shelfId) {}

  void onDeselectShelf(String shelfId) {}

  void onCancelImport() {}
}
