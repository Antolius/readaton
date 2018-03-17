import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReadingProgress extends StatelessWidget {
  final double percentDone;

  ReadingProgress({
    @required this.percentDone,
  });

  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          new ClipOval(
            child: new Container(
              width: 32.0,
              height: 32.0,
              color: Theme.of(context).accentColor,
            ),
          ),
          new Text('$percentDone% done')
        ],
      );
}
