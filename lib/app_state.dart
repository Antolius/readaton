class AppState {
  final AppSection currentSection;
  final bool isBooted;

  AppState({
    this.currentSection,
    this.isBooted,
  });

  const AppState.init()
      : currentSection = AppSection.BOOKS,
        isBooted = false;

  AppState copyWith({
    AppSection currentSection,
    bool isBooted,
  }) =>
      new AppState(
        currentSection: currentSection ?? this.currentSection,
        isBooted: isBooted ?? this.isBooted,
      );
}

enum AppSection { BOOKS, GOALS, STATS }
