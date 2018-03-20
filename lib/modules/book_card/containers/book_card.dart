import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_card/components/finished_book_card.dart';
import 'package:readaton/modules/book_card/components/reading_book_card.dart';
import 'package:readaton/modules/book_card/components/untouched_book_card.dart';
import 'package:readaton/modules/book_card/containers/book_view_model.dart';

typedef Widget _BookCardBuilder(BuildContext context, BookViewModel model);

class BookCard extends StatelessWidget {
  final String bookId;

  BookCard({
    Key key,
    @required this.bookId,
  })
      : super(key: key);

  final Map<ReadingStatus, _BookCardBuilder> _cardBuilders = {
    ReadingStatus.UNTOUCHED: (_, model) => new UntouchedBookCard(book: model),
    ReadingStatus.READING: (_, model) => new ReadingBookCard(model: model),
    ReadingStatus.FINISHED: (_, model) => new FinishedBookCard(book: model),
  };

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, BookViewModel>(
        distinct: true,
        converter: (store) => new BookViewModel.from(store, bookId),
        builder: (context, model) =>
            _cardBuilders[model.status](context, model),
      );
}
