import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/state/state.dart';

class ImportProgressDialog extends StatelessWidget {
  final UserState userState;

  ImportProgressDialog({
    @required this.userState,
  });

  @override
  Widget build(BuildContext context) => new SimpleDialog(
        title: const Text('Import books'),
        contentPadding: const EdgeInsets.all(24.0),
        children: <Widget>[
          new Text('${userState.toString()}'),
        ],
      );
}
