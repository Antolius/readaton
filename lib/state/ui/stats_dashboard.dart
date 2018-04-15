class StatsDashboardPageState {
  final DataAggregation pagesReadAggregation;

  const StatsDashboardPageState({
    this.pagesReadAggregation = DataAggregation.INDIVIDUAL,
  });

  StatsDashboardPageState copyWith({
    DataAggregation pagesReadAggregation,
  }) =>
      new StatsDashboardPageState(
        pagesReadAggregation: pagesReadAggregation ?? this.pagesReadAggregation,
      );
}

enum DataAggregation { CUMULATIVE, INDIVIDUAL }
