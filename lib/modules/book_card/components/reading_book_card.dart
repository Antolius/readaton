import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/book_card/components/book_list_tile.dart';
import 'package:readaton/modules/book_card/components/reading_progress.dart';
import 'package:readaton/modules/book_card/components/update_progress_dialog.dart';
import 'package:readaton/modules/book_card/containers/book_view_model.dart';

typedef void ReadingProgressCallback(int pagesRead);

class ReadingBookCard extends StatelessWidget {
  final BookViewModel model;

  ReadingBookCard({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) => new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new BookListTile(
              book: model,
              trailing: new ReadingProgress(
                readFraction: model.numberOfReadPages / model.numberOfPages,
              ),
            ),
            new Divider(
              height: 0.0,
            ),
            new ButtonTheme.bar(
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton.icon(
                    onPressed: () {
                      var remainingPages =
                          model.numberOfPages - model.numberOfReadPages;
                      model.onReadingUpdate(remainingPages);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('COMPLETE'),
                  ),
                  new FlatButton.icon(
                    onPressed: () => showDialog<int>(
                          context: context,
                          child: new UpdateProgressDialog(
                            numberOfPages: model.numberOfPages,
                            numberOfReadPages: model.numberOfReadPages,
                          ),
                        )
                            .then(model.onReadingUpdate),
                    icon: const Text('%', textScaleFactor: 1.5),
                    label: const Text('UPDATE PROGRESS'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
