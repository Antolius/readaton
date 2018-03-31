import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateProgressDialog extends StatefulWidget {
  final int numberOfPages;
  final int numberOfReadPages;

  UpdateProgressDialog({
    @required this.numberOfPages,
    @required this.numberOfReadPages,
  });

  @override
  UpdateProgressDialogState createState() {
    return new UpdateProgressDialogState();
  }
}

class UpdateProgressDialogState extends State<UpdateProgressDialog> {
  int value;

  @override
  void initState() {
    super.initState();
    value = widget.numberOfReadPages;
  }

  int get _percentRead => (value / widget.numberOfPages * 100).ceil();

  int get _numberOfNewlyReadPages => value - widget.numberOfReadPages;

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
                  new Slider(
                    value: value.toDouble(),
                    onChanged: (newValue) => setState(() {
                          value = newValue.ceil();
                        }),
                    min: widget.numberOfReadPages.toDouble(),
                    max: widget.numberOfPages.toDouble(),
                    label: '$value',
                  ),
                  new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: new Text('Read $_percentRead%, or $value out of ${widget
                        .numberOfPages} pages'),
                  )
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
                    onPressed: () =>
                        Navigator.pop(context, _numberOfNewlyReadPages),
                    child: new Text('APPLY'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
