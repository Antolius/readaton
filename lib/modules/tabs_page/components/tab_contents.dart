import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/state/state.dart';
import 'package:readaton/modules/books_list/books_list.dart';
import 'package:readaton/modules/stats_dashboard/stats_dashboard.dart';

class TabContents extends StatelessWidget {
  final AppSection currentSection;

  TabContents({
    @required this.currentSection,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentSection) {
      case AppSection.BOOKS:
        return new BooksList();
      case AppSection.GOALS:
        return new Container(
          child: new Text(currentSection.toString()),
        );
      case AppSection.STATS:
        return new StatsDashboard();
    }
    throw new ArgumentError.value(
      currentSection,
      'currentSection',
      'Unsupported AppSection type.',
    );
  }
}
