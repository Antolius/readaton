import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/theme.dart';

class BottomTabs extends StatelessWidget {
  final AppSection currentSection;
  final ValueChanged<AppSection> onSectionSelected;

  BottomTabs({
    @required this.currentSection,
    @required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) => new BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentSection.index,
        onTap: (index) => onSectionSelected(AppSection.values[index]),
        items: AppSection.values
            .map((section) => _buildSectionItem(context, section))
            .toList(growable: false),
      );

  BottomNavigationBarItem _buildSectionItem(
      BuildContext context, AppSection section) {
    switch (section) {
      case AppSection.BOOKS:
        return new BottomNavigationBarItem(
          title: const Text('Books'),
          icon: const Icon(Icons.book),
          backgroundColor: ReadathonTheme.COLORS[section],
        );
      case AppSection.GOALS:
        return new BottomNavigationBarItem(
          title: const Text('Goals'),
          icon: const Icon(Icons.flag),
          backgroundColor: ReadathonTheme.COLORS[section],
        );
      case AppSection.STATS:
        return new BottomNavigationBarItem(
          title: const Text('Stats'),
          icon: const Icon(Icons.timeline),
          backgroundColor: ReadathonTheme.COLORS[section],
        );
    }
    throw new ArgumentError.value(
      section,
      'currentSection',
      'Unsupported AppSection type.',
    );
  }
}
