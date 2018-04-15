import 'package:flutter/material.dart';
import 'package:readaton/modules/books_import/books_import.dart';

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
                    showDialog(context: context, child: new BooksImport());
//                  Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                      fullscreenDialog: false,
//                      builder: (_) => new BooksImport(),
//                    ),
//                  );
                },
                child: new Text("IMPORT FROM GOODREADS"),
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      );
}
