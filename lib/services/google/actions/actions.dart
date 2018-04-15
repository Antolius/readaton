import 'package:readaton/state/state.dart';

class MockAction {
  final Map<String, Book> mockBooks;
  final Map<String, Author> mockAuthors;
  final Map<String, ReadingProgression> mockProgressions;

  const MockAction({
    this.mockBooks = const {},
    this.mockAuthors = const {},
    this.mockProgressions = const {},
  });
}
