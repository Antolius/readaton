import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProgressUpdateSpiral extends StatefulWidget {
  final int maximumValue;
  final int initialValue;

  ProgressUpdateSpiral({
    @required this.maximumValue,
    @required this.initialValue,
  });

  @override
  _ProgressUpdateSpiralState createState() {
    return new _ProgressUpdateSpiralState();
  }
}

class _ProgressUpdateSpiralState extends State<ProgressUpdateSpiral> {
  int _value;

  int get value => _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => new Container(
    constraints: const BoxConstraints(
      minWidth: 200.0,
      minHeight: 200.0,
    ),
    child: new GestureDetector(
      onPanUpdate: (DragUpdateDetails update) {
        final size = MediaQuery.of(context).size;
        var cx = size.width / 2;
        var cy = size.height / 2;
        var p = update.globalPosition;
        print('\t${- atan2(cx - p.dx, cy - p.dy) / PI}');
      },
      child: new CustomPaint(
        painter: new _SpiralPainter(_value),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('$_value'),
              new Text('${_percentOf()}%'),
            ],
          ),
        ),
      ),
    ),
  );

  int _percentOf() => (100.0 * _value / widget.maximumValue).ceil();
}

class _SpiralPainter extends CustomPainter {
  final int _current;

  _SpiralPainter(this._current);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();

    int circleIndex = 1;
    while (_current - circleIndex * 100 > 0) {
      path.addOval(
        new Rect.fromCircle(
          center: new Offset(100.0, 100.0),
          radius: 110.0 - 10.0 * circleIndex,
        ),
      );
      circleIndex++;
    }
    path.addArc(
      new Rect.fromCircle(
        center: new Offset(100.0, 100.0),
        radius: 110.0 - 10.0 * circleIndex,
      ),
      PI * 3 / 2,
      2 * PI * ((_current % 100) / 100),
    );

    canvas.drawPath(
      path,
      new Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.deepPurpleAccent
        ..strokeWidth = 10.0,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
