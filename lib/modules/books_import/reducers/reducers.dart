import 'package:readaton/modules/books_import/actions/actions.dart';
import 'package:readaton/services/goodreads/goodreads.dart';
import 'package:readaton/state/state.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, SignInWithGoodreadsAction>(
    (state, _) => state.copyWith(
          booksImportPageState: new BooksImportPageState(
            stepStates: const [
              ImportStepState.LOADING,
              ImportStepState.INCOMPLETE,
              ImportStepState.INCOMPLETE,
            ],
          ),
        ),
  ),
  new ReducerBinding<AppState, AddGoodreadsUserAction>(
    (state, _) => state.copyWith(
          booksImportPageState: new BooksImportPageState(
            stepStates: const [
              ImportStepState.COMPLETE,
              ImportStepState.INCOMPLETE,
              ImportStepState.INCOMPLETE,
            ],
            accessibility: const [true, true, false],
          ),
        ),
  ),
  new ReducerBinding<AppState, SignOutFromGoodreadsAction>(
    (state, _) => state.copyWith(
          booksImportPageState: new BooksImportPageState(),
        ),
  ),
  new ReducerBinding<AppState, PickImportBooksStepAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPage.copyWith(
            currentStep: action.newStep,
          ),
        ),
  ),
  new ReducerBinding<AppState, StartLoadingShelvesAction>(
    (state, _) => state.copyWith(
          booksImportPageState: state.booksImportPage.copyWith(
            stepStates: new List.from(
              state.booksImportPage.stepStates,
            )..[1] = ImportStepState.LOADING,
            shelvesToImport: const [],
          ),
        ),
  ),
  new ReducerBinding<AppState, AddGoodreadsShelvesAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPage.copyWith(
            stepStates: new List.from(
              state.booksImportPage.stepStates,
            )..[1] = ImportStepState.INCOMPLETE,
            shelves: action.newShelves,
          ),
        ),
  ),
  new ReducerBinding<AppState, SelectShelfForImportAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPage.copyWith(
            stepStates: new List.from(
              state.booksImportPage.stepStates,
            )..[1] = ImportStepState.COMPLETE,
            accessibility: [true, true, true],
            shelvesToImport: new List.from(
              state.booksImportPage.shelvesToImport,
            )..add(action.shelfId),
          ),
        ),
  ),
  new ReducerBinding<AppState, DeselectShelfForImportAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPage.copyWith(
            stepStates: new List.from(
              state.booksImportPage.stepStates,
            )..[1] = state.booksImportPage.shelvesToImport.length > 1
                ? ImportStepState.COMPLETE
                : ImportStepState.INCOMPLETE,
            accessibility: [
              true,
              true,
              state.booksImportPage.shelvesToImport.length > 1
            ],
            shelvesToImport: new List.from(
              state.booksImportPage.shelvesToImport,
            )..remove(action.shelfId),
          ),
        ),
  ),
  new ReducerBinding<AppState, FetchBooksPageAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPage.copyWith(
            stepStates: new List.from(
              state.booksImportPage.stepStates,
            )..[2] = ImportStepState.LOADING,
            importedShelves: new List.from(
              state.booksImportPage.importedShelves,
            )..add(action.shelf),
          ),
        ),
  ),
  new ReducerBinding<AppState, CompleteImportAction>(
    (state, _) => state.copyWith(
          booksImportPageState: state.booksImportPage.copyWith(
            currentStep: 2,
            stepStates: const [
              ImportStepState.COMPLETE,
              ImportStepState.COMPLETE,
              ImportStepState.COMPLETE,
            ],
          ),
        ),
  ),
  new ReducerBinding<AppState, ImportBooksAction>(
    (state, action) => state.copyWith(
          books: new Map.from(state.books)..addAll(action.newBooks),
          authors: new Map.from(state.authors)..addAll(action.newAuthors),
          booksImportPageState: state.booksImportPage.copyWith(
            importedBooksCount: state.booksImportPage.importedBooksCount +
                action.newBooks.length,
          ),
        ),
  ),
];
