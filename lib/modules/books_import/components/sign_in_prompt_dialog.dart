import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignInPromptDialog extends StatelessWidget {
  final VoidCallback onSignIn;

  SignInPromptDialog({
    @required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) => new SimpleDialog(
        title: const Text('Import books'),
        contentPadding: const EdgeInsets.all(24.0),
        children: <Widget>[
          new Text(
            'You need to be signed in with your Goodreads account in order to import your books.',
          ),
          new RaisedButton(
            onPressed: onSignIn,
            child: new Text('Sign in with Goodreads'),
          ),
        ],
      );
}
