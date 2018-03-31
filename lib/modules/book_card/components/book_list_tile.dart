import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_card/containers/book_view_model.dart';

class BookListTile extends StatelessWidget {
  final BookViewModel book;
  final Widget trailing;

  BookListTile({
    @required this.book,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => new ListTile(
        leading: book.coverImage.accept(new _ImageBuilder()),
        title: new Text(book.title),
        subtitle: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('By: ${_extractAuthors(book)}'),
            new Text('Last read ${_extractLastReadOn(book)}')
          ],
        ),
        trailing: trailing,
      );

  String _extractAuthors(BookViewModel book) => book.authorNames.join(', ');

  String _extractLastReadOn(BookViewModel book) => book.lastReadOn
      .transform((d) => 'on ${d.day}. ${d.month}. ${d.year}.')
      .or('newer');
}

class _ImageBuilder extends ImageDataVisitor<Widget> {
  @override
  Widget visitLocalImage(LocalImageData localImage) =>
      new Image.asset(localImage.imageName);

  @override
  Widget visitUrlImage(UrlImageData urlImage) =>
      new Image.network(urlImage.imageUrl);
}
