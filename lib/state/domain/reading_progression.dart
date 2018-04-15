import 'package:flutter/foundation.dart';

class ReadingProgression {
  final List<ReadingUpdate> updates;

  int get pagesRead => updates.fold(0, (sum, next) => sum + next.pagesRead);

  ReadingProgression({
    @required this.updates,
  });

  ReadingProgression copyWithUpdate({
    @required ReadingUpdate update,
  }) =>
      new ReadingProgression(
        updates: this.updates..add(update),
      );
}

class ReadingUpdate {
  final DateTime madeOn;
  final int pagesRead;

  const ReadingUpdate({
    @required this.madeOn,
    @required this.pagesRead,
  });
}
