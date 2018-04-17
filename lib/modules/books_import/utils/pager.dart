import 'package:readaton/modules/books_import/books_import.dart';
import 'package:readaton/state/state.dart';
import 'package:redux/redux.dart';

bool importCompleted(Store<AppState> store) {
  var pageState = store.state.booksImportPage;
  var totalBooksCount = pageState.shelves
      .where((shelf) => pageState.shelvesToImport.contains(shelf.platformId))
      .fold(0, (count, shelf) => count + shelf.numberOfBooks);
  return pageState.importedBooksCount >= totalBooksCount;
}

bool shelfCompleted(
  Store<AppState> store,
  ImportBooksAction action,
) {
  var page = action.fetchedPage;
  var shelfSize = store.state.booksImportPage.shelves
      .firstWhere((shelf) => shelf.name == page.shelf)
      .numberOfBooks;
  var fetchedBooksCount = page.pageSize * page.page;
  return fetchedBooksCount >= shelfSize;
}

String pickNextShelf(Store<AppState> store) {
  var pageState = store.state.booksImportPage;
  var nextShelf = pageState.shelves
      .where((shelf) => pageState.shelvesToImport.contains(shelf.platformId))
      .map((shelf) => shelf.name)
      .where((shelf) => !pageState.importedShelves.contains(shelf))
      .first;
  return nextShelf;
}
