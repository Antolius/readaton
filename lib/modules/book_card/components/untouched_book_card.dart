import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/book_card/components/book_list_tile.dart';
import 'package:readaton/modules/book_card/containers/book_view_model.dart';

class UntouchedBookCard extends StatelessWidget {
  final BookViewModel book;

  UntouchedBookCard({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) => new Container(
        color: Colors.white,
        margin: new EdgeInsets.symmetric(vertical: 2.0),
        child: new BookListTile(book: book),
      );
}
