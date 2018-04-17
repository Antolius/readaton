import 'package:flutter/foundation.dart';

class BooksImportPageState {
  final int currentStep;
  final List<ImportStepState> stepStates;
  final List<bool> accessibility;
  final List<GoodreadsShelf> shelves;
  final List<int> shelvesToImport;

  const BooksImportPageState({
    this.currentStep = 0,
    this.stepStates = const [
      ImportStepState.INCOMPLETE,
      ImportStepState.INCOMPLETE,
      ImportStepState.INCOMPLETE,
    ],
    this.accessibility = const [true, false, false],
    this.shelves = const [],
    this.shelvesToImport = const [],
  });

  BooksImportPageState copyWith({
    int currentStep,
    List<ImportStepState> currentStates,
    List<bool> accessibility,
    List<GoodreadsShelf> shelves,
    List<int> shelvesToImport,
  }) =>
      new BooksImportPageState(
        currentStep: currentStep ?? this.currentStep,
        stepStates: currentStates ?? this.stepStates,
        accessibility: accessibility ?? this.accessibility,
        shelves: shelves ?? this.shelves,
        shelvesToImport: shelvesToImport ?? this.shelvesToImport,
      );
}

enum ImportStepState { INCOMPLETE, LOADING, COMPLETE, ERROR }

class GoodreadsShelf {
  final String name;
  final int platformId;
  final int numberOfBooks;

  const GoodreadsShelf({
    @required this.name,
    @required this.platformId,
    @required this.numberOfBooks,
  });
}
