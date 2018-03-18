import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReadingProgress extends StatelessWidget {
  final double readFraction;

  ReadingProgress({
    @required this.readFraction,
  });

  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          new Container(
            constraints: const BoxConstraints(
              minWidth: 36.0,
              minHeight: 36.0,
            ),
            child: new CustomPaint(
              painter: new _ArcPainter(
                arcFraction: readFraction,
                backColor: Theme.of(context).backgroundColor,
                frontColor: Theme.of(context).accentColor,
                radius: 18.0,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Text('${(readFraction * 100).ceil()}% done'),
          )
        ],
      );
}

class _ArcPainter extends CustomPainter {
  final double arcFraction;
  final Color backColor;
  final Color frontColor;
  final double radius;

  _ArcPainter({
    @required this.arcFraction,
    @required this.backColor,
    @required this.frontColor,
    @required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      new Offset(radius, radius),
      18.0,
      new Paint()..color = backColor,
    );
    canvas.drawArc(
      Offset.zero & new Size.fromRadius(radius),
      PI * 3 / 2,
      2 * PI * arcFraction,
      true,
      new Paint()..color = frontColor,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter previous) =>
      previous.arcFraction != arcFraction;
}
