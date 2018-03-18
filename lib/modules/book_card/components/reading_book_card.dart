import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/book_card/components/book_list_tile.dart';
import 'package:readaton/modules/book_card/components/reading_progress.dart';
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
                          child: new _UpdateProgressDialog(
                            numberOfPages: model.numberOfPages,
                            numberOfReadPages: model.numberOfReadPages,
                          ),
                        )
                            .then(model.onReadingUpdate),
                    icon: const Text('%', textScaleFactor: 1.5),
                    label: const Text('UPDAE PROGRESS'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}

class _UpdateProgressDialog extends StatefulWidget {
  final int numberOfPages;
  final int numberOfReadPages;

  _UpdateProgressDialog({
    @required this.numberOfPages,
    @required this.numberOfReadPages,
  });

  @override
  _UpdateProgressDialogState createState() {
    return new _UpdateProgressDialogState();
  }
}

class _UpdateProgressDialogState extends State<_UpdateProgressDialog> {
  int _pagesRead;

  @override
  void initState() {
    super.initState();
    _pagesRead = 0;
  }

  @override
  Widget build(BuildContext context) => new Dialog(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(24.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: new Text(
                      'Update progress',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  new TextField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Pages read',
                    ),
                    onChanged: (newVal) {
                      setState(() {
                        _pagesRead = int.parse(newVal);
                      });
                    },
                  ),
                ],
              ),
            ),
            new Divider(height: 0.0),
            new ButtonTheme.bar(
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: new Text('CANCEL'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.pop(context, _pagesRead),
                    child: new Text('APPLY'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
