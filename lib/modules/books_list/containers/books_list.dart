import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/state/state.dart';
import 'package:readaton/modules/books_list/components/empty_books_list.dart';
import 'package:readaton/modules/books_list/components/full_books_list.dart';
import 'package:readaton/modules/books_list/containers/books_list_view_model.dart';

class BooksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, BooksListViewModel>(
        distinct: true,
        converter: (store) => new BooksListViewModel.from(store),
        builder: (_, model) => model.totalBooksCount > 0
            ? new FullBooksList(model: model)
            : new EmptyBooksList(),
      );
}
