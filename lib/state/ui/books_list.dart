import 'package:quiver/core.dart';

class BooksListPageState {
  final Optional<ReadingStatus> statusFilter;
  final BooksSortParam sortBy;
  final SortDirection sortDirection;

  const BooksListPageState({
    this.statusFilter = const Optional.absent(),
    this.sortBy = BooksSortParam.LAST_READ,
    this.sortDirection = SortDirection.DESC,
  });

  BooksListPageState copyWith({
    Optional<ReadingStatus> statusFilter,
    BooksSortParam sortBy,
    SortDirection sortDirection,
  }) =>
      new BooksListPageState(
        statusFilter: statusFilter ?? this.statusFilter,
        sortBy: sortBy ?? this.sortBy,
        sortDirection: sortDirection ?? this.sortDirection,
      );
}

enum ReadingStatus { UNTOUCHED, READING, FINISHED }

enum BooksSortParam { LAST_READ, FRACTION_DONE }

enum SortDirection { ASC, DESC }