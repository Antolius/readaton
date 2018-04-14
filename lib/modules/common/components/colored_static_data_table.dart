import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiver/core.dart';

@immutable
class StaticDataColumn {
  const StaticDataColumn({
    @required this.label,
    this.tooltip,
  })
      : assert(label != null);

  final Widget label;
  final String tooltip;
}

@immutable
class StaticColoredDataRow {
  const StaticColoredDataRow({
    this.key,
    this.color,
    @required this.cells,
  })
      : assert(cells != null);

  final LocalKey key;
  final Color color;
  final List<DataCell> cells;
}

@immutable
class StaticDataCell {
  const StaticDataCell(this.child) : assert(child != null);

  static final StaticDataCell empty =
      new StaticDataCell(new Container(width: 0.0, height: 0.0));

  final Widget child;
}

class StaticDataTable extends StatelessWidget {
  StaticDataTable({
    Key key,
    List<StaticDataColumn> columns,
    @required this.rows,
  })
      : assert(columns == null || columns.isNotEmpty),
        assert(rows != null),
        assert(columns == null || !rows.any(
            (StaticColoredDataRow row) => row.cells.length != columns.length)),
        columns = new Optional.fromNullable(columns),
        super(key: key);

  final Optional<List<StaticDataColumn>> columns;
  final List<StaticColoredDataRow> rows;

  static final LocalKey _headingRowKey = new UniqueKey();
  static const double _kHeadingRowHeight = 56.0;
  static const double _kDataRowHeight = 36.0;
  static const double _kTablePadding = 24.0;
  static const double _kColumnSpacing = 36.0;
  static const double _kHeadingFontSize = 12.0;
  static const Duration _kSortArrowAnimationDuration =
      const Duration(milliseconds: 150);

  Widget _buildHeadingCell(
      {BuildContext context,
      EdgeInsetsGeometry padding,
      Widget label,
      String tooltip}) {
    label = new Container(
      padding: padding,
      height: _kHeadingRowHeight,
      alignment: AlignmentDirectional.centerStart,
      child: new AnimatedDefaultTextStyle(
        style: new TextStyle(
          // TODO(ianh): font family should match Theme; see https://github.com/flutter/flutter/issues/3116
          fontWeight: FontWeight.w500,
          fontSize: _kHeadingFontSize,
          height: math.min(1.0, _kHeadingRowHeight / _kHeadingFontSize),
          color: (Theme.of(context).brightness == Brightness.light)
              ? Colors.black54
              : Colors.white70,
        ),
        softWrap: false,
        duration: _kSortArrowAnimationDuration,
        child: label,
      ),
    );
    if (tooltip != null) {
      label = new Tooltip(
        message: tooltip,
        child: label,
      );
    }
    return label;
  }

  Widget _buildDataCell({
    BuildContext context,
    EdgeInsetsGeometry padding,
    Widget label,
  }) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    label = new Container(
        padding: padding,
        height: _kDataRowHeight,
        alignment: AlignmentDirectional.centerStart,
        child: new DefaultTextStyle(
          style: new TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.0,
            color: isLightTheme ? Colors.black87 : Colors.white70,
          ),
          child: label,
        ));
    return label;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var border = new Border(bottom: new BorderSide(color: theme.dividerColor));

    final List<TableColumnWidth> tableColumns =
        new List<TableColumnWidth>(rows.first.cells.length);
    final List<TableRow> tableRows = new List<TableRow>.generate(
      rows.length + columns.length,
      (int index) {
        var isHeader = columns.isPresent && index == 0;
        return new TableRow(
            key:  isHeader? _headingRowKey : rows[index - columns.length].key,
            decoration: isHeader
                ? new BoxDecoration(border: border)
                : new BoxDecoration(
                    border: border,
                    color: rows[index - columns.length].color,
                  ),
            children: new List<Widget>(tableColumns.length));
      },
    );

    int displayColumnIndex = 0;
    for (int dataColumnIndex = 0;
        dataColumnIndex < rows.first.cells.length;
        dataColumnIndex += 1) {
      int rowIndex = 0;
      final Optional<StaticDataColumn> column = columns.transform((l) => l[dataColumnIndex]);
      final EdgeInsetsDirectional padding = new EdgeInsetsDirectional.only(
        start:
            dataColumnIndex == 0 ? _kTablePadding / 2.0 : _kColumnSpacing / 2.0,
        end: dataColumnIndex == columns.length - 1
            ? _kTablePadding
            : _kColumnSpacing / 2.0,
      );
      tableColumns[displayColumnIndex] = const IntrinsicColumnWidth(flex: 1.0);
      column.ifPresent((c) {
        tableRows[0].children[displayColumnIndex] = _buildHeadingCell(
          context: context,
          padding: padding,
          label: c.label,
          tooltip: c.tooltip,
        );
        rowIndex = 1;
      });
      for (StaticColoredDataRow row in rows) {
        final DataCell cell = row.cells[dataColumnIndex];
        tableRows[rowIndex].children[displayColumnIndex] = _buildDataCell(
          context: context,
          padding: padding,
          label: cell.child,
        );
        rowIndex += 1;
      }
      displayColumnIndex += 1;
    }

    return new Table(
      columnWidths: tableColumns.asMap(),
      children: tableRows,
    );
  }
}
