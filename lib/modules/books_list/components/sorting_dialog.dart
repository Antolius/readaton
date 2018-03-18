import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';

class BooksSort {
  final BooksSortParam param;
  final SortDirection direction;

  BooksSort(this.param, this.direction);

  BooksSort copyWith({
    BooksSortParam param,
    SortDirection direction,
  }) =>
      new BooksSort(
        param ?? this.param,
        direction ?? this.direction,
      );
}

class SortingDialog extends StatefulWidget {
  final BooksSort currentSort;

  SortingDialog({
    @required this.currentSort,
  });

  @override
  _SortingDialogState createState() => new _SortingDialogState();
}

class _SortingDialogState extends State<SortingDialog> {
  BooksSort _sort;

  @override
  void initState() {
    super.initState();
    _sort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) => new Dialog(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(24.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: new Text(
                      'Pick sort',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  new Text(
                    'Sort by:',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  new RadioListTile<BooksSortParam>(
                    title: const Text('Date you last read the book'),
                    value: BooksSortParam.LAST_READ,
                    groupValue: _sort.param,
                    onChanged: (value) {
                      setState(() {
                        _sort = _sort.copyWith(param: value);
                      });
                    },
                  ),
                  new RadioListTile<BooksSortParam>(
                    title: const Text('Percent of book you read'),
                    value: BooksSortParam.FRACTION_DONE,
                    groupValue: _sort.param,
                    onChanged: (value) {
                      setState(() {
                        _sort = _sort.copyWith(param: value);
                      });
                    },
                  ),
                  new Row(
                    children: <Widget>[
                      new Text(
                        'In ',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      new DropdownButton<SortDirection>(
                        value: _sort.direction,
                        items: <DropdownMenuItem<SortDirection>>[
                          new DropdownMenuItem(
                            value: SortDirection.DESC,
                            child: new Text('descending order'),
                          ),
                          new DropdownMenuItem(
                            value: SortDirection.ASC,
                            child: new Text('ascending order'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _sort = _sort.copyWith(direction: value);
                          });
                        },
                      ),
                    ],
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
                    onPressed: () => Navigator.pop(context, _sort),
                    child: new Text('APPLY'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
