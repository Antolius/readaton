import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/book_card/book_card.dart';

class FullBooksList extends StatelessWidget {
  final List<String> bookIds;

  FullBooksList({
    @required this.bookIds,
  });

  @override
  Widget build(BuildContext context) => new ListView.builder(
      itemCount: bookIds.length,
      itemBuilder: (_, index) => new BookCard(bookId: bookIds[index]));
}
