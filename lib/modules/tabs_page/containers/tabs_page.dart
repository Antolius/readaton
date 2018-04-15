import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/state/state.dart';
import 'package:readaton/modules/tabs_page/actions/actions.dart';
import 'package:readaton/modules/tabs_page/components/add_to_section_button.dart';
import 'package:readaton/modules/tabs_page/components/bottom_tabs.dart';
import 'package:readaton/modules/tabs_page/components/tab_contents.dart';
import 'package:redux/redux.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => new _ViewModel.from(store),
        builder: (BuildContext context, _ViewModel model) => new Scaffold(
              appBar: new AppBar(
                title: const Text('Readaton'),
              ),
              body: new TabContents(currentSection: model.currentSection),
              bottomNavigationBar: new BottomTabs(
                currentSection: model.currentSection,
                onSectionSelected: model.selectSection,
              ),
              floatingActionButton:
                  new AddToSectionButton(currentSection: model.currentSection),
            ),
      );
}

class _ViewModel {
  final Store<AppState> _store;

  const _ViewModel.from(this._store);

  AppSection get currentSection => _store.state.currentSection;

  selectSection(AppSection newSection) {
    _store.dispatch(new SelectSectionAction(newSection));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          _store == other._store;

  @override
  int get hashCode => _store.hashCode;
}
