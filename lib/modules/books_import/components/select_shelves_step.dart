import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/books_import/books_import.dart';
import 'package:readaton/state/state.dart';

Step build(BuildContext context, BooksImportViewModel model) => new Step(
      title: const Text('Pick shelves to import'),
      state: _mapState(model.pageState),
      content: _buildShelvesStep(model),
    );

_mapState(BooksImportPageState state) {
  if (state.currentStep == 1) return StepState.editing;
  if (!state.accessibility[1]) return StepState.disabled;

  switch (state.stepStates[1]) {
    case ImportStepState.COMPLETE:
      return StepState.complete;
    case ImportStepState.ERROR:
      return StepState.error;
    default:
      return StepState.indexed;
  }
}

Widget _buildShelvesStep(BooksImportViewModel model) {
  switch (model.pageState.stepStates[1]) {
    case ImportStepState.LOADING:
      return new _LoadingStep();
    case ImportStepState.ERROR:
      return new _ErrorLoadingShelvesStep(
        onReloadShelves: () {},
      );
    case ImportStepState.INCOMPLETE:
    case ImportStepState.COMPLETE:
    default:
      return new _SelectShelvesStep(model: model);
  }
}

class _SelectShelvesStep extends StatelessWidget {
  final BooksImportViewModel model;

  _SelectShelvesStep({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) => new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: model.pageState.shelves
            .map((shelf) => new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Checkbox(
                      value: model.pageState.shelvesToImport.contains(shelf.platformId),
                      onChanged: (shouldAdd) => shouldAdd
                          ? model.onSelectShelf(shelf.platformId)
                          : model.onDeselectShelf(shelf.platformId),
                    ),
                    new Flexible(
                      child: new Text(
                        'Shelf ${shelf.name} contains ${shelf.numberOfBooks} books',
                        maxLines: 3,
                      ),
                    ),
                  ],
                ))
            .toList(growable: false),
      );
}

class _LoadingStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          const Text('Loading your shelves...'),
          const CircularProgressIndicator(),
        ],
      );
}

class _ErrorLoadingShelvesStep extends StatelessWidget {
  final VoidCallback onReloadShelves;

  _ErrorLoadingShelvesStep({
    @required this.onReloadShelves,
  });

  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          const Text('Error loading yor shelves. Please try again:'),
          new RaisedButton(
            onPressed: onReloadShelves,
            child: const Text('RELOAD'),
          ),
        ],
      );
}
