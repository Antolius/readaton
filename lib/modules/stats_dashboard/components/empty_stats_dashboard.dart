import 'package:flutter/material.dart';

class EmptyStatsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
        color: Theme.of(context).backgroundColor,
        child: new Center(
          child: new Text(
            'You haven\'t done any reading yet.',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
      );
}
