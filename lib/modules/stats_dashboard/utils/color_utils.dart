import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

charts.Color toChartColor(Color materialColor) => new charts.Color(
  r: materialColor.red,
  g: materialColor.green,
  b: materialColor.blue,
  a: materialColor.alpha,
);