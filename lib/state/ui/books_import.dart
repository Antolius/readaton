import 'package:flutter/foundation.dart';

class BooksImportPageState {
  final int currentStep;
  final List<ImportStepState> stepStates;
  final List<bool> accessibility;
  final List<GoodreadsShelf> shelves;
  final List<int> shelvesToImport;
  final int importedBooksCount;
  final List<String> importedShelves;

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
    this.importedBooksCount = 0,
    this.importedShelves = const [],
  });

  BooksImportPageState copyWith({
    int currentStep,
    List<ImportStepState> stepStates,
    List<bool> accessibility,
    List<GoodreadsShelf> shelves,
    List<int> shelvesToImport,
    int importedBooksCount,
    List<String> importedShelves,
  }) =>
      new BooksImportPageState(
        currentStep: currentStep ?? this.currentStep,
        stepStates: stepStates ?? this.stepStates,
        accessibility: accessibility ?? this.accessibility,
        shelves: shelves ?? this.shelves,
        shelvesToImport: shelvesToImport ?? this.shelvesToImport,
        importedBooksCount: importedBooksCount ?? this.importedBooksCount,
        importedShelves: importedShelves ?? this.importedShelves,
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
