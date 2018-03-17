import 'package:flutter/material.dart';

class EmptyBooksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.sentiment_dissatisfied,
              size: 48.0,
              color: Theme.of(context).accentColor,
            ),
            new Text('You have no books.'),
            new Padding(
              padding: new EdgeInsets.only(top: 12.0),
              child: new Text('Why don\'t you add some?'),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 48.0),
              child: new RaisedButton(
                onPressed: () {
                  //todo: implement!
                },
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Icon(Icons.add_box),
                    new Text("ADD A BOOK")
                  ],
                ),
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      );
}
