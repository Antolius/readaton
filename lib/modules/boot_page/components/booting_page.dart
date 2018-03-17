import 'package:flutter/material.dart';

class BootingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return new Scaffold(
      backgroundColor: theme.backgroundColor,
      body: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.book,
              color: theme.hintColor,
            ),
            new Text(
              'Readaton',
              style: theme.textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
