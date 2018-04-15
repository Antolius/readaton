class BooksImportPageState {
  final int currentStep;
  final List<int> availableSteps;
  final List<int> completedSteps;
  final Map<String, String> shelves;
  final List<String> pickedShelves;

  const BooksImportPageState({
    this.currentStep = 0,
    this.availableSteps = const [0],
    this.completedSteps = const [],
    this.shelves = const {},
    this.pickedShelves = const [],
  });

  BooksImportPageState copyWith({
    int currentStep,
    List<int> availableSteps,
    List<int> completedSteps,
    Map<String, String> shelves,
    List<String> pickedShelves,
  }) =>
      new BooksImportPageState(
        currentStep: currentStep ?? this.currentStep,
        availableSteps: availableSteps ?? this.availableSteps,
        completedSteps: completedSteps ?? this.completedSteps,
        shelves: shelves ?? this.shelves,
        pickedShelves: pickedShelves ?? this.pickedShelves,
      );
}
