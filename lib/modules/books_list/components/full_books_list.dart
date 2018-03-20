import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/book_card/book_card.dart';
import 'package:readaton/modules/books_list/components/books_list_controls.dart';
import 'package:readaton/modules/books_list/containers/books_list_view_model.dart';

class FullBooksList extends StatelessWidget {
  final BooksListViewModel model;

  FullBooksList({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) => new Container(
        key: new ObjectKey(model.listStateHash),
        color: Colors.black12,
        child: new ListView.builder(
          itemCount: model.bookIds.length + 1,
          itemBuilder: (_, index) => index == 0
              ? new BooksListControls(
                  key: new ObjectKey('controls'),
                  currentPage: model.page,
                  onFilter: model.filter,
                  onSort: model.sort,
                )
              : new BookCard(
                  key: new ObjectKey(_bookHashFor(index)),
                  bookId: _bookIdFor(index),
                ),
        ),
      );

  int _bookHashFor(int index) => model.stateHashFor(_bookIdFor(index));

  String _bookIdFor(int index) => model.bookIds[index - 1];
}
