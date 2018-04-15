import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/books_import/components/import_progress_dialog.dart';
import 'package:readaton/modules/books_import/components/sign_in_prompt_dialog.dart';
import 'package:readaton/services/goodreads/goodreads.dart';
import 'package:redux/redux.dart';

class BooksImport extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, BooksImportViewModel>(
          converter: (store) => new BooksImportViewModel.from(store),
          builder: (_, model) => model.hasUser
              ? new ImportProgressDialog(userState: model.userState)
              : new SignInPromptDialog(onSignIn: model.onSignIn));
}

class BooksImportViewModel {
  final Store<AppState> _store;
  final UserState _userState;

  BooksImportViewModel.from(this._store) : _userState = _store.state.userState;

  bool get hasUser => _userState.goodreadsCredentials != null;

  UserState get userState => _userState;

  void onSignIn() {
    _store.dispatch(new SignInWithGoodreadsAction());
  }
}
