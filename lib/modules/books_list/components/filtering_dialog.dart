import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';

class FilteringDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new SimpleDialog(
        title: const Text('Pick filter'),
        children: <Widget>[
          new SimpleDialogOption(
            child: const Text('All books'),
            onPressed: () => Navigator.pop(context, null),
          ),
          new SimpleDialogOption(
            child: const Text('Only finished books'),
            onPressed: () => Navigator.pop(
                  context,
                  ReadingStatus.FINISHED,
                ),
          ),
          new SimpleDialogOption(
            child: const Text('Only unstarted books'),
            onPressed: () => Navigator.pop(
                  context,
                  ReadingStatus.UNTOUCHED,
                ),
          ),
          new SimpleDialogOption(
            child: const Text('Only books in progress'),
            onPressed: () => Navigator.pop(
                  context,
                  ReadingStatus.READING,
                ),
          ),
        ],
      );
}
