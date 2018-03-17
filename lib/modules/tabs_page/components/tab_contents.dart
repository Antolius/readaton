import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';

class TabContents extends StatelessWidget {
  final AppSection currentSection;

  TabContents({
    @required this.currentSection,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentSection) {
      case AppSection.BOOKS:
        return new Container(
          child: new Text(currentSection.toString()),
        );
      case AppSection.GOALS:
        return new Container(
          child: new Text(currentSection.toString()),
        );
      case AppSection.STATS:
        return new Container(
          child: new Text(currentSection.toString()),
        );
    }
    throw new ArgumentError.value(
      currentSection,
      'currentSection',
      'Unsupported AppSection type.',
    );
  }
}
