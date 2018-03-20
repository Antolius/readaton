import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateProgressDialog extends StatelessWidget {
  final int numberOfPages;
  final int numberOfReadPages;
  final GlobalKey<FormFieldState> _pageInputKey =
      new GlobalKey<FormFieldState>();

  UpdateProgressDialog({
    @required this.numberOfPages,
    @required this.numberOfReadPages,
  });

  _onApply(BuildContext context) {
    final state = _pageInputKey.currentState;
    if (state.validate()) {
      Navigator.pop(context, int.parse(state.value) - numberOfReadPages);
    }
  }

  String _validatePageReachedInput(String val) {
    if (val == null) return 'Page is requred';
    final page = int.parse(val, onError: (_) => -1);
    if (page <= 0) return 'Page must be a positive number';
    if (page > numberOfPages) return 'Book only has $numberOfPages pages';
    if (page < numberOfReadPages)
      return 'You already reached page $numberOfReadPages';
    return null;
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
                  new TextFormField(
                    key: _pageInputKey,
                    initialValue: numberOfReadPages.toString(),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Page reached',
                        hintText: 'Page you are currently on'),
                    validator: _validatePageReachedInput,
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
                    onPressed: () => _onApply(context),
                    child: new Text('APPLY'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
