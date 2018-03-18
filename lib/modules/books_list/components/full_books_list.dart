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
        color: Colors.black12,
        child: new ListView.builder(
          itemCount: model.bookIds.length + 1,
          itemBuilder: (_, index) => index == 0
              ? new BooksListControls(
                  currentPage: model.page,
                  onFilter: model.filter,
                  onSort: model.sort,
                )
              : new BookCard(bookId: model.bookIds[index - 1]),
        ),
      );
}
