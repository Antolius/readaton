import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/books_import/books_import.dart';
import 'package:readaton/state/state.dart';

Step build(BuildContext context, BooksImportViewModel model) => new Step(
      title: const Text('Import books'),
      state: _mapState(model.pageState),
      content: _buildShelvesStep(model),
    );

_mapState(BooksImportPageState state) {
  if (state.currentStep == 2) return StepState.editing;
  if (!state.accessibility[2]) return StepState.disabled;

  switch (state.stepStates[2]) {
    case ImportStepState.COMPLETE:
      return StepState.complete;
    case ImportStepState.ERROR:
      return StepState.error;
    default:
      return StepState.indexed;
  }
}

Widget _buildShelvesStep(BooksImportViewModel model) {
  var state = model.pageState;
  switch (state.stepStates[2]) {
    case ImportStepState.LOADING:
      return new _LoadingStep(
        importedCount: model.pageState.importedBooksCount,
        totalCount: _totalBooksCount(state),
      );
    case ImportStepState.ERROR:
      return new _ErrorLoadingShelvesStep();
    case ImportStepState.INCOMPLETE:
      return new _InitImportBooksStep(
        onImport: model.onStartImport,
        totalBooksCount: _totalBooksCount(state),
      );
    case ImportStepState.COMPLETE:
    default:
      return new _ImportSuccessStep();
  }
}

class _InitImportBooksStep extends StatelessWidget {
  final int totalBooksCount;
  final VoidCallback onImport;

  _InitImportBooksStep({
    @required this.totalBooksCount,
    @required this.onImport,
  });

  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          new Text('Import $totalBooksCount books?'),
          new RaisedButton(
            onPressed: onImport,
            child: const Text('IMPORT'),
          ),
        ],
      );
}

class _ImportSuccessStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          new Icon(
            Icons.sentiment_very_satisfied,
            color: Theme.of(context).accentColor,
            size: 48.0,
          ),
          new Text('Successfully imported your books!'),
        ],
      );
}

class _LoadingStep extends StatelessWidget {
  final int totalCount;
  final int importedCount;

  _LoadingStep({
    @required this.totalCount,
    @required this.importedCount,
  });

  @override
  Widget build(BuildContext context) {
    var progress = (importedCount + totalCount * 0.1) / (totalCount * 1.1);
    return new Column(
      children: <Widget>[
        const Text('Importing books...'),
        new LinearProgressIndicator(
          value: progress,
        ),
      ],
    );
  }
}

class _ErrorLoadingShelvesStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          const Text('Error importing books. Please try again:'),
        ],
      );
}

int _totalBooksCount(BooksImportPageState state) {
  return state.shelves
      .where((shelf) => state.shelvesToImport.contains(shelf.platformId))
      .fold(0, (sum, shelf) => sum + shelf.numberOfBooks);
}
