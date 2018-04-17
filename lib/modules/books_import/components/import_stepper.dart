import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/books_import/components/import_books_step.dart'
    as ImportBooksStep;
import 'package:readaton/modules/books_import/components/select_shelves_step.dart'
    as SelectShelvesStep;
import 'package:readaton/modules/books_import/components/sign_in_step.dart'
    as SignInStep;
import 'package:readaton/modules/books_import/containers/books_import_page.dart';
import 'package:readaton/state/state.dart';

class ImportStepper extends StatelessWidget {
  final BooksImportViewModel model;
  final BooksImportPageState _state;

  ImportStepper({
    @required this.model,
  })
      : _state = model.pageState;

  int get _nextStep => _state.currentStep + 1;

  bool get _canContinue =>
      _nextStep < 3 && _state.accessibility[_nextStep] ||
      _state.stepStates[2] == ImportStepState.COMPLETE;

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: const Text('Goodreads import'),
        ),
        body: new Stepper(
          type: _determineType(context),
          currentStep: _state.currentStep,
          onStepCancel: () => _isLoading() ? null : _onCancelImport(context),
          onStepContinue: _canContinue ? () => _onStepContinue(context) : null,
          onStepTapped: model.onPickStep,
          steps: <Step>[
            SignInStep.build(context, model),
            SelectShelvesStep.build(context, model),
            ImportBooksStep.build(context, model),
          ],
        ),
      );

  StepperType _determineType(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait
          ? StepperType.vertical
          : StepperType.horizontal;

  _onCancelImport(BuildContext context) {
    Navigator.pop(context);
    model.onCancelImport();
  }

  void _onStepContinue(BuildContext context) {
    if (_nextStep == 3) {
      Navigator.pop(context);
    } else {
      model.onPickStep(_nextStep);
    }
  }

  _isLoading() => _state.stepStates.contains(ImportStepState.LOADING);
}
