import 'package:readaton/app_state.dart';
import 'package:readaton/services/google/actions/actions.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, MockAction>((state, action) => state.copyWith(
        books: action.mockBooks,
        authors: action.mockAuthors,
        progressions: action.mockProgressions,
      )),
];
