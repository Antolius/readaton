import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/books_list/components/filtering_dialog.dart';
import 'package:readaton/modules/books_list/components/sorting_dialog.dart';

typedef void FilterCallback(ReadingStatus pickedFilter);
typedef void SortCallback(
  BooksSortParam pickedParam,
  SortDirection pickedDirection,
);

class BooksListControls extends StatelessWidget {
  final BooksListPageState currentPage;
  final FilterCallback onFilter;
  final SortCallback onSort;

  BooksListControls({
    Key key,
    @required this.currentPage,
    @required this.onFilter,
    @required this.onSort,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) => new ButtonTheme.bar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
              tooltip: 'Sort',
              icon: const Icon(Icons.sort),
              onPressed: () => showDialog<BooksSort>(
                    context: context,
                    child: new SortingDialog(
                      currentSort: new BooksSort(
                        currentPage.sortBy,
                        currentPage.sortDirection,
                      ),
                    ),
                  )
                      .then(
                    (sort) => sort != null
                        ? onSort(sort.param, sort.direction)
                        : null,
                  ),
            ),
            const Text('Sort'),
            new Expanded(child: new Container()),
            const Text('Filter'),
            new IconButton(
              tooltip: 'Filter',
              icon: const Icon(Icons.filter_list),
              onPressed: () => showDialog<ReadingStatus>(
                    context: context,
                    child: new FilteringDialog(),
                  )
                      .then(onFilter),
            ),
          ],
        ),
      );
}
