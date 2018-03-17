import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/books_list/components/empty_books_list.dart';
import 'package:readaton/modules/books_list/components/full_books_list.dart';

class BooksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, List<String>>(
        distinct: true,
        converter: (store) => store.state.books.keys.toList(growable: false),
        builder: (_, bookIds) => bookIds.isNotEmpty
            ? new FullBooksList(bookIds: bookIds)
            : new EmptyBooksList(),
      );
}
