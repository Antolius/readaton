import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/middleware.dart';
import 'package:readaton/modules/boot_page/boot_page.dart';
import 'package:readaton/modules/tabs_page/tabs_page.dart';
import 'package:readaton/reducer.dart';
import 'package:readaton/theme.dart';
import 'package:redux/redux.dart';

void main() => runApp(new ReadatonApp());

class ReadatonApp extends StatelessWidget {
  final Store<AppState> _store = new Store<AppState>(
    appStateReducer,
    initialState: const AppState.init(),
    middleware: appMiddleware,
  );

  AppSection _extractCurrentSection(Store<AppState> store) =>
      store.state.currentSection;

  @override
  Widget build(_) => new StoreProvider(
        store: _store,
        child: new StoreConnector<AppState, AppSection>(
          distinct: true,
          converter: _extractCurrentSection,
          builder: (__, currentSection) => new MaterialApp(
                title: 'Readaton',
                theme: ReadathonTheme.themes[currentSection],
                home: new BootPage(
                  childBuilder: (_) => new TabsPage(),
                ),
              ),
        ),
      );
}
