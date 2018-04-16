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
          booksImportPageState: new BooksImportPageState(
            stepStates: const [
              ImportStepState.INCOMPLETE,
              ImportStepState.INCOMPLETE,
              ImportStepState.INCOMPLETE,
            ],
          ),
        ),
  ),
  new ReducerBinding<AppState, PickImportBooksStepAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPageState.copyWith(
            currentStep: action.newStep,
          ),
        ),
  ),
  new ReducerBinding<AppState, StartLoadingShelvesAction>(
    (state, _) => state.copyWith(
          booksImportPageState: state.booksImportPageState.copyWith(
            currentStates: new List.from(
              state.booksImportPageState.stepStates,
            )..[1] = ImportStepState.LOADING,
            shelvesToImport: const [],
          ),
        ),
  ),
  new ReducerBinding<AppState, AddGoodreadsShelvesAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPageState.copyWith(
            currentStates: new List.from(
              state.booksImportPageState.stepStates,
            )..[1] = ImportStepState.INCOMPLETE,
            shelves: action.newShelves,
          ),
        ),
  ),
  new ReducerBinding<AppState, SelectShelfForImportAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPageState.copyWith(
            currentStates: new List.from(
              state.booksImportPageState.stepStates,
            )..[1] = ImportStepState.COMPLETE,
            accessibility: [true, true, true],
            shelvesToImport: new List.from(
              state.booksImportPageState.shelvesToImport,
            )..add(action.shelfId),
          ),
        ),
  ),
  new ReducerBinding<AppState, DeselectShelfForImportAction>(
    (state, action) => state.copyWith(
          booksImportPageState: state.booksImportPageState.copyWith(
            currentStates: new List.from(
              state.booksImportPageState.stepStates,
            )..[1] = state.booksImportPageState.shelvesToImport.length > 1
                ? ImportStepState.COMPLETE
                : ImportStepState.INCOMPLETE,
            accessibility: [
              true,
              true,
              state.booksImportPageState.shelvesToImport.length > 1
            ],
            shelves: new List.from(
              state.booksImportPageState.shelvesToImport,
            )..remove(action.shelfId),
          ),
        ),
  ),
];
