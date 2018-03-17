import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/book_card/components/reading_progress.dart';
import 'package:readaton/modules/book_card/utils/book_view_model.dart';

class BookListItem extends StatelessWidget {
  final BookViewModel book;

  BookListItem({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) => new ListTile(
        leading: new Image.network(book.coverImageUrl),
        title: new Text(book.title),
        subtitle: new Text(book.subtitle),
        trailing: new ReadingProgress(
          percentDone: book.numberOfReadPages / book.numberOfPages,
        ),
      );
}
