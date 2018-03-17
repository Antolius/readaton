import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';

class AddToSectionButton extends StatelessWidget {
  static final _fabs = {
    AppSection.BOOKS: (BuildContext context) => new FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: 'Add a new book',
          onPressed: () => Navigator.pushNamed(context, '/books/add'),
        ),
    AppSection.GOALS: (BuildContext context) => new FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: 'Add a book',
          onPressed: () => Navigator.pushNamed(context, '/goals/add'),
        ),
    AppSection.STATS: (BuildContext context) => new Container(
          width: 0.0,
          height: 0.0,
        ),
  };

  final AppSection currentSection;

  AddToSectionButton({
    @required this.currentSection,
  });

  @override
  Widget build(BuildContext context) => _fabs[currentSection](context);
}
