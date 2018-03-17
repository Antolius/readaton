import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/modules/book_card/components/book_list_item.dart';
import 'package:readaton/modules/book_card/utils/book_view_model.dart';

class BookCard extends StatelessWidget {
  final String bookId;

  BookCard({
    @required this.bookId,
  });

  @override
  Widget build(BuildContext context) => new StoreConnector(
        distinct: true,
        converter: (store) => new BookViewModel.from(store, bookId),
        builder: (_, model) => new BookListItem(book: model),
      );
}
