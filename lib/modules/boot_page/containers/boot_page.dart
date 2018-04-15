import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:readaton/state/state.dart';
import 'package:readaton/modules/boot_page/boot_page.dart';
import 'package:readaton/modules/boot_page/components/booting_page.dart';
import 'package:redux/redux.dart';

class BootPage extends StatelessWidget {
  final Widget child;

  BootPage({
    @required this.child,
  });

  bool _extractIsBooted(Store<AppState> store) => store.state.isBooted;



  @override
  Widget build(BuildContext context) => new StoreConnector<AppState, bool>(
        onInit: (Store store) => store.dispatch(new BootAppAction()),
        distinct: true,
        converter: _extractIsBooted,
        builder: (context, isBooted) => isBooted ? child : new BootingPage(),
      );
}
