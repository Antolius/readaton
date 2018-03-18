import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_card/actions/actions.dart';
import 'package:redux/redux.dart';

final reducers = <ReducerBinding<AppState, dynamic>>[
  new ReducerBinding<AppState, UpdateReadingProgressAction>(
    (state, action) {
      final update = new ReadingUpdate(
        madeOn: new DateTime.now(),
        pagesRead: action.newlyReadPagesCount,
      );

      if (state.progressions.containsKey(action.bookId)) {
        state.progressions[action.bookId].updates.add(update);
      } else {
        state.progressions.putIfAbsent(
          action.bookId,
          () => new ReadingProgression(updates: [update]),
        );
      }
      return state;
    },
  ),
];
