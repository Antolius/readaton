import 'package:flutter/foundation.dart';
import 'package:readaton/state/state.dart';

class PickImportBooksStepAction {
  final int newStep;

  const PickImportBooksStepAction(this.newStep);
}

class StartLoadingShelvesAction {
  const StartLoadingShelvesAction();
}

class AddGoodreadsShelvesAction {
  final List<GoodreadsShelf> newShelves;

  const AddGoodreadsShelvesAction(this.newShelves);
}

class SelectShelfForImportAction {
  final int shelfId;

  const SelectShelfForImportAction(this.shelfId);
}

class DeselectShelfForImportAction {
  final int shelfId;

  const DeselectShelfForImportAction(this.shelfId);
}

class FetchBooksPageAction {
  final int page;
  final int pageSize;
  final String shelf;

  const FetchBooksPageAction({
    @required this.shelf,
    this.page = 1,
    this.pageSize = 50,
  });
}

class ImportBooksAction {
  final Map<String, Book> newBooks;
  final Map<String, Author> newAuthors;
  final FetchBooksPageAction fetchedPage;

  const ImportBooksAction({
    @required this.newBooks,
    @required this.fetchedPage,
    this.newAuthors = const {},
  });
}

class CompleteImportAction {
  const CompleteImportAction();
}