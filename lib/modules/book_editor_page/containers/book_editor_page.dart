import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_editor_page/components/editor_page.dart';
import 'package:readaton/modules/book_editor_page/containers/book_editor_view_model.dart';

class BookEditorPage extends StatelessWidget {
  final String bookId;

  BookEditorPage({this.bookId});

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, BookEditorViewModel>(
        converter: (store) => new BookEditorViewModel.from(store, bookId),
        builder: (_, model) => new EditorPage(model: model),
      );
}
