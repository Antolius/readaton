import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';

class ReadathonTheme {
  static const Map<AppSection, Color> COLORS = const {
    AppSection.BOOKS: Colors.amber,
    AppSection.GOALS: Colors.deepOrange,
    AppSection.STATS: Colors.teal,
  };

  static final Map<AppSection, ThemeData> themes = {
    AppSection.BOOKS: _themeFor(COLORS[AppSection.BOOKS]),
    AppSection.GOALS: _themeFor(COLORS[AppSection.GOALS]),
    AppSection.STATS: _themeFor(COLORS[AppSection.STATS]),
  };

  static _themeFor(Color swatch) => new ThemeData(
        brightness: Brightness.light,
        primarySwatch: swatch,
      );
}
